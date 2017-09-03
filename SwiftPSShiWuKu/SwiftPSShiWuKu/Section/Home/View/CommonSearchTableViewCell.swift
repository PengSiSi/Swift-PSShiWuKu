//
//  CommonSearchTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/3.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SnapKit

class CommonSearchTableViewCell: UITableViewCell {

    var label1: UILabel?
    var label2: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        
        label1 = UILabel()
        label1?.textAlignment = .center
        label1?.textColor = UIColor.gray
        label1?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(label1!)
        
        label2 = UILabel()
        label2?.textAlignment = .center
        label2?.textColor = UIColor.gray
        label2?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(label2!)

    }
    
    func layOut() {
        
        label1?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.contentView)
            make.width.equalTo(k_ScreenWidth / 2)
            make.height.equalTo(self.contentView)
        })
        label2?.snp.makeConstraints({ (make) in
            make.left.equalTo((label1?.snp.right)!)
            make.top.equalTo(self.contentView)
            make.width.equalTo(k_ScreenWidth / 2)
            make.height.equalTo(self.contentView)
        })
    }
}
