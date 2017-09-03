//
//  HomeSearchViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/3.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class HomeSearchViewController: BaseViewController {

    // 内容
    var contentArray: [String]? = []
    
    var tableView: UITableView?
    var searchBar: UISearchBar?
    let sectionTitleArray: [String] = ["最近搜过", "大家都在搜"]
    var latestSearchArray: [String]? = ["苹果", "核桃"]
    var commonSearchArray: [String]? = ["苹果", "核桃", "梨子","苹果", "核桃", "梨子"]

    // 是否是搜索
    var isSearch: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.searchBar?.removeFromSuperview()
        self.searchBar = nil
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = UIView()
        tableView?.register(CommonSearchTableViewCell.self, forCellReuseIdentifier: "CommonSearchCell")
        tableView?.register( UINib(nibName: "HistorySearchTableViewCell", bundle: nil), forCellReuseIdentifier: "HistorySearchTableViewCell")
        tableView?.register( UINib(nibName: "HomeListTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeListTableViewCell")
    }
    
    func setupSearchBar() {
    
        // 实例化
        searchBar = UISearchBar(frame: CGRect(x: 40, y: 0, width: k_ScreenWidth - 80, height: 44))
        self.navigationController?.navigationBar.addSubview(searchBar!)
        searchBar!.backgroundColor = UIColor.clear
        searchBar?.delegate = self
        searchBar!.barStyle = .default
        searchBar!.barTintColor = UIColor.clear
        searchBar!.placeholder = "请输入食物名称"
        searchBar!.tintColor = UIColor.red
        searchBar!.searchBarStyle = .minimal
        // 注意：showsBookmarkButton、showsSearchResultsButton不能同时设置
        searchBar!.showsCancelButton = false
        searchBar!.showsBookmarkButton = true
        searchBar!.setImage(UIImage(named: "ic_homepage_scan"),
                            for: .bookmark, state: UIControlState.normal)
        // searchbar.showsSearchResultsButton = true
        searchBar!.delegate = self
        // 键盘类型设置
        searchBar!.keyboardType = .default
        searchBar!.returnKeyType = .search
        searchBar!.isSecureTextEntry = false
        // 输入源设置（与textfiele、或textview类似）
        // searchbar.inputAccessoryView = nil
        // searchbar.inputView = nil
        // 第一响应，即进入编辑状态
        searchBar!.becomeFirstResponder()
        // 放弃第一响应，即结束编辑  
        // searchbar.resignFirstResponder()  
        // searchbar.endEditing(true) // 结束编辑
        
        // 右边搜索按钮
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: k_ScreenWidth - 40, y: 7, width: 30, height: 30)
        rightBtn.setImage(UIImage(named: "ic_input_search"), for: .normal)
        rightBtn.addTarget(self, action: #selector(didClickSearchButton(button:)), for: .touchUpInside)
        self.navigationController?.navigationBar.addSubview(rightBtn)
    }
}

extension HomeSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !isSearch! {
            return self.sectionTitleArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isSearch! {
            if section == 0 {
                return (self.latestSearchArray?.count)!
            } else {
                return (commonSearchArray?.count)! / 2
            }
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !isSearch! {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "HistorySearchTableViewCell", for: indexPath) as! HistorySearchTableViewCell
                cell.accessoryType = .disclosureIndicator
                cell.titleStr = self.latestSearchArray?[indexPath.row]
                cell.selectionStyle = .none
                return cell
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommonSearchCell", for: indexPath) as! CommonSearchTableViewCell
                cell.label1?.text = self.commonSearchArray?[indexPath.row];
                cell.label2?.text = self.commonSearchArray?[indexPath.row];
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListTableViewCell", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if !isSearch! {
            
            return self.sectionTitleArray[section]
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if !isSearch! {
            if section == 0 {
                let clearButton = UIButton(type: .custom)
                clearButton.frame = CGRect(x: k_ScreenWidth - 100, y: 0, width: 100, height: 44)
                clearButton.setImage(UIImage(named: "ic_photo_delete"), for: .normal)
                clearButton.titleLabel?.font  = UIFont.systemFont(ofSize: 15)
                clearButton.setTitle("清空历史记录", for: .normal)
                clearButton.setTitleColor(UIColor.gray, for: .normal)
                return clearButton
            }
            return UIView()
        } else{
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if !isSearch! {
            if section == 0 && (self.latestSearchArray?.count)! > 0 {
                return 44
            }
            return 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if !isSearch! {
            if section == 0 {
                if (self.latestSearchArray?.count)! > 0  {
                    return 44
                } else {
                    return 0
                }
            }
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !isSearch! {
            return 44
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension HomeSearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool  {
        
        isSearch = false
        self.tableView?.reloadData()
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)  {
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        print("搜索")
        isSearch = true
        self.tableView?.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool  {
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("搜索")
        isSearch = true
        self.searchBar?.resignFirstResponder()
        self.tableView?.reloadData()
    }
    
    @available(iOS 2.0, *)
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) // called when bookmark button pressed
    {
        
    }
    
    @available(iOS 2.0, *)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) // called when cancel button pressed
    {
        
    }
    
    @available(iOS 3.2, *)
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) // called when search results button pressed
    {
        
    }
    
    //        @available(iOS 3.0, *)
    //        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    //
    //        }
}

extension HomeSearchViewController {
    
    func didClickSearchButton(button: UIButton) {
        
    }
}
