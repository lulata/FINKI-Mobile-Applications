//
//  FoodItems.swift
//  LAB2MA
//
//  Created by David Atanasoski on 15.9.23.
//

import UIKit



class FoodViewItems: UIViewController, UITableViewDataSource, UITableViewDelegate
    
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

        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodViewItems"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        
        let foodItem = foodItems[indexPath.row]
        
        cell.foodName.text = foodItem.name
        cell.foodImage.image =  UIImage(named: foodItem.img)
        cell.foodDescription.text = foodItem.desc

        
        return cell
    }
    
    
}
