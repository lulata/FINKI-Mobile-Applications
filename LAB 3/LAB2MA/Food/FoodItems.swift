//
//  FoodItems.swift
//  LAB2MA
//
//  Created by David Atanasoski on 15.9.23.
//

import UIKit



class FoodViewItems: UITableViewController
    
{
  
    
    @IBOutlet weak var foodTableView: UITableView!
    var foodItems = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialization code
        initList()
    }

 



    func initList(){
        let salad = Item(name: "Salad", img:  "salat", desc: "Some desc.")
        foodItems.append(salad)
        let dish = Item(name: "Dish", img:  "dish", desc: "Some desc.")
        foodItems.append(dish) 
        let cake = Item(name: "Cake", img:  "cake", desc: "Some desc.")
        foodItems.append(cake)
    }

        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodViewItems"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        let foodItem = foodItems[indexPath.row]
        
        cell.foodName.text = foodItem.name
        cell.foodImage.image =  UIImage(named: foodItem.img)

        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            self.performSegue(withIdentifier: "foodDetailLink", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if(segue.identifier == "foodDetailLink")
            {
                let indexPath = self.foodTableView.indexPathForSelectedRow!
                
                let tableViewDetail = segue.destination as? FoodViewDetail
                
                let selectedFood = foodItems[indexPath.row]
                
                tableViewDetail!.selectedFood = selectedFood
                
                self.foodTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    
    
}
