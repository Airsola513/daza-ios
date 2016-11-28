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

class Notification: Model {
    
    var user_id: Int!               // 用户Id
    var unread: Bool!               // 通知未读
    var reason: String!             // 原因
    var from_user_id: String!       // 来自用户Id
    var topic_id: Int!              // 主题Id
    var article_id: Int!            // 文章Id
    var article_comment_id: Int!    // 文章评论Id
    var title: String!              // 标题
    var content: String!            // 内容
    var from_user: User!            // 来自用户（对象）
    var topic: Topic!
    var article: Article!
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        user_id             <- map["user_id"]
        unread              <- map["unread"]
        reason              <- map["reason"]
        from_user_id        <- map["from_user_id"]
        topic_id            <- map["topic_id"]
        article_id          <- map["article_id"]
        article_comment_id  <- map["article_comment_id"]
        title               <- map["title"]
        content             <- map["content"]
        from_user           <- map["from_user"]
        topic               <- map["topic"]
        article             <- map["article"]
    }
    
}
