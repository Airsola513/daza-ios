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
import TUSafariActivity

class ArticleDetailController: InAppBrowserController {

    var articleId: Int!
    var article: Article!
    
    var articleCommentBarView: ArticleCommentBarView = ArticleCommentBarView.instanceFromNib()

    init(_ id: Int) {
        super.init(nibName: nil, bundle: nil)
        self.articleId = id
    }
    
    init(_ data: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = data
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("article_detail.title")
        
        self.articleCommentBarView.data = self.article
        self.articleCommentBarView.commentButton.addTarget(self, action: #selector(commentButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.articleCommentBarView.commentListButton.addTarget(self, action: #selector(commentListButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.articleCommentBarView.upvoteButton.addTarget(self, action: #selector(upvoteButtonButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.articleCommentBarView.shareButton.addTarget(self, action: #selector(shareButtonButtonPressed(_:)), forControlEvents: .TouchUpInside)

        self.view.addSubview(self.articleCommentBarView)
        self.articleCommentBarView.snp_makeConstraints { (make) in
            make.width.equalTo(self.view.snp_width)
            make.height.equalTo(44)
            make.bottom.equalTo(0)
        }
        
        self.webView.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(-44)
        }

        let urlRequest = NSURLRequest(URL: NSURL(string: "\(URLs.inappURL)/articles/\(self.article.id)")!)
        self.webView.loadRequest(urlRequest)
        
    }
    
    func commentButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = ArticleCommentCreateController(self.article)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func commentListButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = ArticleCommentsController(self.article)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func upvoteButtonButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
    }
    
    func shareButtonButtonPressed(sender: UIButton!) {
        let activities: [UIActivity] = [TUSafariActivity()];
        let activityViewController = UIActivityViewController(activityItems: self.article.sharingContent, applicationActivities: activities)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

}
