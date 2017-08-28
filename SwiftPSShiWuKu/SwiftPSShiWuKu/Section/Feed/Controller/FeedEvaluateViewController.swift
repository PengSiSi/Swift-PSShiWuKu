//
//  FeedEvaluateViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
// Feed -> 评测

import UIKit
import ObjectMapper

class FeedEvaluateViewController: BaseViewController {

    var tableView: UITableView?
    var dataArray:[FeedEvaluateModel] = [FeedEvaluateModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()

    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = UIView()
        tableView?.register( UINib(nibName: "FeedEvaluateCell", bundle: nil), forCellReuseIdentifier: "FeedEvaluateCell")
    }
}

// MARK: 数据请求
extension FeedEvaluateViewController {
    
    func loadData() {
        
        // http://food.boohee.com/fb/v1/feeds/category_feed?category=2&page=1
        let url = "http://food.boohee.com/fb/v1/feeds/category_feed?category=2&page=1"
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
                        print("response = \(response)")
            // json转model
            // 闭包里面需要self
            // 注意: 注意数据源数组需要定义数组类型,否则报错
            self.dataArray = Mapper<FeedEvaluateModel>().mapArray(JSONArray: response["feeds"] as! [[String : Any]])
            self.tableView?.reloadData()
        }, failture: { (error) in
            print("error = \(error)")
        })
    }
}

extension FeedEvaluateViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (dataArray.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (dataArray?.count)!
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedEvaluateCell", for: indexPath) as! FeedEvaluateCell
        let model: FeedEvaluateModel = self.dataArray[indexPath.section]
        cell.configureCell(imgName: model.background, topStr: model.source, titleStr: model.title, readCountStr: model.tail)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 156
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model: FeedEvaluateModel = self.dataArray[indexPath.section]
        let feedDetailVc = FeedDetailViewController()
        feedDetailVc.url = model.link
        self.navigationController?.pushViewController(feedDetailVc, animated: true)
    }
}

