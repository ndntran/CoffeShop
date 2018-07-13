//
//  ViewController.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var listOfTable = [Table]()
    var listOfDrink = [Drink]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        initTable()
        initDrink()
        // Dispose of any resources that can be recreated.
    }

    func initTable(){
        let table1 = Table(idTable: "01", name: "Bàn 01", status: .free)
        listOfTable.append(table1)
        
        let table2 = Table(idTable: "02", name: "Bàn 02", status: .free)
        listOfTable.append(table2)
        
        let table3 = Table(idTable: "03", name: "Bàn 03", status: .free)
        listOfTable.append(table3)
        
        let table4 = Table(idTable: "04", name: "Bàn 04", status: .free)
        listOfTable.append(table4)
        
        let table5 = Table(idTable: "05", name: "Bàn 05", status: .free)
        listOfTable.append(table5)
        
        let table6 = Table(idTable: "06", name: "Bàn 06", status: .free)
        listOfTable.append(table6)
        
        let table7 = Table(idTable: "07", name: "Bàn 07", status: .free)
        listOfTable.append(table7)
        
        let table8 = Table(idTable: "08", name: "Bàn 08", status: .free)
        listOfTable.append(table8)
        
        let table9 = Table(idTable: "09", name: "Bàn 09", status: .free)
        listOfTable.append(table9)
        
        let table10 = Table(idTable: "10", name: "Bàn 10", status: .free)
        listOfTable.append(table10)
    }
    
    func initDrink(){
        let drink1 = Drink(idDrink: "01", name: "Cafe đen", price: 10000)
        listOfDrink.append(drink1)
        
        
        let drink2 = Drink(idDrink: "02", name: "Cafe đá", price: 15000)
        listOfDrink.append(drink2)
        
        let drink3 = Drink(idDrink: "03", name: "Cafe sữa", price: 18000)
        listOfDrink.append(drink3)
        
        let drink4 = Drink(idDrink: "04", name: "Lipton", price: 12000)
        listOfDrink.append(drink4)
        
        let drink5 = Drink(idDrink: "05", name: "Chanh muối", price: 12000)
        listOfDrink.append(drink5)
    }
}

