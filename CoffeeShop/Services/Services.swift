//
//  Services.swift
//  CoffeeShop
//
//  Created by Nguyen Thanh Trung on 7/16/18.
//  Copyright © 2018 Nguyen Doan Nhu Tran. All rights reserved.
//

import Foundation
class Services{
    var scheme: String = "https"
    var host: String = "api.nasa.gov"
    var path: String = "/planetary/apod"
    var queryList: [String: String] = [:]
    var component: URLComponents = URLComponents()
    
    func buildURL() -> URL?{
        component.scheme = scheme
        component.host = host
        component.path = path
        
        var qList: [URLQueryItem] = []
        for q in queryList{
            let queryItem = URLQueryItem(name: q.key, value: q.value)
            qList.append(queryItem)
        }
        
        component.queryItems = qList
        return component.url
    }
    
    func addQuery(key: String, value: String)-> Services {
        queryList[key] = value
        return self
    }
    
    func changePath(path: String) -> Services{
        component.path = path
        return self
    }
    
    func changeScheme(scheme: String) -> Services{
        component.scheme = scheme
        return self
    }
    
    func removeQuery(key: String) -> Services{
        queryList.removeValue(forKey: key)
        return self
    }
}

