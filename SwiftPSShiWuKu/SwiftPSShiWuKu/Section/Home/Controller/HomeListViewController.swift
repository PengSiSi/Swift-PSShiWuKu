//
//  HomeListViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class HomeListViewController: BaseViewController {

    var tableView: UITableView?
    var dataArray:[HomeModel] = [HomeModel]()
    
    lazy var levelArr: Array<Any>? = {
        return ["全部","包装谷薯","天然谷薯","谷薯制品"]
    }()
    
    lazy var menu: DropMenuView = {
        var menuView = DropMenuView.initMenu(size: CGSize(width:130,height:(self.levelArr?.count)! * 44))
        self.view.addSubview(menuView)
        return menuView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRightBarButtonItem()
        loadData()
        setupUI()
    }
    
    func setupUI() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        tableView?.tableFooterView = UIView()
        tableView?.tableHeaderView = UIView()
        tableView?.register( UINib(nibName: "HomeListTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeListTableViewCell")
//        tableView?.register(FeedEvaluateCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupRightBarButtonItem() {
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
        rightBtn.setTitle("全部", for: .normal)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.addTarget(self, action: #selector(didClickRightButton(button:)), for: .touchUpInside)
        let barItem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = barItem
    }
}

// MARK: 数据请求
extension HomeListViewController {
    
    func loadData() {
        
        // http://food.boohee.com/fb/v1/feeds/category_feed?category=2&page=1
        let url = "http://food.boohee.com/fb/v1/foods?value=2&order_by=1&kind=group&order_asc=0"
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
            print("response = \(response)")
            // json转model
            // 闭包里面需要self
            // 注意: 注意数据源数组需要定义数组类型,否则报错
            self.dataArray = Mapper<HomeModel>().mapArray(JSONArray: response["foods"] as! [[String : Any]])
            self.tableView?.reloadData()
        }, failture: { (error) in
            print("error = \(error)")
        })
    }
}

extension HomeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
//        return (dataArray.count)
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return (dataArray?.count)!
        return (dataArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeListTableViewCell", for: indexPath) as! HomeListTableViewCell
        let model: HomeModel = self.dataArray[indexPath.row]
        cell.configureCell(imageName: model.thumb_image_url, typeStr: model.name, kiloStr: "116", perStr: "")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 20))
        // 需要设置颜色,否则是透明的
        view.backgroundColor = UIColor.white
        let rightBtn = UIButton(type: .custom)
        rightBtn.frame = CGRect(x: 20, y: 0, width: 40, height: 20)
        rightBtn.setTitle("常见", for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightBtn.addTarget(self, action: #selector(sectionHeaderAction), for: .touchUpInside)
        rightBtn.titleLabel?.textAlignment = .left
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        view.addSubview(rightBtn)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeListViewController {
    
    // "常见"点击
    func sectionHeaderAction() {
        
    }
    
    // 点击了"全部"
    func didClickRightButton(button: UIButton) {
        print("点击了全部")
        if self.menu.isShow! == false {
            let point = CGPoint(x:k_ScreenWidth - 130,y: 0)
            self.menu.popupMenu(orginPoint:point, arr: self.levelArr!)
            self.menu.didSelectIndex = { [unowned self] (index:Int) in
                print( "选中--  \(index) -行 -- \(String(describing: self.levelArr?[index]))")
            }
        }else{
            
            self.menu.packUpMenu()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.menu.packUpMenu()
    }
}
