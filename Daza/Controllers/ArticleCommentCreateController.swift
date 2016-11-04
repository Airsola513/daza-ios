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
import Eureka

class ArticleCommentCreateController: BaseGroupedListController {

    var article: Article!

    init(_ data: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = data
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var menuSend: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "写评论"
        
        self.menuSend = UIBarButtonItem(image: UIImage(named: "ic_menu_send"), style: .Plain, target: self, action: #selector(sendButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSend

        form
            +++ Section()
                <<< TextAreaRow() { row in
                        row.tag = "contentRow"
                        row.placeholder = "在此输入评论内容"
                    }.cellUpdate { (cell, row) in
                        
                    }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let contentRow: TextAreaRow = form.rowByTag("contentRow") as! TextAreaRow
        contentRow.cell.textView.becomeFirstResponder()
    }

    
    
    func sendButtonPressed(sender: UIBarButtonItem) {
        // TODO: 发表评论
    }

}
