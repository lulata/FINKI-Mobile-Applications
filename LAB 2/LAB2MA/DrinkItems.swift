//
//  DrinkItems.swift
//  LAB2MA
//
//  Created by David Atanasoski on 15.9.23.
//


import UIKit

class DrinkViewItems: UIViewController, UITableViewDataSource, UITableViewDelegate

{
  
    
    @IBOutlet weak var drinkTableView: UITableView!
    var items = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialization code
        initList()
    }

 



    func initList(){
        let whiskey = Item(name: "Whiskey", img:  "whiskey", desc: "Some desc.")
        items.append(whiskey)
        let mohito = Item(name: "Mohito", img:  "mohito", desc: "Some desc.")
        items.append(mohito)
        let wine = Item(name: "Wine", img:  "wine", desc: "Some desc.")
        items.append(wine)
    }

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DrinkViewItems"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCellDrinks
        
        let foodItem = items[indexPath.row]
        
        cell.name.text = foodItem.name
        cell.img.image =  UIImage(named: foodItem.img)
        cell.desc.text = foodItem.desc

        
        return cell
    }
    
    
}
