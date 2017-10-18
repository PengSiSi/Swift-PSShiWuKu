//
//  CollectModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import RealmSwift

class CollectModel: Object {

    @objc dynamic var background = ""
    @objc dynamic var image_url = ""
    @objc dynamic var content_type = 0
    @objc dynamic var link = ""
    @objc dynamic var source = ""
    @objc dynamic var tail = ""
    @objc dynamic var title = ""
    @objc dynamic var type = ""

}
