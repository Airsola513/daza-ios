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
    
    static func getCategoryList(page: Int, success: (pagination: Pagination, data: [Category]) -> Void) {
        let URL = URLs.apiURL + "/categories";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<Category>, NSError>) in
            let value = response.result.value
            success(pagination: (value?.pagination)!, data: (value?.data)!)
        }
    }
    
    static func showCategory(categoryId: Int, success: (data: Category) -> Void) {
        let URL = URLs.apiURL + "/categories/\(categoryId)";
        self.request(.GET, URL).responseObject { (response: Response<ResultOfObject<Category>, NSError>) in
            let value = response.result.value
            success(data: (value?.data)!)
        }
    }
    
}
