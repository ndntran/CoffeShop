//
//  OrderDetail.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

enum OrderDetailStatus: Int,Codable{
    case new = 0
    case waitForServe = 1 // chờ phục vụ
    case finished = 2 // đã order
    
    func description() -> String{
        switch self {
        case .new:
            return "Mới"
        case .waitForServe:
            return "Chờ pha chế"
        case .finished:
            return "Đã hoàn thành"
        }
    }
}

class OrderDetail: Codable{
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
    
    init(idOrderDetail: Int, idDrink: Int, drinkName: String, price: Int, image: String?, amount: Int, status: OrderDetailStatus){
        self.idOrderDetail = idOrderDetail
        self.idDrink = idDrink
        self.drinkName = drinkName
        self.price = price
        self.image = image
        self.amount = amount
        self.status = .waitForServe
    }
//
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idOrderDetail = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.idOrderDetail)
        self.idDrink = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.idDrink)
        self.drinkName = try! valueContainer.decode(String.self, forKey: OrderDetail.CodingKeys.drinkName)
        self.price = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.price)
        self.image = try? valueContainer.decode(String.self, forKey: OrderDetail.CodingKeys.image)
        self.amount = try! valueContainer.decode(Int.self, forKey: OrderDetail.CodingKeys.amount)
        self.status = OrderDetailStatus.waitForServe
    }
}
