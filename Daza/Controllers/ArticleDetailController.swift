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

class ArticleDetailController: BrowserController {

    var article: Article!

    init(_ data: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = data
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var menuShare: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("article_detail.title")

        self.menuShare = UIBarButtonItem(image: UIImage(named: "ic_menu_share"), style: .Plain, target: self, action: #selector(shareButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuShare

        let urlRequest = NSURLRequest(URL: NSURL(string: "\(URLs.inappURL)/articles/\(self.article.id)")!)
        self.webView.loadRequest(urlRequest)
    }

    func shareButtonPressed(sender: UIBarButtonItem) {

    }

}
