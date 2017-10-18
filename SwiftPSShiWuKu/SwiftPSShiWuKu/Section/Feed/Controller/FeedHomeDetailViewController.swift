//
//  FeedHomeDetailViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/16.
//  Copyright © 2017年 思 彭. All rights reserved.

// 逛吃 -> 首页page的详情页

import UIKit
import ObjectMapper
import Kingfisher

class FeedHomeDetailViewController: BaseViewController {

    fileprivate var detailModel: FeedHomeDetailModel?
    fileprivate var topView: FeedHomeDetailTopView?
    fileprivate var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "查看详情"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_share_black"), style: .plain, target: self, action: #selector(shareAction))
        setupUI()
        // 加载数据
        loadData()
    }
    
    fileprivate func setupUI() {
        topView = Bundle.main.loadNibNamed("FeedHomeDetailTopView", owner: nil, options: nil)?.last as? FeedHomeDetailTopView
        topView?.frame = CGRect(x: 0, y: 64, width: k_ScreenWidth, height: 63)
        self.view.addSubview(topView!)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: (topView?.bottom)!, width: k_ScreenWidth, height: 300))
        imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(imageView!)
    }
    
    func loadData() {
        
        let url = "http://food.boohee.com/fb/v1/food_cards/11847"
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
            print("response1 = \(response)")
            // json转model
            // 闭包里面需要self
            // 注意: 注意数据源数组需要定义数组类型,否则报错
            self.detailModel = Mapper<FeedHomeDetailModel>().map(JSON: response)!
            // 请求到数据刷新显示
            self.updateTopView()
        }, failture: { (error) in
            print("error = \(error)")
        })
    }
    
    func updateTopView() {
        topView?.avaterImgView.kf.setImage(with: URL(string: (detailModel?.user_avatar)!))
        topView?.nickNameLabel.text = detailModel?.user_name
        topView?.timeLabel.text = detailModel?.post_date
        imageView?.kf.setImage(with: URL(string: (detailModel?.image_url)!))
    }
}

extension FeedHomeDetailViewController {
    
    @objc fileprivate func shareAction() {
        
    }
}
