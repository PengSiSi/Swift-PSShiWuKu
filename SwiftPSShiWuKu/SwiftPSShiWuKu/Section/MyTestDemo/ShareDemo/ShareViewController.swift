//
//  ShareViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import YFMoreViewController
import MonkeyKing

class ShareViewController: BaseViewController, YFMoreViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "分享"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_photo_share"), style: .plain, target: self, action: #selector(shareAction(_:)))
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
