
//
//  FeedDetailViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
// Feed模块详情页

import UIKit

class FeedDetailViewController: BaseViewController, UIWebViewDelegate {

    // url
    var url: String?
    var webView = UIWebView.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "资讯详情"
        
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
        let bottomView = FeedDetailBottomView(frame: CGRect(x: 0, y: k_ScreenHeight - 44, width: k_ScreenWidth, height: 44))
        // action
        bottomView.block = { (titleStr) -> () in
            print(titleStr)
        }
        self.view.addSubview(bottomView)
    }
}
