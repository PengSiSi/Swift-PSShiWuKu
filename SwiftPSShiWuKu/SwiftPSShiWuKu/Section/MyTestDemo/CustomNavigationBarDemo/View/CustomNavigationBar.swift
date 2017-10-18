//
//  CustomNavigationBar.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SnapKit

class CustomNavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 图片
        addSubview(imageView)
        // searchBar
        addSubview(searchBar)
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 72, height: 20))
        }
        searchBar.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(15)
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "title_72x20_"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var searchBar: CustomSearchBar = {
       let searchBar = CustomSearchBar.searchBar()
        searchBar.placeholder = "搜你想搜的"
        // 防止图片的拉伸
        let image: UIImage = UIImage(named: "searchbox_search_20x28_")!
        let resizeImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), resizingMode: .stretch)
        searchBar.background = resizeImage
//        searchBar.backgroundColor = UIColor.white
//        searchBar.layer.cornerRadius = 5.0
//        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
//            UIView.animate(withDuration: 0.00) {
                let newFrame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 44)
                super.frame = newFrame
//            }
        }
    }
    
    // iOS11 navigationItem.titleView 适配问题
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 40)
    }
}
