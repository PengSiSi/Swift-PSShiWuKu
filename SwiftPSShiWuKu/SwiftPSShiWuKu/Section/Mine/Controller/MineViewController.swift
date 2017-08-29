//
//  MineViewController.swift
//  PSTodayNews
//
//  Created by 思 彭 on 2017/8/17.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

let mineCellID = "MineCell"

class MineViewController: UITableViewController, MineHeaderViewDelegate {
    
    // 数据源数组
    var cells = [AnyObject]()
    var titleArr = ["我的照片", "我的收藏", "上传食物数据"];
    var imageNameArr = ["ic_my_photos.png", "ic_my_collect.png", "ic_my_upload.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    lazy var headerView: MineHeaderView = {
        
        let headerView = Bundle.main.loadNibNamed("MineHeaderView", owner: self, options: nil)?.last as! MineHeaderView
        headerView.delegate = self
        return headerView 
    }()
}

// MARK: - 设置界面
extension MineViewController {
    
    func setupUI() {
        view.backgroundColor = GlobalColor()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: mineCellID)
        let footerView = UIView()
        footerView.height = kMargin
        tableView.tableFooterView = footerView
        tableView.rowHeight = kMineCellH
//        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
    }
}

extension MineViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageNameArr.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: mineCellID, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: imageNameArr[indexPath.row])
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
                break;
            default:
                break
        }
    }
}

// 设置状态栏白色
extension MineViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}

extension MineViewController {
    
    func loginButtonDidClick() {
        print("登录");
//        let loginVc = LoginViewController()
        let personInfoVc = PersonInfoViewController()
        self.navigationController?.pushViewController(personInfoVc, animated: true)
    }
    
    func settingButtonDidClick() {
        print("设置")
        let settingVc = SettingViewController()
        self.navigationController?.pushViewController(settingVc, animated: true)
    }
}
