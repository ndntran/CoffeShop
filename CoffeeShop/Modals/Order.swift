//
//  Order.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

enum OrderStatus: Int{
    case finished = 0
    case ordered = 1 // đã order
    case waitForServe = 2 // chờ phục vụ
    
    func description() -> String{
        switch self {
        case .ordered:
            return "Đã order"
        case .waitForServe:
            return "Chờ pha chế"
        case .finished:
            return "Đã hoàn thành"
        }
    }
}

class Order{
    var idOrder: String
    var idTable: String
    var dateOrder: String
    var hourOrder: Int
    var minuteOrder: Int
    var status: OrderStatus
    
    init(idOrder: String, idTable: String, dateOrder: String, hourOrder: Int, minuteOrder: Int, status: OrderStatus){
        self.idOrder = idOrder
        self.idTable = idTable
        self.dateOrder = dateOrder
        self.hourOrder = hourOrder
        self.minuteOrder = minuteOrder
        self.status = .finished
    }
}
