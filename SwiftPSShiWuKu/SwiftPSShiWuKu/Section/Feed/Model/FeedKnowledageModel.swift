//
//  FeedKnowledageModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class FeedKnowledageModel: Mappable {

    var title: String?
    var source: String?
    var link: String?
    var tail: String?
    var images: [String]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        source <- map["source"]
        link <- map["link"]
        tail <- map["tail"]
        images <- map["images"]
    }
}
