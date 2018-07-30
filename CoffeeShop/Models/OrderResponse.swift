//
//  OrderResponse.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/29/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation
class OrderResponse: Decodable {
    var idOrder: Int
    var listDrink: [OrderDetail]
    
    enum CodingKeys: String, CodingKey{
        case idOrder = "order_id"
        case listDrink = "listDrink"
    }
    
    init(){
        fatalError()
    }
}

