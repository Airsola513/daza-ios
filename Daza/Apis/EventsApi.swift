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

import Alamofire
import AlamofireObjectMapper

extension Api {
    
    static func getEventList(page: Int, success: (pagination: Pagination, data: [Event]) -> Void) {
        let URL = URLs.apiURL + "/events";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        Alamofire.request(.GET, URL, parameters: parameters).responseObject { (response: Response<ResultOfArray<Event>, NSError>) in
            let value = response.result.value
            success(pagination: (value?.pagination)!, data: (value?.data)!)
        }
    }
    
    static func showEvent(eventId: Int) {
        
    }
    
    static func createEvent() {
        
    }
    
    static func updateEvent() {
        
    }
    
    static func deleteEvent(eventId: Int) {
        
    }
    

}
