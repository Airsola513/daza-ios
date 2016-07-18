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

class Topic: Model {
    
    var type: String?               // 类型
    var name: String?               // 名称
    var website: String?            // 主页
    var image_url: String?          // 图片网址
    var description: String?        // 描述
    var source_format: String?      // 文章来源格式 = ['atom', 'rss']
    var source_program: String?     // 文章来源程序 = ['wordpress', 'jekyll', 'ghost', 'hexo', 'typecho', 'farbox']
    var source_link: String?        // 文章来源链接
    var article_count: Int = 0      // 文章数
    var subscriber_count: Int = 0   // 订阅数
    var user: User?
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        type                <- map["type"]
        name                <- map["name"]
        website             <- map["website"]
        image_url           <- map["image_url"]
        description         <- map["description"]
        source_format       <- map["source_format"]
        source_program      <- map["source_program"]
        source_link         <- map["source_link"]
        article_count       <- map["article_count"]
        subscriber_count    <- map["subscriber_count"]
        user                <- map["user"]
    }
    
}