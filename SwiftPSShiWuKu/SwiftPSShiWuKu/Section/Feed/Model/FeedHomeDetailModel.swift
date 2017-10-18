//
//  FeedHomeDetailModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/10/16.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

/*
 {
 "user_key" : "84273dd3-acba-453f-bd22-7502a1d48c93",
 "id" : 11847,
 "post_date" : "2017-07-11T22:44:46.000+08:00",
 "user_avatar" : "http:\/\/tvax2.sinaimg.cn\/crop.0.0.1241.1241.180\/a3fa084dly8fdwy0rrip5j20yi0yhdm2.jpg",
 "like_ct" : 939,
 "description" : "200克樱桃番茄\n200克黄瓜\n50克紫薯\n120克蒸南瓜\n155克烤黄金鲽\n100克烤鸡胸",
 "title" : "减脂餐",
 "image_url" : "http:\/\/one.boohee.cn\/food\/2017\/7\/11\/938C4D36-E264-428C-87A7-CA08F766221E.jpg?",
 "food_code" : "",
 "user_name" : "Libra迷雾F"
 }
 */
class FeedHomeDetailModel: Mappable {

    var id: Int = 0 //字符串写成可选的
    var title: String?
    var image_url: String?
    var food_code: String?
    var post_date: String?
    var description: String?
    var user_key: Int = 0
    var like_ct: Int = 0
    var user_name: String?
    var user_avatar: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image_url <- map["image_url"]
        food_code <- map["food_code"]
        post_date <- map["post_date"]
        description <- map["description"]
        user_key <- map["user_key"]
        user_name <- map["user_name"]
        user_avatar <- map["user_avatar"]
        like_ct <- map["like_ct"]
    }
}
