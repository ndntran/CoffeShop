//
//  OrderDetail.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

enum OrderDetailStatus: Int{
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

class OrderDetail: Decodable{
    var idOrderDetail: Int
//    var idOrder: Int
    var idDrink: Int
    var drinkName: String
    var price: Int
    var image: String?
    var amount: Int
    var status: OrderDetailStatus
    
    enum CodingKeys: String, CodingKey{
        case idOrderDetail = "od_id"
        case idDrink = "od_drink"
        case drinkName = "drink_name"
        case price = "drink_price"
        case image = "drink_image"
        case amount = "od_amount"
        case status = "od_status"
    }
    
//    init(idOrderDetail: String, idOrder: String, idDrink: String, amount: Int){
//        self.idOrderDetail = idOrderDetail
//        self.idOrder = idOrder
//        self.idDrink = idDrink
//        self.amount = amount
//    }
//
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idOrderDetail = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.idOrderDetail)
        self.idDrink = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.idDrink)
        self.drinkName = try! valueContainer.decode(String.self, forKey: OrderDetail.CodingKeys.drinkName)
        self.price = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.price)
        self.image = try? valueContainer.decode(String.self, forKey: OrderDetail.CodingKeys.image)
        self.amount = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.amount)
        self.status = OrderDetailStatus.finished
    }
}
