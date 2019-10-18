//
//  MyAppStoreListLocalDataManager.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

class MyAppStoreListLocalDataManager:MyAppStoreListLocalDataManagerProtocol {
    
    func saveAppInformation(appInfo : [AppInfoModel]) {
        let databaseHandler :  DataBaseHandler = DataBaseHandler.sharedInstance()
        
        appInfo.forEach { info in
            let appDB = databaseHandler.createManagedObject(tableName: "AppInforamation") as? AppInforamation
            appDB?.addData(inData:info.getInfoAsDictonary())
        }
        _ = databaseHandler.saveContext()
    }
    
    func fetchAppInformation() -> [AppInfoModel]{
        let databaseHandler :  DataBaseHandler = DataBaseHandler.sharedInstance()
        let values = databaseHandler.fetchData(tableName: "AppInforamation", predicate: nil, sortDiscriptor: nil)
        var appsInfo = [AppInfoModel]()
        if(values != nil && values!.count > 0){
            values?.forEach({ (dataBaseModel) in
                var infomodel = AppInfoModel()
                infomodel.id =           Int(dataBaseModel.id)
                infomodel.name =         dataBaseModel.name
                infomodel.category =     dataBaseModel.category
                infomodel.imageUrl =     dataBaseModel.imageUrl
                infomodel.price =        dataBaseModel.price
                infomodel.artist =       dataBaseModel.artist
                infomodel.link =         dataBaseModel.link
                infomodel.rights =       dataBaseModel.rights
                infomodel.releaseDate =  dataBaseModel.releaseDate
                appsInfo.append(infomodel)
            })
        }
        return appsInfo
    }
    
    func deleteAppsInforamtion(){
        
        let databaseHandler :  DataBaseHandler = DataBaseHandler.sharedInstance()
        let _ = databaseHandler.deleteRecord(tableName: "AppInforamation", predicate: nil)
    }
    
}
