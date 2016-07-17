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
    
    static func register(username: String, _ email: String, _ password: String, success: (data: User) -> Void)  {
        let URL = URLs.apiURL + "/account/register";
        let parameters: [String: AnyObject] = [
            "username": username,
            "email": email,
            "password": password,
        ]
        self.request(.POST, URL, parameters).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            let value = response.result.value
            success(data: (value?.data)!)
        }
    }
    
    static func login(email: String, _ password: String, success: (data: User) -> Void) {
        let URL = URLs.apiURL + "/account/login";
        let parameters: [String: AnyObject] = [
            "email": email,
            "password": password,
        ]
        self.request(.POST, URL, parameters).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            let value = response.result.value
            success(data: (value?.data)!)
        }
    }
    
    static func logout(success: () -> Void) {
        let URL = URLs.apiURL + "/account/logout";
        self.request(.POST, URL).responseObject { (response: Response<Result, NSError>) in
            let value = response.result.value
            success()
        }
    }
    
    static func profile(success: (data: User) -> Void) {
        let URL = URLs.apiURL + "/account/profile";
        Alamofire.request(.GET, URL).responseObject { (response: Response<ResultOfObject<User>, NSError>) in
            let value = response.result.value
            success(data: (value?.data)!)
        }
    }

}
