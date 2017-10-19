//
//  ImageBrowserViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class ImageBrowserViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate, HJImageBrowserDelegate {
    
    var tableView:UITableView?;
    var theImage = UIImage()
    var theIndex = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ImageBrowserDemo"
        setupTableView()
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self;
        tableView?.dataSource = self;
        tableView?.register(UINib(nibName: "ImageBrowserTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageBrowserTableViewCell")
        view.addSubview(tableView!)
        
        // tableView自适应行高
        tableView?.estimatedRowHeight = 500
        tableView?.rowHeight = UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageBrowserTableViewCell", for: indexPath) as! ImageBrowserTableViewCell
        cell.selectionStyle = .default
        // 图片的随机个数
        var num = Int(arc4random_uniform(6)) + 1
        if num == 0 {
            num = 7
        }
        if indexPath.row == 0 {
            num = 8
        }
        cell.assignToViews(num: num)
        
        // 图片点击大图浏览
        cell.showImageAction = {
            self.theImage = $2
            self.theIndex = $0
            let imageBrowser = HJImageBrowser()
            imageBrowser.delegate = self
        // bottomView 这个一定要填写你点击的imageView的直接父视图
        // cell.viewWithTag(100) 这个就是cell类里面的那个images（UIView）我在Xib里面设置的
            imageBrowser.bottomView = cell.viewWithTag(100)
        // 当前点击的图片在该数组中的位置
            imageBrowser.indexImage = $0
            imageBrowser.defaultImage = $2
            imageBrowser.arrayImage = $1 as! [String]
            imageBrowser.show()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("第\(indexPath.row)行被点击了")
    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        return 600
//    }
}

//MARK: HJImageBrowserDelegate

extension ImageBrowserViewController {

    func getTheThumbnailImage(_ indexRow: Int) -> UIImage {
        
        // 点击图片之后，放大过程中显示的那张图片
        return theImage
    }
}

