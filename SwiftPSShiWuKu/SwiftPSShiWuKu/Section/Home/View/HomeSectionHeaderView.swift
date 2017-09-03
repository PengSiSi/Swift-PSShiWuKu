//
//  HomeSectionHeaderView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

typealias CustomButtonClosure = (_ title: String) -> Void

class HomeSectionHeaderView: UIView {
    
    var closure: CustomButtonClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        
        let imageNameArray = ["ic_home_analyse", "ic_search_compare", "ic_scan_compare"]
        let titleArray = ["饮食分析", "搜索对比", "扫码对比"]
        let containerView = UIView(frame: CGRect(x: 20, y: 10, width: k_ScreenWidth - 40, height: 80))
        self.addSubview(containerView)
        let width: CGFloat = (k_ScreenWidth - 60) / 3;
        for index in 0..<imageNameArray.count {
            let customButton = CustomButton(frame: CGRect(x: (CGFloat(CGFloat(index) * width) + 30), y: 0, width: width - 40, height: 50))
            customButton.setTitle(titleArray[index], for: .normal)
            customButton.setImage(UIImage(named: imageNameArray[index]), for: .normal)
            customButton.addTarget(self, action: #selector(customButtonAction(button:)), for: .touchUpInside)
            containerView.addSubview(customButton)
        }

    }
    
    func layOut() {
        
    }
    
    func customButtonAction(button: UIButton) {
        
        if self.closure != nil {
            self.closure!(button.currentTitle!)
        }
    }
}
