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

class Pagination: Mappable {

    var total: Int!
    var per_page: Int!
    var current_page: Int!
    var last_page: Int!
    var from: Int!
    var to: Int!

    required init?(_ map: Map) {
    }

    func mapping(map: Map) {
        total           <- map["total"]
        per_page        <- map["per_page"]
        current_page    <- map["current_page"]
        last_page       <- map["last_page"]
        from            <- map["from"]
        to              <- map["to"]
    }

}
