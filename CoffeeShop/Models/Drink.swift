//
//  Drink.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

class Drink: Codable{
    var idDrink: Int = 0
    var name: String = ""
    var price: Int = 0
    var image: String = ""
    
    
    enum CodingKeys: String, CodingKey{
        case idDrink = "drink_id"
        case name = "drink_name"
        case price = "drink_price"
        case image = "drink_image"
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idDrink = try! valueContainer.decode(Int.self, forKey: Drink.CodingKeys.idDrink)
        self.name = try! valueContainer.decode(String.self, forKey: Drink.CodingKeys.name)
        self.price = try! valueContainer.decode(Int.self, forKey: Drink.CodingKeys.price)
        self.image = try! valueContainer.decode(String.self, forKey: Drink.CodingKeys.image)
    }
}
