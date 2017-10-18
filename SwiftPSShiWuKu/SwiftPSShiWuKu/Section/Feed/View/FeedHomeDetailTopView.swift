//
//  FeedHomeDetailTopView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/16.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class FeedHomeDetailTopView: UIView {
    
    @IBOutlet weak var avaterImgView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaterImgView.layer.cornerRadius = 26.0
        // 设置圆角必须加这句
        avaterImgView.layer.masksToBounds = true
    }
}
