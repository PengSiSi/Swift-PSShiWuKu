//
//  ShareViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/25.
//  Copyright © 2017年 思 彭. All rights reserved.

// progressView就是不显示，待完善？？？

import UIKit
import YFMoreViewController
import MonkeyKing
import WebKit

class ShareViewController: BaseViewController, YFMoreViewDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    public var url: String!
    
    // 懒加载
    fileprivate lazy var closeButtonItem: UIBarButtonItem = {
        let closeButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeItemClicked))
        return closeButtonItem
    }()
    
    fileprivate lazy var customBackBarItem: UIBarButtonItem = {
        let customBackBarItem = UIBarButtonItem.init(image: UIImage(named: "ic_back_dark"), style: .plain, target: self, action: #selector(customBackItemClicked))
        customBackBarItem.imageInsets = UIEdgeInsetsMake(0, -8, 0, 0)
        return customBackBarItem
    }()
    
    fileprivate lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0)
        closeButton.frame = CGRect(x: 0, y: 0, width: 35, height: 44)
        closeButton.setTitle("关闭", for: UIControlState())
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        closeButton.contentHorizontalAlignment = .left
        closeButton.setTitleColor(UIColor.white, for: UIControlState())
        closeButton.addTarget(self, action: #selector(closeItemClicked), for: .touchUpInside)
        return closeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分享"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_photo_share"), style: .plain, target: self, action: #selector(shareAction(_:)))
        addWKWebView()
        addProgressView()
        webView.load(URLRequest(url: URL(string: "http://www.baidu.com")!))
    }
    
    fileprivate func addWKWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        webView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight - 64), configuration: webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        webView?.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.sizeToFit()
        view.addSubview(webView)
    }
    
    fileprivate func addProgressView() {
        
        progressView = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 2))
        view.addSubview(progressView)
        progressView?.trackTintColor = UIColor.clear
        progressView?.progressTintColor = UIColor.orange
//        progressView.backgroundColor = UIColor.red
//        self.view.insertSubview(progressView, at: 0)
        view.addSubview(progressView!)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "estimatedProgress"){
            progressView.alpha = 1.0
            let animated = Float(webView.estimatedProgress) > progressView.progress;
            progressView.setProgress(Float(webView.estimatedProgress), animated: animated)
            
            if Float(webView.estimatedProgress) >= 1.0{
                UIView.animate(withDuration: 1, delay:0.01,options:UIViewAnimationOptions.curveEaseOut, animations:{()-> Void in
                    self.progressView.alpha = 0.0
                },completion:{(finished:Bool) -> Void in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        } else if (keyPath == "title") {
            title = webView.title;
        }
        
        updateNavigationItems()
    }
    
    fileprivate func updateNavigationItems(){
        if webView.canGoBack {
            navigationItem.setLeftBarButtonItems([customBackBarItem, UIBarButtonItem(customView:closeButton)], animated: false)
        } else {
            navigationItem.setLeftBarButtonItems([customBackBarItem],animated: false)
        }
        
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
    
    func shareAction(_ barButtonItem: UIBarButtonItem) {
        
        let moreViewController = YFMoreViewController.init()
        moreViewController.delegate = self
        moreViewController.addInfo("http://www.baidu.com")
        // 判断是否安装
//        if MonkeyKing.SupportedPlatform.weChat.isAppInstalled {
            moreViewController.addItems(title: "微信", image: UIImage(named: "ic_share_to_wechat")!, type: .important, tag: "wechat")
            moreViewController.addItems(title: "朋友圈", image: UIImage(named: "ic_share_to_wechat_circle")!, type: .important, tag: "WechatCircle")
//        }
//        if MonkeyKing.SupportedPlatform.weibo.isAppInstalled {
            moreViewController.addItems(title: "微博", image: UIImage(named: "ic_share_to_weibo")!, type: .important, tag: "weibo")
//        }
//        if MonkeyKing.SupportedPlatform.qq.isAppInstalled {
            moreViewController.addItems(title: "QQ", image: UIImage(named: "ic_account_qq")!, type: .important, tag: "QQ")
            moreViewController.addItems(title: "QQ空间", image: UIImage(named: "ic_share_to_qqzone")!, type: .important, tag: "QQZone")
//        }
//        if MonkeyKing.SupportedPlatform.pocket.isAppInstalled {
            moreViewController.addItems(title: "Pocket", image: UIImage(named: "ic_share_to_wechat")!, type: .important, tag: "Pocket")
//        }
        moreViewController.addItems(title: "系统", image: UIImage(named: "ic_share_to_wechat")!, type: .important, tag: "Activity")
        moreViewController.addItems(title: "Safari打开", image: UIImage(named: "ic_share_to_wechat")!, type: .normal, tag:"safari")
        moreViewController.addItems(title: "复制链接", image: UIImage(named: "ic_share_to_wechat")!, type: .normal, tag:"copylink")
        moreViewController.addItems(title: "刷新", image: UIImage(named: "ic_share_to_wechat")!, type: .normal, tag:"refresh")
        moreViewController.showFromBottom()
    }
    
    func moreView(_ moreview: YFMoreViewController, didSelectItemAt tag: String, type: YFMoreItemType) {
    
        let url = URL(string: "http://www.baidu.com")!
        let title = self.title!
        let info = MonkeyKing.Info(
            title: title,
            description: "",
            thumbnail: nil,
            media: .url(url)
        )
        // switch里必须包含default
        switch tag {
        case "wechat":
            MonkeyKing.deliver(.weChat(.session(info: info))) { result in
            }
            return
        case "safari":
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            break
        case "copylink":
            let paste = UIPasteboard.general
            paste.string = "http://www.baidu.com"
            break
        default:
            break
        }
    }
}

extension ShareViewController: WKNavigationDelegate {
    
}

extension ShareViewController {
    
    // 关闭
    @objc fileprivate func closeItemClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func customBackItemClicked() {
        if webView.goBack() != nil {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
