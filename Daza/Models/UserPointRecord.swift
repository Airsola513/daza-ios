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

class UserPointRecord: Model {
    
    var user_id: Int!               // 用户Id
    var point: Int = 0              // 当前积分值
    var used_type: String!          // 变化类型
    var used_point: Int!            // 变化积分值
    var used_target_type: String!   // 变化目标类型
    var used_target_id: Int!        // 变化目标Id
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        user_id             <- map["user_id"]
        point               <- map["point"]
        used_type           <- map["used_type"]
        used_point          <- map["used_point"]
        used_target_type    <- map["used_target_type"]
        used_target_id      <- map["used_target_id"]
    }
    
}