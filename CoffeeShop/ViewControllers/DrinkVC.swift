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
    var drinkSelected: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initServices()
    }
    
    func initServices(){
        let tableServices = Services()
        if let drinkURL = tableServices.changePath(path: "/ios/public/api/drink").buildURL(){
            getDrink(url: drinkURL,
                     success: {drink in
                        
                        dump(drink)
                        DispatchQueue.main.async {
                            //                           print(table[0].name)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            self.drinkList = drink
                            self.tableView.reloadData()
                        }
            }
                ,onError: {})
            print(drinkURL)
        }
    }
    
    func getDrink(url: URL, success: @escaping ([Drink])-> Void, onError: @escaping () -> Void) {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            let decoder = JSONDecoder()
            
            if let data = data {
                                let strData = String(data: data, encoding: .utf8)
                                print(strData)
                if let respone = try? decoder.decode([Drink].self, from: data){
                    success(respone)
                    return
                }
            }
        }
        // network indicator ON
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        task.resume()
    }
    
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
            cell.lblDrinkPrice?.text = drinkList[indexPath.row].price.toCurrencyString()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        drinkSelected = drinkList[indexPath.row]
        performSegue(withIdentifier: "unWindTableDetail", sender: self)
    }
}
