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

class ArticleCommentsController: BaseListController<ArticleComment> {
    
    var articleId: Int!
    var article: Article! = Article()
    
    init(_ id: Int) {
        super.init()
        self.articleId = id
    }

    init(_ data: Article) {
        super.init()
        self.articleId = data.id
        self.article = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("article_comments.title")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(ArticleCommentItemCell.self, forCellReuseIdentifier: "ArticleCommentItemCell")
        self.tableView.registerNib(UINib(nibName: "ArticleCommentItemCell", bundle: nil), forCellReuseIdentifier: "ArticleCommentItemCell")
        
        self.firstRefreshing()
    }
    
    
    override func loadData(page: Int) {
        let completionBlock = { (pagination: Pagination!, data: [ArticleComment]!, error: NSError!) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getArticleCommentList(page, articleId: self.articleId, completion: completionBlock)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let data = self.itemsSource[indexPath.row]
        
        var identifier: String = "ArticleCommentItemCell"
        
        let cell: ArticleCommentItemCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! ArticleCommentItemCell
        
        cell.data = data
        return cell
    }

}
