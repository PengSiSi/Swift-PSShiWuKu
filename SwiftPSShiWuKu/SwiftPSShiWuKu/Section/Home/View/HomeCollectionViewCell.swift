//
//  HomeCollectionViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/27.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(imgName: String, title: String) {
        let url = URL(string: imgName)
        imgView?.kf.setImage(with: ImageResource.init(downloadURL: url!))
        titleLabel.text = title
    }
}
