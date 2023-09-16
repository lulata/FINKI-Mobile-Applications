//
//  DrinkItems.swift
//  LAB2MA
//
//  Created by David Atanasoski on 15.9.23.
//


import UIKit

class DrinkViewItems: UITableViewController

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

        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DrinkViewItems"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCellDrinks
        
        let foodItem = items[indexPath.row]
        
        cell.name.text = foodItem.name
        cell.img.image =  UIImage(named: foodItem.img)

        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            self.performSegue(withIdentifier: "drinkDetailLink", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if(segue.identifier == "drinkDetailLink")
            {
                let indexPath = self.drinkTableView.indexPathForSelectedRow!
                
                let tableViewDetail = segue.destination as? DrinkViewDetail
                
                let selected = items[indexPath.row]
                
                tableViewDetail!.selected = selected
                
                self.drinkTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
}
