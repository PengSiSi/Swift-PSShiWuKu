//
//  TableViewRowHeightVC.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/18.
//  Copyright © 2017年 思 彭. All rights reserved.

// tableView的cell自适应行高

import UIKit

class TableViewRowHeightVC: BaseViewController,UITableViewDataSource,UITableViewDelegate {

    var tableView:UITableView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView?.register(TableViewCell1.self, forCellReuseIdentifier: "cell1")

        view.addSubview(tableView!)
        
        // tableView自适应行高
        tableView?.estimatedRowHeight = 44.0
        tableView?.rowHeight = UITableViewAutomaticDimension
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
            //        cell.textLabel?.text = "xxxx\(indexPath.row)"
            cell.titleLab?.text = "我是假数据"
            if indexPath.row % 2==0 {
                cell.despLab?.text = "我是假数据我是假数据我是假数据"
            } else {
                if indexPath.row % 3 == 0{
                    cell.despLab?.text = "我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据"
                    
                    // 这里好像cell的控件隐藏显示，高度不能准确计算到
                    //                cell.imageContainerView?.isHidden = true
                }
                else{
                    cell.despLab?.text = "我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据"
                }
            }
            return cell
        } else {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell1
            cell1.despLab?.text = "我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据我是假数据111"
            return cell1
        }
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("第\(indexPath.row)行被点击了")
    }
}
