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

class TopicDetailController: BaseListController<Article> {
    
    var topic: Topic?
    
    init(_ data: Topic) {
        super.init()
        self.topic = data
    }
    
    var menuShare: UIBarButtonItem?
    var stretchyHeader: TopicDetailHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_topic_detail")
        
        self.stretchyHeader = TopicDetailHeaderView.instanceFromNib()
        self.stretchyHeader?.minimumContentHeight = 64
        self.stretchyHeader!.data = self.topic!
        self.tableView!.insertSubview(self.stretchyHeader!, atIndex: 0)
//        self.tableView!.addSubview(self.stretchyHeader!)
        self.tableView!.mj_header.frame.size.height = 100
        
        self.menuShare = UIBarButtonItem(image: UIImage(named: "ic_menu_share"), style: .Plain, target: self, action: #selector(shareButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuShare
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleItemCell", bundle: nil), forCellReuseIdentifier: "ArticleItemCell")
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleNoImageItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleNoImageItemCell", bundle: nil), forCellReuseIdentifier: "ArticleNoImageItemCell")
        
        self.firstRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let navigationController = self.navigationController as! BaseNavigationController
        navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let navigationController = self.navigationController as! BaseNavigationController
        navigationController.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.shadowImage = nil
    }
    
    override func loadData(page: Int) {
        let loadDataSuccess = { (pagination: Pagination, data: [Article]) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getArticleListByTopicId(page, topicId: (topic?.id)!, success: loadDataSuccess)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.itemsSource[indexPath.row]
        
        var identifier: String = "ArticleItemCell"
        if (data.image_url == nil || data.image_url == "") {
            identifier = "ArticleNoImageItemCell";
        }
        
        let cell: ArticleItemCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! ArticleItemCell
        
        cell.data = data
        return cell
    }
    
    func shareButtonPressed(sender: UIBarButtonItem) {
        
    }
}
