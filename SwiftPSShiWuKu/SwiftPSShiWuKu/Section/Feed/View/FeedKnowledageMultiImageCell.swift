//
//  FeedKnowledageMultiImageCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

class FeedKnowledageMultiImageCell: UITableViewCell {
    
    var titleLabel: UILabel?
    var sourceLabel: UILabel?
    var readCountButton: UIButton?
    var imgView1: UIImageView?
    var imgView2: UIImageView?
    var imgView3: UIImageView?
    var containerView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
        //        testUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(titleLabel!)
        sourceLabel = UILabel()
        sourceLabel?.font = UIFont.systemFont(ofSize: 14)
        sourceLabel?.textColor = UIColor.gray
        self.contentView.addSubview(sourceLabel!)
        readCountButton = UIButton(type: .custom)
        readCountButton?.setTitleColor(UIColor.gray, for: .normal)
        readCountButton?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        readCountButton?.setImage(UIImage(named: "ic_feed_watch"), for: .normal)
        self.contentView.addSubview(readCountButton!)
        containerView = UIView()
//        containerView?.backgroundColor = UIColor.green
        self.contentView.addSubview(containerView!)
        imgView1 = UIImageView()
        imgView1?.contentMode = .scaleAspectFill
        containerView?.addSubview(imgView1!)
        imgView2 = UIImageView()
        imgView2?.contentMode = .scaleAspectFill
        containerView?.addSubview(imgView2!)
        imgView3 = UIImageView()
        imgView3?.contentMode = .scaleAspectFill
        containerView?.addSubview(imgView3!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = CGRect(x: 10, y: 10, width: k_ScreenWidth * 0.65, height: 40)
        containerView?.frame = CGRect(x: (titleLabel?.left)!, y: (titleLabel?.bottom)!, width: k_ScreenWidth - 20, height: 70)
        sourceLabel?.frame = CGRect(x: (titleLabel?.left)!, y: (containerView?.bottom)! + 10, width: 100, height: 20)
        // 这样可以自适应label的宽度
        sourceLabel?.sizeToFit()
        readCountButton?.frame = CGRect(x: (sourceLabel?.right)! + 10, y: (containerView?.top)!, width: 60, height: 20)
        let width = (k_ScreenWidth - 40) / 3
        imgView1?.frame = CGRect(x: 0, y: 0, width: width, height: 70)
        imgView2?.frame = CGRect(x: width + 10, y: 0, width: width, height: 70)
        imgView3?.frame = CGRect(x: (width * 2) + 2*10, y: 0, width: width, height: 70)
    }
    
    func testUI() {
        titleLabel?.text = "jenfjnejfnejfenfjkenfekjfnekfenkfenkfenfekf"
        sourceLabel?.text = "kejnfekjenfkjnefe"
        imgView1?.backgroundColor = UIColor.green
        imgView2?.backgroundColor = UIColor.green
        imgView3?.backgroundColor = UIColor.green
    }
    
    func configureCell(title: String, source: String, readCount: String, imageNameArr: [String]) {
        
        let url = URL(string: imageNameArr[0])
        imgView1?.kf.setImage(with: ImageResource.init(downloadURL: url!))
        let url2 = URL(string: imageNameArr[1])
        imgView2?.kf.setImage(with: ImageResource.init(downloadURL: url2!))
        let url3 = URL(string: imageNameArr[2])
        imgView3?.kf.setImage(with: ImageResource.init(downloadURL: url3!))
        titleLabel?.text = title
        sourceLabel?.text = source
        readCountButton?.setTitle(readCount, for: .normal)
    }
}
