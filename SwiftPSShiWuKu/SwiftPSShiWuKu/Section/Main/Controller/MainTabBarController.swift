//
//  MainTabBarController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        addChildViewControllers()
    }
    
    func initialize() {
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor.init(111, 111, 111, 1.0)
    }
}

extension MainTabBarController {
    
    /// 添加子控制器
    func addChildViewControllers() {
        addChildViewController(childController: HomeViewController(), title: "首页", imageName: "ic_tab_homepage", selectedImageName: "ic_tab_homepage_select")
        addChildViewController(childController: FeedViewController (), title: "逛吃", imageName: "ic_tab_shop", selectedImageName: "ic_tab_shop_select")
        addChildViewController(childController: MineViewController(), title: "我的", imageName: "ic_tab_my", selectedImageName: "ic_tab_my_select")
    }
    
    // 注意设置 withRenderingMode
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal)
        let nav = BaseNavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}
