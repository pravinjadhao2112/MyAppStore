//
//  MyAppDetailWireFrame.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import UIKit

class MyAppDetailWireFrame: MyAppDetailWireFrameProtocol {
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func createMyAppDetailModule(appInfo: AppInfoModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MyAppDetailView")
        if let view = viewController as? MyAppDetailView {
            let presenter: MyAppDetailPresenterProtocol = MyAppDetailPresenter()
            let wireFrame:MyAppDetailWireFrameProtocol = MyAppDetailWireFrame()
            view.presenter = presenter
            presenter.view = view
            presenter.appInfo = appInfo
            presenter.wireFrame = wireFrame
            
            return viewController
        }
        return UIViewController()
    }
}


