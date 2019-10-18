//
//  MyAppDetailPresenter.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


class MyAppDetailPresenter: MyAppDetailPresenterProtocol {
    
    weak var view: MyAppDetailViewProtocol?
    var wireFrame: MyAppDetailWireFrameProtocol?
    var appInfo: AppInfoModel?
    
    func viewDidLoad() {
        view?.showMyAppDetail(appInfo: appInfo!)
    }
}

