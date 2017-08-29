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
    
    var bgImageView: UIImageView?
    var label1: UILabel?
    var label2: UILabel?
    var label3: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.bringSubview(toFront: TopLabel)
//        self.bringSubview(toFront: titleLabel)
//        self.bringSubview(toFront: readCountlabel)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bgImageView = UIImageView()
        self.contentView.addSubview(bgImageView!)
        label1 = UILabel()
        label1?.textColor = UIColor.white
        label1?.textAlignment = .center
        self.contentView.addSubview(label1!)
        label2 = UILabel()
        label2?.textColor = UIColor.white
        label2?.textAlignment = .center
        self.contentView.addSubview(label2!)
        label3 = UILabel()
        label3?.textColor = UIColor.white
        label3?.textAlignment = .center
        self.contentView.addSubview(label3!)
        
        bgImageView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.contentView)
        })
        label1?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(bgImageView!)
            make.top.equalTo(bgImageView!).offset(10)
        })
        label2?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(bgImageView!)
//            make.top.equalTo(label1!).offset(20)
            make.centerY.equalTo(bgImageView!)
        })
        label3?.snp.makeConstraints({ (make) in
            make.left.right.equalTo(bgImageView!)
            make.bottom.equalTo(bgImageView!).offset(-10)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(imgName: String?, topStr: String?, titleStr: String?, readCountStr: String?) {
        
//        let url = URL(string: imgName!)
        let url = URL(string: imgName!)
        bgImageView?.kf.setImage(with: ImageResource.init(downloadURL: url!))

//        imageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
//        imageView?.backgroundColor = MainColor()
//        TopLabel.text = topStr
//        titleLabel.text = titleStr
//        readCountlabel.text = readCountStr
        
        label1?.text = topStr
        label2?.text = titleStr
        label3?.text = readCountStr
    }
}
