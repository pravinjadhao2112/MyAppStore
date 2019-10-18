//
//  MyAppCollectionViewCell.swift
//  MyAppStore
//
//  Created by Pravin Jadhao on 18/10/19.
//  Copyright © 2019 Pravin Jadhao. All rights reserved.
//


import UIKit
import AlamofireImage

class MyAppCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()
        iconImageView.layer.cornerRadius = 10
        iconImageView.layer.masksToBounds = true
    }
    func setupCell(appInfo : AppInfoModel){
        
        DispatchQueue.main.async {
            if let imageURL = URL(string: appInfo.imageUrl ?? "" ), let placeholder = UIImage(named: "app_placeholder.png") {
                self.iconImageView.af_setImage(withURL: imageURL, placeholderImage: placeholder)
            }
        }
        titleLabel.text = appInfo.name
        categoryLabel.text = appInfo.category
    }
}
