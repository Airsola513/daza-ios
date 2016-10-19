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

class Category: Model {
    
    static let ID_LATEST: Int  = -1; // 最新
    static let ID_POPULAR: Int = -2; // 推荐
    
    var slug: String!           // Slug
    var name: String!           // 名称
    var image_url: String!      // 图片链接（原始尺寸）
    var description: String!    // 描述
    var topic_count: Int!       // 主题数
    var article_count: Int!     // 文章数

    override init() {
        super.init()
    }
    
    init(id: Int, name: String, slug: String) {
        super.init()
        self.id = id
        self.name = name
        self.slug = slug
    }
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        slug            <- map["slug"]
        name            <- map["name"]
        image_url       <- map["image_url"]
        description     <- map["description"]
        topic_count     <- map["topic_count"]
        article_count   <- map["article_count"]
    }

    static func latest() -> Category {
        return Category(id: ID_LATEST, name: "最新", slug: "latest")
    }

    static func popular() -> Category {
        return Category(id: ID_POPULAR, name: "推荐", slug: "popular")
    }
}