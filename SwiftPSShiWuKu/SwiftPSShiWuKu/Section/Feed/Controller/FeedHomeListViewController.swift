//
//  FeedHomeListViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
// Feed -> 首页

import UIKit
import ObjectMapper

class FeedHomeListViewController: BaseViewController {

    var collectionView: UICollectionView?
    var dataArray: [FeedHomeListModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()

    }
    
    func loadData() {
        
        let url = "http://food.boohee.com/fb/v1/feeds/category_feed?category=1&page=1"
        HTTPTool.shareInstance.requestData(.GET, URLString: url, parameters: nil, success: { (response) in
            print("response = \(response)")
            // json转model
            // 闭包里面需要self
            // 注意: 注意数据源数组需要定义数组类型,否则报错
            self.dataArray = Mapper<FeedHomeListModel>().mapArray(JSONArray: response["feeds"] as! [[String : Any]])
//            self.collectionView?.reloadData()
            self.setupUI()
        }, failture: { (error) in
            print("error = \(error)")
        })
    }

    func setupUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (k_ScreenWidth - 30) / 2, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: k_ScreenHeight - 64), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
//        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = GlobalColor()
        self.view.addSubview(collectionView!)
        collectionView?.register(UINib(nibName: "FeedHomeCell", bundle: nil), forCellWithReuseIdentifier: "FeedHomeCell")

    }
}

extension FeedHomeListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
         return (dataArray?.count)!
//        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedHomeCell", for: indexPath) as! FeedHomeCell
        let model = dataArray?[indexPath.row]
//        字符串类型转化
//        let str = NSString(string: "123")
//        str.intValue
        // 注意: 数字转字符串
        cell.configureCell(imageName: model?.card_image, titleStr: model?.title, desStr: model?.description, avarterImgName:"", nickNameStr: model?.publisher, likeCount: "\(String(describing: model?.like_ct))")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (k_ScreenWidth - 30) / 2, height: 240)
    }
}
