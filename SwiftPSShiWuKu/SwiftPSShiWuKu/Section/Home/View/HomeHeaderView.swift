//
//  HomeHeaderView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/17.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

typealias SearchBlock = (_ text: String) -> ()

class HomeHeaderView: UIView {
    
    var bgImgView: UIImageView?
    var titleImgView: UIImageView?
    var tipLabel: UILabel?
    var searchBar: SearchBarView?
    var block: SearchBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        bgImgView = UIImageView(image: UIImage(named: "img_home_bg"))
        bgImgView?.contentMode = .scaleAspectFill
        self.addSubview(bgImgView!)
        
        titleImgView = UIImageView(image: UIImage(named: "img_horizontal_default"))
        titleImgView?.contentMode = .scaleAspectFit
        bgImgView?.addSubview(titleImgView!)
        
        tipLabel = UILabel()
        tipLabel?.textColor = UIColor.white
        tipLabel?.text = "查询食物信息"
        tipLabel?.textAlignment = .center
        bgImgView?.addSubview(tipLabel!)
        
        searchBar = SearchBarView()
        
        // 传值
        weak var weakSelf = self
        searchBar?.searchBlock = {(text) -> () in
            if weakSelf?.block != nil {
                weakSelf?.block!(text)
            }
        }
        bgImgView?.addSubview(searchBar!)
    }
    
    func layOut() {
        bgImgView?.snp.makeConstraints({ (make) in
            make.width.equalTo(k_ScreenWidth)
            make.height.equalTo(150)
            make.left.top.equalTo(self)
        })
        titleImgView?.snp.makeConstraints({ (make) in
            make.width.equalTo(60)
            make.top.equalTo(20)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
        })
        tipLabel?.snp.makeConstraints({ (make) in
            make.width.equalTo(k_ScreenWidth)
            make.height.equalTo(20)
            make.top.equalTo(100)
        })
        searchBar?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.width.equalTo(k_ScreenWidth - 20)
            make.height.equalTo(44)
            make.top.equalTo((tipLabel?.snp.bottom)!).offset(20)
        })
    }
}
