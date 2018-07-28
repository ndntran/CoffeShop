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

class Table{
    var idTable: Int
    var name: String
    var status: TableStatus
    
    init(idTable: Int, name: String, status: TableStatus){
        self.idTable = idTable
        self.name = name
        self.status = .free
    }
}
