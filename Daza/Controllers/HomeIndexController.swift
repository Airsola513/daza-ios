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

class HomeIndexController: BaseListController<Article> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_home_index")

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleItemCell", bundle: nil), forCellReuseIdentifier: "ArticleItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let loadDataSuccess = { (pagination: Pagination, data: [Article]) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getArticleList(page, success: loadDataSuccess)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ArticleItemCell = tableView.dequeueReusableCellWithIdentifier("ArticleItemCell", forIndexPath: indexPath) as! ArticleItemCell
        
        let data = self.itemsSource[indexPath.row]
        
        cell.titleLabel.text = data.title
        cell.timeLabel.text = "刚刚"
        cell.topicLabel.text = "TOPICTOPIC"
        cell.commentCountButton.setTitle("100个评论", forState: UIControlState.Normal)
        cell.viewCountButton.setTitle("100个阅读", forState: UIControlState.Normal)

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        let data = self.itemsSource[indexPath.row]
        
        let controller = ArticleDetailController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}