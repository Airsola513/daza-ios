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

class OwnTopicsController: BaseListController<Topic> {
    
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
        self.title = Auth.id() == self.userId ? "我的主题" : "TA的主题"
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "TopicItemCell")
        self.tableView.registerNib(UINib(nibName: "TopicItemCell", bundle: nil), forCellReuseIdentifier: "TopicItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let completionBlock = { (pagination: Pagination!, data: [Topic]!, error: NSError!) -> Void in
            self.loadComplete(pagination, data, error: error)
        }
        Api.getTopicListByUserId(page, userId: userId, completion: completionBlock)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TopicItemCell = tableView.dequeueReusableCellWithIdentifier("TopicItemCell", forIndexPath: indexPath) as! TopicItemCell
        
        let data = self.itemsSource[indexPath.row]
        
        cell.data = data
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        let data = self.itemsSource[indexPath.row]
        
        let controller = TopicDetailController(data)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
