//
//  Int.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/30/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation

extension Int{
    func toCurrencyString()->String?{
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.maximumFractionDigits = 0
        return nf.string(from: self as NSNumber )
    }
}

