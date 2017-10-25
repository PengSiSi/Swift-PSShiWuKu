//
//  TableViewSectionHeaderVC.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/25.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class TableViewSectionHeaderVC: BaseViewController, UITableViewDelegate, UITableViewDataSource, SwipeableSectionHeaderDelegate {

    var tableView: UITableView!
    var headers: [String]!
    var titles: [[String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.titles =  [["UILabel 标签","UIButton 按钮"],
                          ["UIDatePiker 日期选择器","UITableView 表格视图"],
                          ["UICollectionView 网格"]
        ]
        
        self.headers = [
            "常见 UIKit 控件",
            "中级 UIKit 控件",
            "高级 UIKit 控件"
        ]
        // 表视图
        self.tableView = UITableView(frame: self.view.bounds, style: .grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //创建一个重用的单元格
        self.tableView.register(UITableViewCell.self,
                                forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView)
        
        // 接收通知
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "beginSwipeOut"), object: nil, queue: nil) { (notification) in
//            print("通知...")
//        }
    }
    
//    deinit {
//        
//        NotificationCenter.default.removeObserver(self)
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.titles[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftCell", for: indexPath)
        cell.textLabel?.text = self.titles[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = SwipeOutSectionHeaderView()
        headerView.delegate = self
        headerView.titleLabel.text = self.headers[section]
        headerView.section = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    //设置单元格的编辑的样式
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath)
        -> UITableViewCellEditingStyle {
            return UITableViewCellEditingStyle.delete
    }
    
    //设置确认删除按钮的文字
    func tableView(_ tableView: UITableView,
                   titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    //单元格编辑后（删除或插入）的响应方法
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        self.titles[indexPath.section].remove(at: indexPath.row)
        self.tableView.reloadData()
        print("你确认了删除按钮")
    }
    
    // SwipeableSectionHeaderDelegate
    
    func deleteSection(section: Int) {
        self.headers.remove(at: section)
        self.titles.remove(at: section)
        self.tableView.reloadData()
    }
}
