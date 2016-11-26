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

    static func getTopicList(page: Int,
                             errorHandler: ErrorHandler! = DefaultErrorHandler(),
                             completion: (pagination: Pagination!, data: [Topic]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/topics";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<Topic>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [Topic]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    static func showTopic(topicId: Int,
                          errorHandler: ErrorHandler! = DefaultErrorHandler(),
                          completion: (data: Topic!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/topics/\(topicId)";
        self.request(.GET, URL).responseObject { (response: Response<ResultOfObject<Topic>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var data: Topic! = nil
                if (error == nil) {
                    data = result.data
                }
                completion(data: data, error: error)
            })
        }
        
    }
    
    static func topicSubscribe(topicId: Int,
                               errorHandler: ErrorHandler! = DefaultErrorHandler(),
                               completion: (data: Bool!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/topics/\(topicId)/subscribe";
        
        self.request(.POST, URL).responseObject { (response: Response<Result, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var successed: Bool = false
                if (error == nil) {
                    successed = true
                }
                completion(data: successed, error: error)
            })
        }
    }
    
    
}
