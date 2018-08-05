//
//  Date.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 8/5/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation
extension Date{
    func toString(formatString: String)-> String{
        let formater = DateFormatter()
        formater.dateFormat = formatString
        
        return formater.string(from: self)
    }
}
