//
//  FeedKnowledgeViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
// Feed -> 知识

import UIKit
import ObjectMapper

class FeedKnowledgeViewController: BaseViewController {

    var tableView: UITableView?
    var dataArray:[FeedKnowledageModel] = [FeedKnowledageModel]()
    
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
        //        tableView?.register( UINib(nibName: "FeedEvaluateCell", bundle: nil), forCellReuseIdentifier: "FeedEvaluateCell")
        tableView?.register(FeedKnowledgeCell.self, forCellReuseIdentifier: "cell")
        tableView?.register(FeedKnowledageMultiImageCell.self, forCellReuseIdentifier: "FeedKnowledageMultiImageCell")
    }
}

// MARK: 数据请求
extension FeedKnowledgeViewController {
    
    func loadData() {
        
        // http://food.boohee.com/fb/v1/feeds/category_feed?category=2&page=1
        let url = "http://food.boohee.com/fb/v1/feeds/category_feed?category=3&page=1"
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
            print("response = \(response)")
            // json转model
            // 闭包里面需要self
            // 注意: 注意数据源数组需要定义数组类型,否则报错
            self.dataArray = Mapper<FeedKnowledageModel>().mapArray(JSONArray: response["feeds"] as! [[String : Any]])
            self.tableView?.reloadData()
        }, failture: { (error) in
            print("error = \(error)")
        })
    }
}

extension FeedKnowledgeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (dataArray.count)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return (dataArray?.count)!
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model: FeedKnowledageModel = self.dataArray[indexPath.section]
        if (model.images?.count)! > 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedKnowledageMultiImageCell", for: indexPath) as! FeedKnowledageMultiImageCell
            cell.configureCell(title: model.title!, source: model.source!, readCount: model.tail!, imageNameArr: model.images!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedKnowledgeCell
            cell.configureCell(title: model.title!, source: model.source!, readCount: model.tail!, imageNameArr: model.images!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model: FeedKnowledageModel = self.dataArray[indexPath.section]
        let feedDetailVc = FeedDetailViewController()
        feedDetailVc.url = model.link
        self.navigationController?.pushViewController(feedDetailVc, animated: true)
    }
}
