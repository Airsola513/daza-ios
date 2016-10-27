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
    
    static func showUser(userId: Int, success: (data: User) -> Void) {
        let URL = URLs.apiURL + "/users/\(userId)";
        self.request(.GET, URL).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            let value = response.result.value
            success(data: (value?.data)!)
        }
    }
    
    static func followers(page: Int,
                          userId: Int!,
                          errorHandler: ErrorHandler! = DefaultErrorHandler(),
                          completion: (pagination: Pagination!, data: [UserRelationship]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/users/\(userId)/followers";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<UserRelationship>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [UserRelationship]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    static func following(page: Int,
                          userId: Int!,
                          errorHandler: ErrorHandler! = DefaultErrorHandler(),
                          completion: (pagination: Pagination!, data: [UserRelationship]!, error: NSError!) -> Void) {

        let URL = URLs.apiURL + "/users/\(userId)/following";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<UserRelationship>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [UserRelationship]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    static func getTopicListByUserId(page: Int,
                                     userId: Int,
                                     errorHandler: ErrorHandler! = DefaultErrorHandler(),
                                     completion: (pagination: Pagination!, data: [Topic]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/users/\(userId)/topics";
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
    
    
    static func getSubscribedTopicListByUserId(page: Int,
                                     userId: Int,
                                     errorHandler: ErrorHandler! = DefaultErrorHandler(),
                                     completion: (pagination: Pagination!, data: [TopicSubscriber]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/users/\(userId)/subscribes";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<TopicSubscriber>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [TopicSubscriber]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    

}
