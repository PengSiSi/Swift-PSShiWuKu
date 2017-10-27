//
//  SearchDemoViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class SearchDemoViewController: BaseViewController {

    //展示列表
    var tableView: UITableView!
    
    //搜索控制器
    var countrySearchController = UISearchController()
    
    //原始数据集
    let schoolArray = ["A","清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学","B", "C",
                       "北京航空航天大学","北京理工大学","北京科技大学","中国政法大学",
                       "中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学",
                       "华东师范大学","上海大学","河北工业大学"]
    //搜索过滤后的结果集
    var searchArray: [String] = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = true
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建表视图
        let tableViewFrame = CGRect(x: 0, y: 20, width: self.view.frame.width,
                                    height: self.view.frame.height - 20)
        self.tableView = UITableView(frame: tableViewFrame, style:.plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
        
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self   //两个样例使用不同的代理
            controller.searchBar.placeholder = "搜索"
            controller.searchBar.tintColor = UIColor.black
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // 开发模式和发布模式区别
        #if DEBUG
            
        #endif
    }
}

extension SearchDemoViewController: UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.countrySearchController.isActive {
            return self.searchArray.count
        } else {
            return self.schoolArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.selectionStyle = .none
        if self.countrySearchController.isActive {
            cell.textLabel?.text = self.searchArray[indexPath.row];
        } else {
            cell.textLabel?.text = self.schoolArray[indexPath.row];
        }
        return cell
    }
    
    // 实时搜索
    func updateSearchResults(for searchController: UISearchController) {
        self.searchArray = self.schoolArray.filter({ (school) -> Bool in
            return school.contains(searchController.searchBar.text!)
        })
    }
}
