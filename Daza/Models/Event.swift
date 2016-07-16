/**
 * Copyright (C) 2015 JianyingLi <lijy91@foxmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//import RealmSwift
import ObjectMapper

class Event: Model {
    
    var user_id: Int?            // 用户Id
    var title: String?           // 标题
    var content: String?         // 内容
    var start_at: String?        // 开始时间
    var end_at: String?          // 结束时间
    var organizer: String?       // 主办方
    var organizer_link: String?  // 主办方链接
    var city: String?            // 城市
    var location: String?        // 位置
    var longitude: Double?       // 经度
    var latitude: Double?        // 纬度
    var like_count: Int?         // 喜欢数
    var view_count: Int?         // 阅读数
    var comment_count: Int?      // 评论数
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        user_id         <- map["user_id"]
        title           <- map["title"]
        content         <- map["content"]
        start_at        <- map["start_at"]
        end_at          <- map["end_at"]
        organizer       <- map["organizer"]
        organizer_link  <- map["organizer_link"]
        city            <- map["city"]
        location        <- map["location"]
        longitude       <- map["longitude"]
        latitude        <- map["latitude"]
        like_count      <- map["like_count"]
        view_count      <- map["view_count"]
        comment_count   <- map["comment_count"]
    }
    
}