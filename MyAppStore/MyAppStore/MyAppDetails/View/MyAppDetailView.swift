//
//  MyAppDetailView.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import UIKit

class MyAppDetailView: UIViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rightsLabel: UILabel!
    
    var presenter: MyAppDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        self.view.layoutIfNeeded()
        iconImageView.layer.cornerRadius = 10
        iconImageView.layer.masksToBounds = true
    }
}

extension MyAppDetailView: MyAppDetailViewProtocol {
    
    func showMyAppDetail(appInfo: AppInfoModel) {
        if let imageURL = URL(string: appInfo.imageUrl ?? "" ), let placeholder = UIImage(named: "app_placeholder.png") {
            self.iconImageView.af_setImage(withURL: imageURL, placeholderImage: placeholder)
        }
        self.navigationItem.title = appInfo.name

        self.nameLabel.text = appInfo.name
        self.artistLabel.text = appInfo.artist
        self.categoryLabel.text = appInfo.category
        self.priceLabel.text = appInfo.price
        self.releaseDateLabel.text = appInfo.releaseDate
        self.rightsLabel.text = appInfo.rights
    }
}
