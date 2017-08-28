//
//  FeedEvaluateModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class FeedEvaluateModel: Mappable {

    var background: String? //字符串写成可选的
    var image_url: String?
    var content_type: Int = 0
    var link: String?
    var source: String?
    var tail: String?
    var title: String?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        background <- map["background"]
        image_url <- map["image_url"]
        content_type <- map["content_type"]
        link <- map["link"]
        source <- map["source"]
        tail <- map["tail"]
        title <- map["title"]
        type <- map["type"]
    }
}
