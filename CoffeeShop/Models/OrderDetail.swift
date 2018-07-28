//
//  OrderDetail.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation
class OrderDetail{
    var idOrderDetail: String
    var idOrder: String
    var idDrink: String
    var amount: Int
    
    init(idOrderDetail: String, idOrder: String, idDrink: String, amount: Int){
        self.idOrderDetail = idOrderDetail
        self.idOrder = idOrder
        self.idDrink = idDrink
        self.amount = amount
    }
}
