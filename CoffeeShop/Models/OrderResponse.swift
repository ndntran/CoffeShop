//
//  OrderResponse.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/29/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

enum OrderStatus: Int, Codable{
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

class OrderResponse: Codable {
    var idOrder: Int?
    var idTable: Int
    var orderDate: String
    var orderStatus: OrderStatus
    var listDrink: [OrderDetail]
    
    enum CodingKeys: String, CodingKey{
        case idOrder = "order_id"
        case idTable = "order_table"
        case orderDate = "order_date"
        case orderStatus = "order_status"
        case listDrink = "listDrink"
    }
    
    init(idOrder: Int?, idTable: Int, orderDate: String, orderStatus: OrderStatus, listDrink: [OrderDetail]){
//        fatalError()
        self.idOrder = idOrder
        self.idTable = idTable
        self.orderDate = orderDate
        self.orderStatus = orderStatus
        self.listDrink = listDrink
    }
}

