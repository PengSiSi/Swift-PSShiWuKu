//
//  HomeTableViewCell.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

protocol HomeTableViewCellDelegate: NSObjectProtocol {
    func didClickCollectionViewCell(indexPath: IndexPath);
}

class HomeTableViewCell: UITableViewCell {

    var collectionView: UICollectionView?
    weak var delegate: HomeTableViewCellDelegate?
    
    var dataArray: [CategoryModel]? {
        didSet {
            let rowCount = ((dataArray?.count)! / 3)
            collectionView?.frame = CGRect(x: 0, y: 0, width: Int(k_ScreenWidth), height: rowCount * 90)
            collectionView?.reloadData()
        }
    }
    
    // cell高度
    func cellHeight() -> CGFloat {
        
        // 行数  1.2.3: 1  4.5.6: 2  7.8.9: 3
        let rowCount = ((dataArray?.count)! / 3)
        collectionView?.frame = CGRect(x: 0, y: 0, width: Int(k_ScreenWidth), height: rowCount * 90)
        return CGFloat(rowCount * 90)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubViews()
        layOut()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createSubViews(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (k_ScreenWidth - 30) / 3, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: k_ScreenWidth, height: 240), collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = UIColor.white
        self.contentView.addSubview(collectionView!)
        collectionView?.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
    
    func layOut() {
        
    }

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (dataArray?.count)!
//        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let model = dataArray?[indexPath.row]
        cell.configureCell(imgName: model!.image_url!, title: model!.name!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate? .didClickCollectionViewCell(indexPath: indexPath)
    }
}
