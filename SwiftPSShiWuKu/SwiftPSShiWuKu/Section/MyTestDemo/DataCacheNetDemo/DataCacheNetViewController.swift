//
//  DataCacheNetViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class DataCacheNetViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "数据缓存Demo"
        loadData()
    }
    
    func loadData() {
        
        let url = "http://api.travels.app887.com/api/Articles.action"
        let params = ["keyword" : "", "npc" : "0", "opc" : "20", "type" : "热门视频", "uid" : "2321"]

    }
}
