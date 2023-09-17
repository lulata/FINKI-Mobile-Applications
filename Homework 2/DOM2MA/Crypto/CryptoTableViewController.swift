

import UIKit
import SwiftyJSON

class CryptoTableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    var CryptoList = [Crypto]()
    
    var urlCrypto = "https://api.coingecko.com/api/v3/exchange_rates"

    @IBOutlet weak var CurrencyTableView: UITableView!
//    struct Rates: Decodable {
//        let rates: Currency
//    }
//
//    struct Currency: Decodable {
//        let cryptos: [Cryptoo]
//        
//        // Define DynamicCodingKeys type needed for creating
//        // decoding container from JSONDecoder
//        private struct DynamicCodingKeys: CodingKey {
//
//            // Use for string-keyed dictionary
//            var stringValue: String
//            init?(stringValue: String) {
//                self.stringValue = stringValue
//            }
//
//            // Use for integer-keyed dictionary
//            var intValue: Int?
//            init?(intValue: Int) {
//                // We are not using this, thus just return nil
//                return nil
//            }
//        }
//        
//        init(from decoder: Decoder) throws {
//
//            // 1
//            // Create a decoding container using DynamicCodingKeys
//            // The container will contain all the JSON first level key
//            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//            
//            
//            var tempArray = [Cryptoo]()
//
//            // 2
//            // Loop through each key (student ID) in container
//            for key in container.allKeys {
//                
//                // Decode Student using key & keep decoded Student object in tempArray
//                let decodedObject = try container.decode(Cryptoo.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
//                tempArray.append(decodedObject)
//            }
//
//            // 3
//            // Finish decoding all Student objects. Thus assign tempArray to array.
//            cryptos = tempArray
//        }
//    }
//    
//    struct Cryptoo: Decodable {
//        let name: String
//        let unit: String
//        let value: Double
//        let type: String
//    }
    
    func fetchData() {
        let url = URL(string: urlCrypto)
        let defaultSession = URLSession(configuration: .default)
        let dataTask = defaultSession.dataTask(with: url!) {
           (data: Data?,response: URLResponse?,error: Error?) in
            
            if (error != nil) {
                print(error ?? "error")
                return
            }
            
//            do {
//                let json = try JSONDecoder().decode(Rates.self, from: data!)
//                self.setPrices(rates: json.rates)
//
//            } catch {
//                print(error)
//                return
//            }
            
            if let data = data {
                let json = JSON(data)
                self.setPrices(json: json)
            }
        }
        
        return dataTask.resume()
    }
    
//    func setPrices(rates: Currency){
//
//        DispatchQueue.main.async {
//
//            for item in rates.cryptos {
//                let item2 = Crypto(currency_name: item.name, price: String(format: "%.4f", item.value));
//                self.CryptoList.append(item2)
//            }
//
//            self.CurrencyTableView.reloadData()
//        }
//    }
    func setPrices(json: JSON) {
        DispatchQueue.main.async {
            if let cryptos = json["rates"].dictionary {
                for (key, value) in cryptos {
                    let name = key
                    let unit = value["unit"].stringValue
                    let cryptoValue = value["value"].doubleValue
                    let type = value["type"].stringValue

                    let item = Crypto(currency_name: name, price: String(format: "%.4f", cryptoValue))
                    self.CryptoList.append(item)
                }

                self.CurrencyTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }


    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell_ID") as! CryptoTableViewCell
        
        let currentCrypto = CryptoList[indexPath.row]
        
        tableViewCell.currency_name.text = currentCrypto.currency_name
        tableViewCell.price.text = currentCrypto.price
        
        return tableViewCell
    }
    
    
    

}

