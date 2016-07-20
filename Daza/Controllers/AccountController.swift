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

class AccountController: BaseGroupedListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_account")
        
        form
            +++ Section()
                <<< ButtonRow() { row in
                        row.title = "邮箱"
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< ButtonRow() { row in
                        row.title = "手机号"
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< ButtonRow() { row in
                        row.title = "修改账号密码"
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
            +++ Section()
                <<< SwitchRow() { row in
                        row.title = "微信账号"
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< SwitchRow() { row in
                        row.title = "微博账号"
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< SwitchRow() { row in
                        row.title = "GitHub 账号"
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
    }
    
}