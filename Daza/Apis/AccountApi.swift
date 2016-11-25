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

    static func register(username: String!,
                       _ email: String!,
                       _ password: String!,
                         errorHandler: ErrorHandler! = DefaultErrorHandler(),
                         completion: (data: User!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/account/register";
        let parameters: [String: AnyObject] = [
            "username": username,
            "email": email,
            "password": password,
        ]
        self.request(.POST, URL, parameters).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var data: User! = nil
                if (error == nil) {
                    data = result.data
                    // 保存用户相关数据
                    Auth.jwtToken(data.jwt_token)
                    Auth.user(data)
                    Auth.userConfigs(data.configs)
                }
                completion(data: data, error: error)
            })
        }
    }

    static func login(email: String!,
                    _ password: String!,
                      errorHandler: ErrorHandler! = DefaultErrorHandler(),
                      completion: (data: User!, error: NSError!) -> Void) {

        let URL = URLs.apiURL + "/account/login";
        let parameters: [String: AnyObject] = [
            "email": email,
            "password": password,
        ]
        self.request(.POST, URL, parameters).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var data: User! = nil
                if (error == nil) {
                    data = result.data
                    // 保存用户相关数据
                    Auth.jwtToken(data.jwt_token)
                    Auth.user(data)
                    Auth.userConfigs(data.configs)
                }
                completion(data: data, error: error)
            })
        }
    }

    static func logout(errorHandler: ErrorHandler! = DefaultErrorHandler(),
                       completion: (error: NSError!) -> Void) {
        // 移除用户相关数据
        Auth.jwtToken(nil)
        Auth.user(nil)
        Auth.userConfigs(nil)
        let URL = URLs.apiURL + "/account/logout";
        self.request(.POST, URL).responseObject { (response: Response<Result, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                completion(error: error)
            })
        }
    }

    static func profile(errorHandler: ErrorHandler! = DefaultErrorHandler(),
                        completion: (data: User!, error: NSError!) -> Void) {

        let URL = URLs.apiURL + "/account/profile";
        self.request(.GET, URL).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var data: User! = nil
                if (error == nil) {
                    data = result.data
                    // 保存用户相关数据
                    Auth.user(data)
                }
                completion(data: data, error: error)
            })
        }
    }

    static func updateProfile(name: String!,
                            _ city: String!,
                            _ website: String!,
                            _ bio: String!,
                              errorHandler: ErrorHandler! = DefaultErrorHandler(),
                              completion: (data: User!, error: NSError!) -> Void) {

        let URL = URLs.apiURL + "/account/profile";
        let parameters: [String: AnyObject] = [
            "name": name,
            "city": city,
            "website": website,
            "bio": bio,
        ]

        self.request(.PUT, URL, parameters).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var data: User! = nil
                if (error == nil) {
                    data = result.data
                    // 保存用户相关数据
                    Auth.user(data)
                }
                completion(data: data, error: error)
            })
        }
    }

    static func updatePassword(oldPassword: String!,
                             _ newPassword: String!,
                               errorHandler: ErrorHandler! = DefaultErrorHandler(),
                               completion: (data: Bool, error: NSError!) -> Void) {

        let URL = URLs.apiURL + "/account/password_modify";
        let parameters: [String: AnyObject] = [
            "old_password": oldPassword,
            "new_password": newPassword,
        ]

        self.request(.POST, URL, parameters).responseObject { (response: Response<Result, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var successed: Bool = false
                if (error == nil) {
                    successed = true
                }
                completion(data: successed, error: error)
            })
        }
    }
    
    static func updateConfigs(notification_followed: Bool,
                            _ notification_subscribed: Bool,
                            _ notification_upvoted: Bool,
                            _ notification_comment: Bool,
                            _ notification_mention: Bool,
                              errorHandler: ErrorHandler! = DefaultErrorHandler(),
                              completion: (data: [UserConfig]!, error: NSError!) -> Void) {
        
        let URL = URLs.apiURL + "/account/configs";
        let parameters: [String: AnyObject] = [
            "notification_followed": (notification_followed ? "true" : "false"),
            "notification_subscribed": (notification_subscribed ? "true" : "false"),
            "notification_upvoted": (notification_upvoted ? "true" : "false"),
            "notification_comment": (notification_comment ? "true" : "false"),
            "notification_mention": (notification_mention ? "true" : "false"),
        ]
        
        self.request(.PUT, URL, parameters).responseObject { (response: Response<ResultOfArray<UserConfig>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var data: [UserConfig]! = nil
                if (error == nil) {
                    data = result.data
                    // 保存用户相关数据
                    Auth.userConfigs(data)
                }
                completion(data: data, error: error)
            })
        }
    }

}
