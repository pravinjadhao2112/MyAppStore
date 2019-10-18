//
//  ErrorResponce.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation

import Foundation
public struct ErrorResponse : Codable {
    public var errors : [String : [String]]?
    public var errorMessages : [String]?
    
    public enum CodingKeys: String, CodingKey {

        case errors = "errors"
    }
    
    init(messages : [String]) {
        self.errorMessages = messages
        errors = [:]
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        errors = try values.decodeIfPresent([String : [String]].self, forKey: .errors)

        if let e = errors{
           let array =  Array(e.keys).sorted()
            if(array.count > 0){
                errorMessages = e[array[0]]
            }
        }
    }

}
