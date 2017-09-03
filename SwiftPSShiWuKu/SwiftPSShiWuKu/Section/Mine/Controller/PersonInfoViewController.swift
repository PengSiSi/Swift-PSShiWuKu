//
//  PersonInfoViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/27.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class PersonInfoViewController: BaseViewController {

    // 标题
    var titleArray: [String]? = []
    // 内容
    var contentArray: [String]? = []
    
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人资料"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveAction))
        initialData()
        setupUI()
    }
    
    // 初始化数据
    func initialData() {
        titleArray = ["用户名", "性别", "年龄", "身高", "体重"]
        contentArray = ["思思", "女", "24", "157", "55"]
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = self.createHeaderView()
        tableView?.register(PersonInfoTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension PersonInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonInfoTableViewCell
        cell.configureCell(title: titleArray?[indexPath.row], subTitle: contentArray?[indexPath.row])
        cell.selectionStyle = .none
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension PersonInfoViewController {
    
    func createHeaderView() -> UIView {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 150))
        let avaterImageView = UIImageView(frame: CGRect(x: (k_ScreenWidth - 60) / 2, y: (150 - 60) / 3, width: 60, height: 60))
        avaterImageView.backgroundColor = UIColor.green
        avaterImageView.layer.cornerRadius = 30
        avaterImageView.layer.masksToBounds = true
        headerView.addSubview(avaterImageView)
        return headerView
    }
}

extension PersonInfoViewController {
    
    func saveAction() {
        print("保存")
    }
    
    func configureCell(cell: PersonInfoTableViewCell, indexPath: IndexPath) {
        
    }
}
