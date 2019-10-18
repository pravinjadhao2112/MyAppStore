//
//  AppInfoModel.swift
//  AppStore
//
//  Created by Pravin Jadhao on 17/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import Foundation

public struct AppInfoModel  {
  var id: Int?
  var name: String?
  var category: String?
  var imageUrl: String?
  var price: String?
  var artist: String?
  var link: String?
  var rights: String?
  var releaseDate: String?
    
    init()
    {}
    init(info : Entry) {
    
        self.id = info.id?.attributes?.id
        self.name = info.name?.label
        self.category = info.category?.attributes?.label
        self.artist = info.artist?.label
        self.link = info.link?.attributes?.href
        self.rights = info.rights?.label
        self.releaseDate = info.releaseDate?.attributes?.label
        
        if let count = info.image?.count, count  > 0
        {
            self.imageUrl = info.image?[count-1].label
        }
        
        self.price = "Free"
       if let price = info.price?.attributes?.amount, let priceAmount = Double(price), priceAmount != 0.0 ,
        let currency = info.price?.attributes?.currency
       {
           self.price =  price + " " + currency
       }
    }
    
    func getInfoAsDictonary() -> [String : AnyObject]
    {
        var info = [String : AnyObject]()
        
        info["id"] = self.id as AnyObject
        info["name"] = self.name as AnyObject
        info["category"] = self.category as AnyObject
        info["imageUrl"] = self.imageUrl as AnyObject
        info["price"] = self.price as AnyObject
        info["artist"] = self.artist as AnyObject
        info["link"] = self.link as AnyObject
        info["rights"] = self.rights as AnyObject
        info["releaseDate"] = self.releaseDate as AnyObject
        return info
    }
}
