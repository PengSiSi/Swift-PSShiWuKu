//
//  FeedHomeListModel.swift
//  SwiftPSShiWuKu
//
//  Created by 思 彭 on 2017/8/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

import UIKit
import ObjectMapper

/*
 "item_id": 11847,
 "title": "减脂餐",
 "card_image": "http://one.boohee.cn/food/2017/7/11/938C4D36-E264-428C-87A7-CA08F766221E.jpg?imageView2/2/w/640",
 "publisher": "Libra迷雾F",
 "publisher_avatar": "http://tvax2.sinaimg.cn/crop.0.0.1241.1241.180/a3fa084dly8fdwy0rrip5j20yi0yhdm2.jpg",
 "description": "200克樱桃番茄\n200克黄瓜\n50克紫薯\n120克蒸南瓜\n155克烤黄金鲽\n100克烤鸡胸",
 "content_type": 5,
 "type": "food_card",
 "like_ct": 729
 */
class FeedHomeListModel: Mappable {

    var item_id: Int = 0 //字符串写成可选的
    var title: String?
    var card_image: String?
    var publisher: String?
    var publisher_avatar: String?
    var description: String?
    var content_type: Int = 0
    var type: String?
    var like_ct: Int = 0

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        item_id <- map["item_id"]
        title <- map["title"]
        card_image <- map["card_image"]
        publisher <- map["publisher"]
        publisher_avatar <- map["publisher_avatar"]
        description <- map["description"]
        content_type <- map["content_type"]
        type <- map["type"]
        like_ct <- map["like_ct"]
    }
}
