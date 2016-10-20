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

class Tag: Model {

    var name: String!           // 名称
    var slug: String!           // Slug
    var standard_name: String!  // 标准名称
    var image_url: String!      // 图片链接（原始尺寸）
    var description: String!    // 描述
    var article_count: Int = 0  // 文章数
    
    required init?(_ map: Map) {
        super.init(map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map)
        name            <- map["name"]
        slug            <- map["slug"]
        standard_name   <- map["standard_name"]
		image_url       <- map["image_url"]
		description     <- map["description"]
        article_count   <- map["article_count"]
    }
    
    var image_small_url: String {
        get {
            return Thumbnail(value: self.image_url).small()
        }
    }

}