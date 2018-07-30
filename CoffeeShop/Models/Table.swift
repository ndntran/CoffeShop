//
//  Table.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 13/07/2018.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

enum TableStatus: Int{
    case free = 0 // bàn trống
    case noFree = 1 // không trống
    //    case ordered = 1 // đã order thức uống
    //    case waitForServe = 2 //chờ phục vụ thức uống
    //    case waitForPay = 3 // chờ thanh toán
    
    func description() -> String{
        switch self{
        case .free:
            return "Bàn trống"
            
        case .noFree:
            return "Có người"
            //            case .ordered:
            //                return "Đã order"
            //            case .waitForServe:
            //                return "Đang chờ thức uống"
            //            case .waitForPay:
            //                return "Chờ thanh toán"
        }
    }
}

class Table: Decodable{
    var idTable: Int
    var name: String
    var status: TableStatus
 
    enum CodingKeys: String, CodingKey{
        case idTable = "table_id"
        case name = "table_name"
        case status = "table_status"
    }
    
    init(_ idTable: Int, _ name: String, _ status: TableStatus){
        self.idTable = idTable
        self.name = name
        self.status = TableStatus.free
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idTable = try! valueContainer.decode(Int.self, forKey: Table.CodingKeys.idTable)
        self.name = try! valueContainer.decode(String.self, forKey: Table.CodingKeys.name)
//        self.status = TableStatus(rawValue: try! valueContainer.decode(Int.self, forKey: Table.CodingKeys.status))!
        self.status = .free
     }
}

