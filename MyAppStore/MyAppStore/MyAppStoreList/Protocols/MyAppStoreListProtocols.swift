//
//  MyAppStoreListViewProtocol.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import UIKit

protocol MyAppStoreListViewProtocol: class {
    
    var presenter: MyAppStoreListPresenterProtocol? { get set }
    func showAppList(appList: [AppInfoModel])
    
    func showError(errorMessage : String)
    func showLoading()
    func hideLoading()
}

protocol MyAppStoreListPresenterProtocol: class {
    var view: MyAppStoreListViewProtocol? { get set }
    var interactor: MyAppStoreListInteractorInputProtocol? { get set }
    var wireFrame: MyAppStoreListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func showMyAppDetail(appInfo: AppInfoModel)
}

protocol MyAppStoreListInteractorProtocol: class {
    func didReceiveAppList(appList: [AppInfoModel])
    func onError(error : String)
}

protocol MyAppStoreListWireFrameProtocol: class {
    static func createMyAppStoreModule() -> UIViewController
    func presentAppDetailScreen(view: MyAppStoreListViewProtocol,appInfo: AppInfoModel)
}


protocol MyAppStoreListInteractorInputProtocol: class {
    var presenter: MyAppStoreListInteractorProtocol? { get set }
    var localDatamanager: MyAppStoreListLocalDataManagerProtocol? { get set }
    var remoteDatamanager: MyAppStoreListRemoteDataManagerProtocol? { get set }
    
    func fetchMyAppStoreList()
}

protocol MyAppStoreListRemoteDataManagerProtocol: class {
    func  performGetAppsInfo(completion:@escaping GetAppInfoCompletionHandler)
}

protocol MyAppStoreListLocalDataManagerProtocol: class {
    func saveAppInformation(appInfo : [AppInfoModel])
    func fetchAppInformation() -> [AppInfoModel]
    func deleteAppsInforamtion()
}
