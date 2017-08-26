//
//  LoginViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录";
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = GlobalColor()
        setupUI()
    }
    
    func setupUI() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 44, width: k_ScreenWidth, height: 30))
        titleLabel.text = "不用注册,用一下账号直接登录"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(titleLabel)
        self.createThirdLogginView()
        self.createBottomView()
    }
    
    func createThirdLogginView() {
        let imageArr: [String] = ["ic_account_qq", "ic_account_wechat", "ic_account_weibo", "ic_account_boohee"]
        let titleArr: [String] = ["QQ", "微信", "微博", "薄荷"]
        let containerView = UIView(frame: CGRect(x: 20, y: 100, width: k_ScreenWidth - 40, height: 80))
        self.view.addSubview(containerView)
        let width: CGFloat = (k_ScreenWidth - 60) / 4;
        for index in 0...3 {
            let customButton = CustomButton(frame: CGRect(x: CGFloat(CGFloat(index) * width), y: 0, width: width, height: 70))
            customButton.setTitle(titleArr[index], for: .normal)
            customButton.setImage(UIImage(named: imageArr[index]), for: .normal)
            containerView.addSubview(customButton)
        }
    }
    
    func createBottomView() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 200, width: k_ScreenWidth, height: 30))
        titleLabel.text = "没有以上账号?"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(titleLabel)
        
        let registerButton = UIButton(type: .custom)
        registerButton.frame = CGRect(x: (k_ScreenWidth - 150)/2, y: titleLabel.bottom, width: 150, height: 44)
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = UIColor.white
        registerButton.setTitle("注册", for: .normal)
        registerButton.addTarget(self, action: #selector(jumpRegisterPage), for: .touchUpInside)
        registerButton.setTitleColor(UIColor.red, for: .normal)
        self.view.addSubview(registerButton)
    }
    
    func jumpRegisterPage() {
        let registerVc = RegisterViewController()
        self.navigationController?.pushViewController(registerVc, animated: true)
    }
}
