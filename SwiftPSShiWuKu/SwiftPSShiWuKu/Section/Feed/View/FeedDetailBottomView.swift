//
//  FeedDetailBottomView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

typealias DidClickClosure = (_ titleStr: String) -> ()

class FeedDetailBottomView: UIView {
    
    // 点击回调
    var block: DidClickClosure?
    var collectButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        
        let containerView = UIView(frame: CGRect(x: 60, y: 0, width: k_ScreenWidth - 120, height: 44))
//        containerView.backgroundColor = UIColor.red
        self.addSubview(containerView)
        // 分享
        let shareButton = UIButton(type: .custom)
        shareButton.frame = CGRect(x: 0, y: 0, width: containerView.width / 2, height: 44)
        shareButton.setImage(UIImage(named: "ic_news_share"), for: .normal)
        shareButton.setTitle("分享", for: .normal)
        shareButton.setTitleColor(UIColor.darkGray, for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        shareButton.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
        containerView.addSubview(shareButton)
        
        // 收藏
        collectButton = UIButton(type: .custom)
        collectButton.frame = CGRect(x: containerView.width / 2, y: 0, width: containerView.width / 2, height: 44)
        collectButton.setImage(UIImage(named: "ic_collect"), for: .normal)
        collectButton.setTitleColor(UIColor.darkGray, for: .normal)
        collectButton.setTitle("收藏", for: .normal)
        collectButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        collectButton.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
        containerView.addSubview(collectButton)
    }
    
    func clickAction(button: UIButton) {
        let titleStr = button.currentTitle
        if block != nil {
            block!(titleStr!)
        }
    }
}
