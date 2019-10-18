//
//  WebConstants.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import Foundation
import Alamofire


public struct WebConstants {
    private init(){}
    
    public struct AppInfo {
        
        public struct getAppInformation {
            static let path = "us/rss/newfreeapplications/limit=2/json"
            static let method = HTTPMethod.get
            static let headers : HTTPHeaders  =  [:]
        }
    }
}
