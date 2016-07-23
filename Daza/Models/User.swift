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

class User: Model {
    
    var username: String!   // 用户名
    var email: String!      // 邮箱
    var mobile: String!     // 手机
    var name: String!       // 名称
    var first_name: String! // 名
    var last_name: String!  // 姓
    var avatar_url: String! // 头像
    var age: Int!           // 年龄
    var gender: String!     // 性别 = ['unspecified', 'secrecy', 'male', 'female'],
    var birthday: String!   // 生日
    var country: String!    // 国家
    var city: String!       // 城市
    var address: String!    // 地址
    var phone: String!      // 电话
    var company: String!    // 公司
    var website: String!    // 主页
    var bio: String!        // 简介
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        username    <- map["username"]
        email       <- map["email"]
        mobile      <- map["mobile"]
        name        <- map["name"]
        first_name  <- map["first_name"]
        last_name   <- map["last_name"]
        avatar_url  <- map["avatar_url"]
        age         <- map["age"]
        gender      <- map["gender"]
        birthday    <- map["birthday"]
        country     <- map["country"]
        city        <- map["city"]
        address     <- map["address"]
        phone       <- map["phone"]
        company     <- map["company"]
        website     <- map["website"]
        bio         <- map["bio"]
    }
    
}