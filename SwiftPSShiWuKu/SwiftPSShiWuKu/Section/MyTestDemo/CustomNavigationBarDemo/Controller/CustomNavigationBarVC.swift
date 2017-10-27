//
//  CustomNavigationBarVC.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class CustomNavigationBarVC: BaseViewController, UITextFieldDelegate {
    
    var shakeView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 这里会有一下卡顿出现，待解决？？？
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.red
        navigationItem.titleView = self.homeNavigationBar
        
        shakeView = UIView()
        shakeView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        shakeView.backgroundColor = UIColor.red
//        shakeView.shake(direction: .horizontal, times: 10, interval: 0.3, delta: 0, completion: nil)
        self.view.addSubview(shakeView)
        
        let btn = UIButton(type: .custom)
        btn.setTitle("点击", for: .normal)
        btn.frame = CGRect(x: 100, y: 220, width: 100, height: 44)
        btn.backgroundColor = UIColor.lightGray
        btn.addTarget(self, action: #selector(shakeAction), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    // 自定义导航栏titleView
    fileprivate lazy var homeNavigationBar: CustomNavigationBar = {
        let homeNavigationBar = CustomNavigationBar()
        homeNavigationBar.searchBar.delegate = self
        return homeNavigationBar
    }()
    
    @objc fileprivate func shakeAction() {
        print("点击")
        shakeView.shake(direction: .vertical, times: 10, interval: 0.3, delta: 3, completion: nil)
        shakeView.startShimmering()
    }
}

