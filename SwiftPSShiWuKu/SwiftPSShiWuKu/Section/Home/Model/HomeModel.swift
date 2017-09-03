//
//  HomeModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/9/2.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

/*
 {
 calcium = "56.0";
 calory = 144;
 carbohydrate = "2.8";
 cholesterol = "585.0";
 code = "jidan_junzhi";
 copper = "0.2";
 fat = "8.8";
 "fiber_dietary" = "0.0";
 "health_light" = 1;
 id = 910;
 iodine = "27.2";
 iron = "2.0";
 "is_liquid" = 0;
 kalium = "154.0";
 lactoflavin = "0.3";
 magnesium = "10.0";
 manganese = "0.0";
 name = "\U9e21\U86cb";
 natrium = "131.5";
 niacin = "0.2";
 protein = "13.3";
 selenium = "14.3";
 thiamine = "0.1";
 "thumb_image_url" = "http://s.boohee.cn/house/food_mid/mid_photo_2015131131916910.jpg";
 "vitamin_a" = "234.0";
 "vitamin_c" = "";
 "vitamin_e" = "1.8";
 weight = 100;
 zinc = "1.1";
 },
 */

class HomeModel: Mappable {

    var calcium: String?
    var carbohydrate: String?  //基本数据类型要赋个初值
    var cholesterol: String?
    var calory: Int = 0
    var code: String?
    var copper: String?
    var fat: String?
    var fiber_dietary: String?
    var name: String?
    var thumb_image_url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        calcium <- map["calcium"]
        carbohydrate <- map["carbohydrate"]
        cholesterol <- map["cholesterol"]
        calory <- map["calory"]
        code <- map["code"]
        copper <- map["copper"]
        fat <- map["fat"]
        fiber_dietary <- map["fiber_dietary"]
        name <- map["name"]
        thumb_image_url <- map["thumb_image_url"]
    }
}
