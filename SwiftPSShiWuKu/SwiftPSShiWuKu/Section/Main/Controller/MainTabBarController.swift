//
//  MainTabBarController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/5/22.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    // 提示音
    fileprivate lazy var soundEffect: SoundEffect = {
        
        
        guard let filePath = Bundle.main.path(forResource: "tabbar1", ofType: "mp3") else {

            fatalError("YepSoundEffect: file no found!")
        }
        return SoundEffect(fileURL: URL(fileURLWithPath: filePath))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        self.delegate = self
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
    
    // 监听TabBar的点击，这里不走
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("点击了。。。")
    }
    
    // 监听TabBar的点击
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print("点击了。。。")
//        self.soundEffect.play()
//    }
}
