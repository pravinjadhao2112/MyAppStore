//
//  MyAppStoreListWireFrame.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import UIKit

class MyAppStoreListWireFrame:MyAppStoreListWireFrameProtocol {
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    class func createMyAppStoreModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MyAppStoreNavigation")
        if let view = navController.children.first as? MyAppStoreListView {
            let presenter = MyAppStoreListPresenter()
            
            let interactor = MyAppStoreListInteractor()
            let localDataManager =  MyAppStoreListLocalDataManager()
            let remoteDataManager =  MyAppStroreListRemoteDataManager()
            
            let wireFrame: MyAppStoreListWireFrameProtocol = MyAppStoreListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            
            return navController
        }
        return UIViewController()
    }
    
    
    
    func presentAppDetailScreen(view: MyAppStoreListViewProtocol,appInfo: AppInfoModel) {
        
        let MyAppDetailViewController = MyAppDetailWireFrame.createMyAppDetailModule(appInfo: appInfo)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(MyAppDetailViewController, animated: true)
        }
    }
    
}
