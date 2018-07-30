//
//  DrinkViewController.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/15/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import UIKit

class DrinkVC: UITableViewController {
    fileprivate let CustomIdentifiedKey = "DrinkCell"
    var drinkList = [Drink]()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinkList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomIdentifiedKey, for: indexPath) as! DrinkViewCell
        
        if indexPath.section == 0 {
            cell.lblDrinkName?.text = drinkList[indexPath.row].name
            cell.lblDrinkName?.text = drinkList[indexPath.row].name
        }
        
        return cell
    }
}
