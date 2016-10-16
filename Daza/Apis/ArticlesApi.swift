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

    static func getArticleList(page: Int,
                               categroyId: Int!,
                               categroySlug: String!,
                               errorHandler: ErrorHandler! = DefaultErrorHandler(),
                               completion: (pagination: Pagination!, data: [Article]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/articles";
        var parameters: [String: AnyObject] = [
            "page": page,
        ]
        if (categroyId != nil) {
            parameters["categroy_id"] = categroyId
        }
        if (categroySlug != nil) {
            parameters["categroy_slug"] = categroySlug
        }
        
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<Article>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [Article]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    static func createArticle() {
        let URL = URLs.apiURL + "/articles";
        self.request(.POST, URL).responseObject { (response: Response<ResultOfObject<Article>, NSError>) in
            print(response.result)
        }
    }
    
    static func updateArticle(articleId: Int) {
        let URL = URLs.apiURL + "/articles";
        self.request(.PUT, URL).responseObject { (response: Response<ResultOfObject<Article>, NSError>) in
            print(response.result)
        }
    }

    static func deleteArticle(articleId: Int) {
        let URL = URLs.apiURL + "/articles";
        self.request(.DELETE, URL).responseObject { (response: Response<Result, NSError>) in
            print(response.result)
        }
    }
    
    static func getArticleListByCategoryId(page: Int,
                                        categoryId: Int,
                                        errorHandler: ErrorHandler! = DefaultErrorHandler(),
                                        completion: (pagination: Pagination!, data: [Article]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/categories/\(categoryId)/articles";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<Article>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [Article]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    static func getArticleListByTopicId(page: Int,
                                        topicId: Int,
                                        errorHandler: ErrorHandler! = DefaultErrorHandler(),
                                        completion: (pagination: Pagination!, data: [Article]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/topics/\(topicId)/articles";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<Article>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [Article]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
    
    static func getArticleCommentList(page: Int,
                                      articleId: Int,
                                      errorHandler: ErrorHandler! = DefaultErrorHandler(),
                                      completion: (pagination: Pagination!, data: [ArticleComment]!, error: NSError!) -> Void) {
        let URL = URLs.apiURL + "/articles/\(articleId)/comments";
        let parameters: [String: AnyObject] = [
            "page": page,
        ]
        self.request(.GET, URL, parameters).responseObject { (response: Response<ResultOfArray<ArticleComment>, NSError>) in
            handleResponse(response, errorHandler, completion: { (result, error) in
                var pagination: Pagination! = nil
                var data: [ArticleComment]! = nil
                if (error == nil) {
                    pagination = result.pagination
                    data = result.data
                }
                completion(pagination: pagination, data: data, error: error)
            })
        }
    }
}
