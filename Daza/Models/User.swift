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
    
    var username: String!       // 用户名
    var email: String!          // 邮箱
    var mobile: String!         // 手机
    var name: String!           // 名称
    var first_name: String!     // 名
    var last_name: String!      // 姓
    var real_name: String!      // 真实姓名
    var avatar_url: String!     // 头像链接（原始尺寸）
    var use_avatar: Bool!       // 使用Gravatar头像
    var age: Int!               // 年龄
    var gender: String!         // 性别 = ['unspecified', 'secrecy', 'male', 'female'],
    var birthday: String!       // 生日
    var country: String!        // 国家
    var city: String!           // 城市
    var address: String!        // 地址
    var phone: String!          // 电话
    var company: String!        // 公司
    var website: String!        // 主页
    var bio: String!            // 简介
    var status: Int!            // 状态[ 0 => 'Unactive', 1 => 'Active']
    var site_admin: Bool!       // 站点管理员
    var followers_count: Int!   // 粉丝数
    var following_count: Int!   // 关注数
    var topic_count: Int!       // 主题数
    var article_count: Int!     // 文章数
    var configs: [UserConfig]!  // 用户配置
    var jwt_token: AccessToken! // JSON Web Token（https://jwt.io）
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        username        <- map["username"]
        email           <- map["email"]
        mobile          <- map["mobile"]
        name            <- map["name"]
        first_name      <- map["first_name"]
        last_name       <- map["last_name"]
        real_name       <- map["real_name"]
        avatar_url      <- map["avatar_url"]
        use_avatar      <- map["use_avatar"]
        age             <- map["age"]
        gender          <- map["gender"]
        birthday        <- map["birthday"]
        country         <- map["country"]
        city            <- map["city"]
        address         <- map["address"]
        phone           <- map["phone"]
        company         <- map["company"]
        website         <- map["website"]
        bio             <- map["bio"]
        status          <- map["status"]
        site_admin      <- map["site_admin"]
        followers_count <- map["followers_count"]
        following_count <- map["following_count"]
        topic_count     <- map["topic_count"]
        article_count   <- map["article_count"]
        configs         <- map["configs"]
        jwt_token       <- map["jwt_token"]
    }
    
    var avatar_small_url: String {
        get {
            return Thumbnail(value: self.avatar_url).small()
        }
    }

}