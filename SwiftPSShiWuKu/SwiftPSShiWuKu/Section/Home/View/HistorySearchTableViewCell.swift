//
//  HistorySearchTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/3.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class HistorySearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchIconImgView: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleStr: String? {
        didSet {
            titleLabel.text = titleStr
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
