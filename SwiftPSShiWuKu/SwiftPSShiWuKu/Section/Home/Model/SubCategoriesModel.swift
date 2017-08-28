//
//  SubCategoriesModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class SubCategoriesModel: Mappable {

    var id: Int = 0
    var name: String?
    var image_url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image_url <- map["image_url"]
    }
}
