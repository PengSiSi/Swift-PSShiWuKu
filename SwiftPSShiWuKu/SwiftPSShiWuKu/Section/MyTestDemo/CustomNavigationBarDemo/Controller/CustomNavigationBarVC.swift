//
//  CustomNavigationBarVC.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class CustomNavigationBarVC: BaseViewController, UITextFieldDelegate {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 这里会有一下卡顿出现，待解决？？？
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.red
        navigationItem.titleView = self.homeNavigationBar
    }
    
    // 自定义导航栏titleView
    fileprivate lazy var homeNavigationBar: CustomNavigationBar = {
        let homeNavigationBar = CustomNavigationBar()
        homeNavigationBar.searchBar.delegate = self
        return homeNavigationBar
    }()
}

