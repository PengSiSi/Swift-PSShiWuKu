//
//  HomeListTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/30.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

class HomeListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var kilolabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var rightImgView: UIImageView!
    @IBOutlet weak var perLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rightImgView.layer.cornerRadius = 5.0
        rightImgView.layer.masksToBounds = true
        kilolabel.textColor = UIColor.red
    }
    
    func configureCell(imageName: String?, typeStr: String?, kiloStr: String, perStr: String) {
        
        let url = URL(string: imageName!)
        imgView?.kf.setImage(with: ImageResource.init(downloadURL: url!))
        typeLabel.text = typeStr
        kilolabel.text = kiloStr
        perLabel.text = "100克"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
