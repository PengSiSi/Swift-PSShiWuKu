
//
//  FeedDetailViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
// Feed模块详情页

import UIKit
import RealmSwift

class FeedDetailViewController: BaseViewController, UIWebViewDelegate {

    // url
    var url: String?
    var model: FeedEvaluateModel?
    // 是否收藏
    var isCollectFlag: Bool = false
    var bottomView: FeedDetailBottomView!
    
    var webView = UIWebView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "资讯详情"
        findAllData()
        webView.frame = CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight - 44)
        webView.backgroundColor = UIColor.lightGray
        self.view.addSubview(webView)
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
        
        //设置代理(不要忘记!如果不设置就无法调用webView的代理方法)
        webView.delegate = self
        self.view.addSubview(webView)
        // 底部视图
        setupBottomView()
    }
    
    func setupBottomView() {
        bottomView = FeedDetailBottomView(frame: CGRect(x: 0, y: k_ScreenHeight - 44, width: k_ScreenWidth, height: 44))
        if isCollectFlag {
            bottomView.collectButton.setImage(UIImage(named: "ic_collect_select"), for: .normal)
        }
        // action
        bottomView.block = { (titleStr) -> () in
            let str = NSString(string: titleStr)
            if str.isEqual(to: "收藏"){
                print(str)
                // 收藏到realm数据库
                self.saveToRealmDB()
            }
        }
        self.view.addSubview(bottomView)
    }
    
    func saveToRealmDB() {
        
        bottomView.collectButton.setImage(UIImage(named: "ic_collect_select"), for: .normal)
        let collectModel = CollectModel()
        let title = model?.title
        let link = model?.link
        collectModel.title = title!
        collectModel.link = link!
        
        //使用默认的数据库
        let realm = try! Realm()
        // 数据持久化操作（类型记录也会自动添加的）
        try! realm.write {
            realm.add(collectModel)
        }
        //打印出数据库地址
        print(realm.configuration.fileURL ?? "没有fileURL")
    }
    
    func findAllData() {
        let collectModels = try! Realm().objects(CollectModel.self)
        print(collectModels.count)
        for i in 0..<collectModels.count {
            let modelItem: CollectModel = collectModels[i]
            let titleStr = NSString(string: modelItem.title)
            if titleStr.isEqual(to: (self.model?.title)!) {
                isCollectFlag = true
            }
        }
    }
}
