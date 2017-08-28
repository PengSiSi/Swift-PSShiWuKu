//
//  HomeViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/17.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeViewController: BaseViewController {

    var tableView: UITableView!
    var headerView: HomeHeaderView?
    var groupArr: [GroupModel]? = [GroupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        setupUI()
        loadHomeData()
    }
    
    func setupUI() {
        createHearerView()
        createTableView()
    }
    
    func createHearerView() {
        headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 200))
//        self.view.bringSubview(toFront: headerView!)
        headerView?.block = {(text) -> () in
            print(text)
        }
//        self.tableView.tableHeaderView = headerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 隐藏导航栏的属性写到 `viewDidLoad()` 里不起作用。
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func createTableView() {
    
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.backgroundColor = GlobalColor()
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = headerView
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.register(HomeTableViewCell.self, forCellReuseIdentifier: "Homecell")
    }
}

extension HomeViewController {
    
    func loadHomeData() {
        //  get
        HTTPTool.shareInstance.requestData(.GET, URLString: "http://food.boohee.com/fb/v1/categories/list", parameters: nil, success: { (response) in
//            print("response = \(response)")  
            // json转model
            // 闭包里面需要self
            self.groupArr = Mapper<GroupModel>().mapArray(JSONArray: response["group"] as! [[String : Any]])
            self.tableView.reloadData()
        }, failture: { (error) in
            print("error = \(error)")
        })
   
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 44))
            label.text = "食物分类"
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            cell.contentView.addSubview(label)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Homecell", for: indexPath) as! HomeTableViewCell
//            cell.dataArray = groupArr?[indexPath.section].categories
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let sectionHeaderView = HomeSectionHeaderView(frame: CGRect(x: 20, y: 0, width: k_ScreenWidth - 40, height: 80))
            return sectionHeaderView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 80
        }
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            return 240
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
