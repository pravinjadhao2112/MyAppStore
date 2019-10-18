//
//  MyAppStoreListView.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//

import UIKit

import JGProgressHUD


class MyAppStoreListView: UIViewController {
    
    @IBOutlet weak var appsCollectionView: UICollectionView!
    
    var presenter: MyAppStoreListPresenterProtocol?
    var myAppList : [AppInfoModel] = []
    let hud = JGProgressHUD(style: .dark)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        self.navigationItem.title = "Apps"
    }
}

//MARK:- MyAppStoreListViewProtocol

extension MyAppStoreListView: MyAppStoreListViewProtocol {
    
    func showAppList(appList: [AppInfoModel]) {
        myAppList = appList
        appsCollectionView.reloadData()
    }
    
    func showError(errorMessage : String)
    {
        
        
    }
    
    func showLoading() {
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    }
    
    func hideLoading() {
        hud.dismiss()
    }
}
//MARK:- UICollectionViewDelegateFlowLayout
extension MyAppStoreListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 3
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}

//MARK:- UICollectionViewDataSource

extension MyAppStoreListView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myAppList.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyAppCollectionViewCell", for: indexPath as IndexPath) as! MyAppCollectionViewCell
        let appInfo = myAppList[indexPath.row]
        cell.setupCell(appInfo :appInfo)
        return cell
    }
}


// MARK: - UICollectionViewDelegate protocol

extension MyAppStoreListView : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMyAppDetail(appInfo: myAppList[indexPath.row])
    }
}
