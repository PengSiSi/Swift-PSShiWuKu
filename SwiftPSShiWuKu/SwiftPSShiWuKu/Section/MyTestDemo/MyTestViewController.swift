//
//  MyTestViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let cellID = "MyTestCell"

class MyTestViewController: UITableViewController {
    
    // 数据源数组
    var cells = [AnyObject]()
    var titleArr = ["BMPlayerDemo", "自定义导航栏titleView", "TableView自适用高度", "ImageBrowserDemo"];
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "MyTestDemo"
        setupUI()
    }
}

// MARK: - 设置界面
extension MyTestViewController {
    
    func setupUI() {
        view.backgroundColor = GlobalColor()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        let footerView = UIView()
        footerView.height = kMargin
        tableView.tableFooterView = footerView
        tableView.rowHeight = kMineCellH
        //        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView()
    }
}

extension MyTestViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArr.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = titleArr[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let BmPlayDemoVc = BMPlayerDemoViewController()
            self.navigationController?.pushViewController(BmPlayDemoVc, animated: true)
            break;
        case 1:
            let customNavDemoVc = CustomNavigationBarVC()
            self.navigationController?.pushViewController(customNavDemoVc, animated: true)
            break;
        case 2:
            let tableViewRowHeightVc = TableViewRowHeightVC()
            self.navigationController?.pushViewController(tableViewRowHeightVc, animated: false)
            break;
        case 3:
            let imageBrowserVc = ImageBrowserViewController()
            self.navigationController?.pushViewController(imageBrowserVc, animated: false)
            break;
        default:
            break
        }
    }
}

// 设置状态栏白色
extension MyTestViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}

extension MyTestViewController {
    
}

