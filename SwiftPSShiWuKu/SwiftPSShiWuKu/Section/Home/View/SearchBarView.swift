//
//  SearchBarView.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import SnapKit

// 搜索字符
typealias TextFieldDidEndEditBlock = (_ searchText:String)->()
typealias TextFieldDidBeginEditBlock = ()->()

class SearchBarView: UIView {
    
    var iconImgView: UIImageView?
    var searchTextField: UITextField?
    var rightIconButton: UIButton?
    // 定义传值block
    var searchBlock: TextFieldDidEndEditBlock?
    var beginEditBlock: TextFieldDidBeginEditBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        createSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        self.isUserInteractionEnabled = true
        iconImgView = UIImageView(image: UIImage(named: "ic_home_search"))
        iconImgView?.contentMode = .scaleAspectFit
        self.addSubview(iconImgView!)
        
        searchTextField = UITextField()
        searchTextField?.isEnabled = true
        searchTextField?.font = UIFont.systemFont(ofSize: 15)
//        searchTextField?.placeholder = "请输入食品名称"
        searchTextField?.attributedPlaceholder = NSAttributedString(string:"请输入食品名称",attributes:[NSForegroundColorAttributeName: MainColor()])
        searchTextField?.textColor = MainColor()
        searchTextField?.delegate = self
        self.addSubview(searchTextField!)
        
        rightIconButton = UIButton(type: .custom)
        rightIconButton?.setImage(UIImage(named: "ic_scan_gray_home"), for: .normal)
        self.addSubview(rightIconButton!)
    }
    
    func layOut() {
        iconImgView?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(20)
        })
        searchTextField?.snp.makeConstraints({ (make) in
            make.left.equalTo((iconImgView?.snp.right)!).offset(10)
            make.top.bottom.equalTo(self)
            make.right.equalTo((rightIconButton?.snp.left)!)
        })
        rightIconButton?.snp.makeConstraints({ (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(20)
        })
    }
}

extension SearchBarView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchBlock != nil {
            searchBlock!(textField.text!)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        print("开始编辑")
        if beginEditBlock != nil {
            beginEditBlock!()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
