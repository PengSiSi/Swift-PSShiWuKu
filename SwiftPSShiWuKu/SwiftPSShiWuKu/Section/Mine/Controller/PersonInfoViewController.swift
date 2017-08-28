//
//  PersonInfoViewController.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/27.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit

class PersonInfoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "个人资料"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveAction))
    }

}

extension PersonInfoViewController {
    
    func saveAction() {
        print("保存")
    }
}
