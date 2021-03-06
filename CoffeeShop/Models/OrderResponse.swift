//
//  OrderResponse.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/29/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

enum OrderStatus: Int, Codable{
    case new = 0
    case finished = 1
//    case ordered = 1 // đã order
//    case waitForServe = 2 // chờ phục vụ
    
    func description() -> String{
        switch self {
//        case .ordered:
//            return "Đã order"
//        case .waitForServe:
//            return "Chờ pha chế"
            
        case .new:
            return "Mới"
            
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
    var listDrink: [OrderDetail]?
    
    enum CodingKeys: String, CodingKey{
        case idOrder = "order_id"
        case idTable = "order_table"
        case orderDate = "order_date"
        case orderStatus = "order_status"
        case listDrink = "drink"
    }
    
    init(idOrder: Int?, idTable: Int, orderDate: String, orderStatus: OrderStatus, listDrink: [OrderDetail]){
//        fatalError()
        self.idOrder = idOrder
        self.idTable = idTable
        self.orderDate = orderDate
        self.orderStatus = orderStatus
        self.listDrink = listDrink
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idOrder = try? valueContainer.decode(Int.self, forKey: OrderResponse.CodingKeys.idOrder)
        self.idTable = 0
        self.orderDate = ""
        self.orderStatus = .finished
        self.listDrink = try? valueContainer.decode([OrderDetail].self, forKey: OrderResponse.CodingKeys.listDrink)
    }
}

