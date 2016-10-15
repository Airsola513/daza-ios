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

class Asset: Model {
    
    var user_id: Int!           // 用户Id
    var target_type: String!    // 目标类型
    var target_id: String!      // 目标Id（或ShortId）
    var mime_type: String!      // MIME类型
    var size: String!           // 大小
    var url: Int!               // 链接
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        user_id         <- map["user_id"]
        target_type     <- map["target_type"]
        target_id       <- map["target_id"]
        mime_type       <- map["mime_type"]
        size            <- map["size"]
        url             <- map["url"]
    }
}