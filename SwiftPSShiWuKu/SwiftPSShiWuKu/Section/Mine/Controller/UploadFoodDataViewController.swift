//
//  UploadFoodDataViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/6.
//  Copyright © 2017年 思 彭. All rights reserved.
// 上传食物数据页面

import UIKit

class UploadFoodDataViewController: BaseViewController {

    // 标题
    var titleArray: [String]? = []
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "上传食物"
        self.navigationController?.navigationBar.isTranslucent = false
        initialData()
        setupUI()
    }
    
    // 初始化数据
    func initialData() {
        titleArray = ["我上传的食物", "草稿箱"]
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = setupFooterView()
        tableView?.tableHeaderView = UIView()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupFooterView() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 64))
        let uploadButton = UIButton(frame: CGRect(x: 20, y: 20, width: k_ScreenWidth - 40, height: 44))
        uploadButton.backgroundColor = UIColor.red
        uploadButton.setTitle("上传食物", for: .normal)
        uploadButton.addTarget(self, action: #selector(uploadButtonAction), for: .touchUpInside)
        footerView.addSubview(uploadButton)
        return footerView
    }
    
    func uploadButtonAction() {
        let logginVc = LoginViewController()
        self.navigationController?.pushViewController(logginVc, animated: true)
    }
}

extension UploadFoodDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.text = titleArray![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

