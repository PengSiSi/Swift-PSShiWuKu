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
        loadHomeData()
//        setupUI()
    }
    
    func setupUI() {
        createHearerView()
        createTableView()
    }
    
    func createHearerView() {
        headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 200))
        headerView?.block = {(text) -> () in
            print(text)
        }
        headerView?.beginEditBlock = {() -> () in
            print("开始编辑")
            let searchVc = HomeSearchViewController()
            self.navigationController?.pushViewController(searchVc, animated: true)
        }
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
    
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight - 64), style: .grouped)
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
            // 这里cell赋值cell会崩溃,数据源没有...这里先拿到值再设置tableView
            self.setupUI()
//            self.tableView.reloadData()
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
            cell.dataArray = groupArr?[indexPath.section].categories
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let sectionHeaderView = HomeSectionHeaderView(frame: CGRect(x: 20, y: 0, width: k_ScreenWidth - 40, height: 80))
            sectionHeaderView.closure = { (title) in
                print(title)
                let str = NSString(string: title)
                if str.isEqual(to: "扫码对比") {
                    let qrCodeScanVc = QRCodeScanViewController()
                    let qrCodeNav = BaseNavigationController(rootViewController: qrCodeScanVc)
                    self.present(qrCodeNav, animated: false, completion: nil)
                }
            }
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
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            // 到这里开始是cell不存在,所以直接使用数据源判断一次
            let array = groupArr?[indexPath.section].categories
            let rowCount = ((array?.count)! / 3)
            return CGFloat(rowCount * 90)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: HomeTableViewCellDelegate {
    
    func didClickCollectionViewCell(indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let homeListVc = HomeListViewController()
            let array = groupArr?[indexPath.section].categories
            let categoryModel = array?[indexPath.row]
            homeListVc.title = categoryModel?.name
            self.navigationController?.pushViewController(homeListVc, animated: true)
        } else {
            let searchVc = HomeSearchViewController()
            self.navigationController?.pushViewController(searchVc, animated: true)
        }
    }
}
