//
//  CustomSearchBar.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.

// 自定义搜索框

import UIKit

class CustomSearchBar: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let searchIcon = UIImageView()
        searchIcon.image = UIImage(named: "searchicon_search_20x20_")
        searchIcon.width = 30
        searchIcon.height = 30
        searchIcon.contentMode = .center
        leftView = searchIcon
        leftViewMode = .always
    }
    
    // 类方法调用
    class func searchBar() -> CustomSearchBar {
        return CustomSearchBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 44)
            super.frame = newFrame
        }
    }
}
