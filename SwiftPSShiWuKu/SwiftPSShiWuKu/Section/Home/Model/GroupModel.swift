//
//  GroupModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class GroupModel: Mappable {
    
    var kind: String?
    var categories: [CategoryModel]?  // 注意数组后要加?
    
//    init(dict: [String: AnyObject]) {
//        kind = dict["kind"] as? String
//        categories = dict["categories"] as! [CategoryModel]
//    }


    required init?(map: Map) {

    }

    func mapping(map: Map) {
        kind <- map["kind"]
        categories <- map["categories"]
    }
}
