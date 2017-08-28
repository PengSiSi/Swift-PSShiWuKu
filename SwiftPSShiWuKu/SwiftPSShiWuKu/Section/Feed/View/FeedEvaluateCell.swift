//
//  FeedEvaluateCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

class FeedEvaluateCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var TopLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readCountlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.bringSubview(toFront: TopLabel)
        self.bringSubview(toFront: titleLabel)
        self.bringSubview(toFront: readCountlabel)
    }
    
    func configureCell(imgName: String?, topStr: String?, titleStr: String?, readCountStr: String?) {
        
        let url = URL(string: imgName!)
        imageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        TopLabel.text = topStr
        titleLabel.text = titleStr
        readCountlabel.text = readCountStr
    }
}
