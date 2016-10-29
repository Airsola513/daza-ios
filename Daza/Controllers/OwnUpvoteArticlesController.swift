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

import UIKit

class OwnUpvoteArticlesController: BaseListController<ArticleVote> {
    
    var userId: Int!
    var user: User!
    
    init(_ id: Int) {
        super.init()
        self.userId = id
        self.hidesBottomBarWhenPushed = true
    }
    
    init(_ data: User!) {
        super.init()
        self.user = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Auth.id() == self.userId ? "我赞过的" : "他/她赞过的"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleItemCell", bundle: nil), forCellReuseIdentifier: "ArticleItemCell")
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleNoImageItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleNoImageItemCell", bundle: nil), forCellReuseIdentifier: "ArticleNoImageItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let completionBlock = { (pagination: Pagination!, data: [ArticleVote]!, error: NSError!) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getUpvoteArticleListByUserId(page, userId: self.userId, completion: completionBlock)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.itemsSource[indexPath.row].article
        
        var identifier: String = "ArticleItemCell"
        if (data.image_url == nil || data.image_url == "") {
            identifier = "ArticleNoImageItemCell";
        } else {
            //            if (indexPath.row < 10) {
            //                identifier = "ArticleBigImageItemCell";
            //            }
        }
        
        let cell: ArticleItemCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! ArticleItemCell
        
        cell.data = data
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        let data = self.itemsSource[indexPath.row].article
        
        let controller = ArticleDetailController(data)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
