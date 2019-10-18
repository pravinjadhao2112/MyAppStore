//
//  MyAppDetailViewProtocol.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import UIKit

protocol MyAppDetailViewProtocol: class {
    var presenter:MyAppDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showMyAppDetail(appInfo: AppInfoModel)
}

protocol MyAppDetailWireFrameProtocol: class {
    static func createMyAppDetailModule(appInfo: AppInfoModel) -> UIViewController
}

protocol MyAppDetailPresenterProtocol: class {
    var view: MyAppDetailViewProtocol? { get set }
    var wireFrame: MyAppDetailWireFrameProtocol? { get set }
    var appInfo: AppInfoModel? { get set }
    
    func viewDidLoad()
}
