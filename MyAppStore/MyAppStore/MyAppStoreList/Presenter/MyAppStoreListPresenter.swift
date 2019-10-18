//
//  MyAppStoreListPresenter.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


class MyAppStoreListPresenter: MyAppStoreListPresenterProtocol {
    
    weak var view:MyAppStoreListViewProtocol?
    var wireFrame: MyAppStoreListWireFrameProtocol?
    var interactor: MyAppStoreListInteractorInputProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchMyAppStoreList()
    }
    
    func showMyAppDetail(appInfo: AppInfoModel) {
        wireFrame?.presentAppDetailScreen(view: view!, appInfo: appInfo)
    }
}

extension MyAppStoreListPresenter:MyAppStoreListInteractorProtocol {
    
    func didReceiveAppList(appList: [AppInfoModel]) {
        view?.hideLoading()
        view?.showAppList(appList: appList)
    }
    
    func onError(error : String) {
        view?.hideLoading()
        view?.showError(errorMessage: error)
    }
    
}


