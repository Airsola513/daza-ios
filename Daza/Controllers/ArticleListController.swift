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
import XLPagerTabStrip

class ArticleListController: BaseListController<Article>, IndicatorInfoProvider {
    
    var category: Category?
    
//    init(category: Category) {
//        super.init()
//        self.category = category;
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_home_index")

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleItemCell", bundle: nil), forCellReuseIdentifier: "ArticleItemCell")
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleNoImageItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleNoImageItemCell", bundle: nil), forCellReuseIdentifier: "ArticleNoImageItemCell")
        
        self.tableView.registerClass(TopicItemCell.self, forCellReuseIdentifier: "ArticleBigImageItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleBigImageItemCell", bundle: nil), forCellReuseIdentifier: "ArticleBigImageItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let loadDataSuccess = { (pagination: Pagination, data: [Article]) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getArticleList(page, success: loadDataSuccess)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.itemsSource[indexPath.row]
        
        var identifier: String = "ArticleItemCell"
        if (data.image_url == nil || data.image_url == "") {
            identifier = "ArticleNoImageItemCell";
        } else {
            if (indexPath.row < 100) {
                identifier = "ArticleBigImageItemCell";
            }
        }

        let cell: ArticleItemCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! ArticleItemCell
        
        cell.data = data
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        let data = self.itemsSource[indexPath.row]
        
        let controller = ArticleDetailController(data)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func indicatorInfoForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if (self.category != nil) {
            let categoryName: String = (self.category!.name)!
            return IndicatorInfo(title: categoryName)
        }
        return "N/A"
    }
    
}