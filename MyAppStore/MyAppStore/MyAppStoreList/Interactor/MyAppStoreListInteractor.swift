//
//  MyAppStoreListInteractor.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


class MyAppStoreListInteractor: MyAppStoreListInteractorInputProtocol {
    
    weak var presenter: MyAppStoreListInteractorProtocol?
    var localDatamanager: MyAppStoreListLocalDataManagerProtocol?
    var remoteDatamanager: MyAppStoreListRemoteDataManagerProtocol?
    
    func fetchMyAppStoreList() {
        if let appList =  localDatamanager?.fetchAppInformation(),!appList.isEmpty {
            presenter?.didReceiveAppList(appList: appList)
        } else {
            
            remoteDatamanager?.performGetAppsInfo(){ [unowned self] (result) in
                switch result {
                case .success(let re):
                    
                    var appList = [AppInfoModel]()
                    re.feed?.entry?.forEach { info in
                        let model = AppInfoModel(info: info)
                        appList.append(model)
                    }
                    self.localDatamanager?.saveAppInformation(appInfo: appList)
                    self.presenter?.didReceiveAppList(appList: appList)
                    break
                case .failure(let error):
                    self.presenter?.onError(error: error.localizedDescription)
                    break
                }
            }
        }
    }
}


