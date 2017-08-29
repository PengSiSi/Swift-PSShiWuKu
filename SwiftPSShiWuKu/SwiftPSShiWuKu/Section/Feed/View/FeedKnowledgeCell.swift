//
//  FeedKnowledgeCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import Kingfisher

class FeedKnowledgeCell: UITableViewCell {

    var titleLabel: UILabel?
    var sourceLabel: UILabel?
    var readCountButton: UIButton?
    var imgView: UIImageView?
//    var imageArray: [String]
    
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
        imgView = UIImageView()
        imgView?.contentMode = .scaleAspectFill
        self.contentView.addSubview(imgView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = CGRect(x: 10, y: 10, width: k_ScreenWidth * 0.65, height: 40)
        sourceLabel?.frame = CGRect(x: (titleLabel?.left)!, y: (titleLabel?.bottom)! + 10, width: 100, height: 20)
        // 这样可以自适应label的宽度
        sourceLabel?.sizeToFit()
        readCountButton?.frame = CGRect(x: (sourceLabel?.right)! + 10, y: (sourceLabel?.top)!, width: 60, height: 20)
        imgView?.frame = CGRect(x: k_ScreenWidth - 110, y: (titleLabel?.top)!, width: 100, height: 60)
        
    }
    
    func testUI() {
        titleLabel?.text = "jenfjnejfnejfenfjkenfekjfnekfenkfenkfenfekf"
        sourceLabel?.text = "kejnfekjenfkjnefe"
        imgView?.backgroundColor = UIColor.green
    }
    
    func configureCell(title: String, source: String, readCount: String, imageNameArr: [String]) {
        
//        self.imageArray = imageNameArr
        if imageNameArr.count > 1 {
            
            // 三张图片
            
        } else {
            // 一张图片
            let url = URL(string: imageNameArr[0])
            imgView?.kf.setImage(with: ImageResource.init(downloadURL: url!))
        }
        titleLabel?.text = title
        sourceLabel?.text = source
        readCountButton?.setTitle(readCount, for: .normal)
    }
    
    func createImageViewContainerView() {
        
//        let containerView = UIView(frame: CGRect(x: 20, y: 0, width: k_ScreenWidth - 40, height: 60))
//        let width = (k_ScreenWidth - 40) / 3
//        for i in 0..<imageArray.count {
//            let imgView = UIImageView()
//            imgView.contentMode = .scaleAspectFill
////            let x = i * (CGFloat)width
//            imgView.frame = CGRect(x: x, y: 0, width: width, height: 60)
//            containerView.addSubview(imgView)
//        }
    }
}
