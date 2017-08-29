//
//  CategoryModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/26.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

class CategoryModel: Mappable {

    var id: Int = 0 //字符串写成可选的
    var name: String?  //基本数据类型要赋个初值
    var image_url: String?
    var sub_category_count: Int = 0
    var sub_categories: [SubCategoriesModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image_url <- map["image_url"]
        sub_category_count <- map["sub_category_count"]
        sub_categories <- map["sub_categories"]
    }
}

