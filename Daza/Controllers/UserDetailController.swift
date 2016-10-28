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

class UserDetailController: BaseGroupedListController {
    
    var userId: Int!
    var user: User!
    
    init(_ id: Int) {
        super.init(nibName: nil, bundle: nil)
        self.userId = id
    }

    init(_ data: User!) {
        super.init(nibName: nil, bundle: nil)
        self.user = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("user_detail.title")
        
        form
            +++ Section()
                <<< LabelRow() { row in
                        row.tag = "profileRow"
                        row.cellStyle = UITableViewCellStyle.Subtitle
                        self.updateProfileRow(row)
                    }.cellUpdate { (cell, row) in
                        cell.height = { 70 }
                        if (self.user != nil) {
                            cell.detailTextLabel!.text = self.user.bio
                        }
                    }
            +++ Section()
                <<< ButtonRow() { row in
                        row.title = "他/她的主题"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { OwnTopicsController(self.userId) }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.title = "他/她订阅的"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { OwnSubscribesController(self.userId) }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.title = "他/她赞过的"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { OwnUpvoteArticlesController(self.userId) }), completionCallback: nil)
                    }
        
        Api.showUser(self.userId) { (data) in
            self.user = data
            self.updateProfileRow(self.form.rowByTag("profileRow"))
        }
    }
    
    func updateProfileRow(row: LabelRow?) {
        if (user == nil) {
            row?.title = "N/A"
            row?.cell.imageView!.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "placeholder_image"))
            return
        }

        row?.title = user.name
        row?.cell.imageView!.sd_setImageWithURL(NSURL(string: user.avatar_small_url), placeholderImage: UIImage(named: "placeholder_image"))
        row?.updateCell()
    }
    
}
