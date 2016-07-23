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

class Result: Mappable {
    
    var status: String!
    var pagination: Pagination!
    
    required init?(_ map: Map) {
    }
    
    func mapping(map: Map) {
        status      <- map["status"]
        pagination  <- map["pagination"]
    }
    
    func isSuccess() -> Bool {
        return (status == "success")
    }
    
    func isFailure() -> Bool {
        return !isSuccess()
    }
    
}
