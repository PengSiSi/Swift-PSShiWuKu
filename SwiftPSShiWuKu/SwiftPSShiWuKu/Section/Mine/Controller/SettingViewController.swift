//
//  SettingViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    
    // 标题
    var titleArray: [String]? = []
    // 内容
    var contentArray: [String]? = []
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.navigationController?.navigationBar.isTranslucent = false
        initialData()
        setupUI()
    }
    
    // 初始化数据
    func initialData() {
        titleArray = ["账号安全", "清除缓存", "给我们提个建议", "给我们评个分吧", "将食物库分享给朋友们", "HealthKit设置"]
        contentArray = ["未验证", "10.11M", "", "", "", ""]
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = setupFooterView()
        tableView?.tableHeaderView = UIView()
        tableView?.register(SettingTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 44))
        let logOutButton = UIButton(frame: CGRect(x: 20, y: 0, width: k_ScreenWidth - 40, height: 44))
        logOutButton.backgroundColor = UIColor.red
        logOutButton.setTitle("退出登录", for: .normal)
        logOutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        footerView.addSubview(logOutButton)
        return footerView
    }
    
    func logout() {
        let logginVc = LoginViewController()
        self.navigationController?.pushViewController(logginVc, animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.configureCell(title: titleArray?[indexPath.row], subTitle: contentArray?[indexPath.row])
//        cell.title = self.titleArray?[indexPath.row]
//        cell.subTitle = self.contentArray?[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.subTitleLabel?.textColor = UIColor.red
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
