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
        self.title = trans("settings.account.title")
        
        form
            +++ Section()
                <<< ButtonRow() { row in
                        row.title = trans("settings.account.modify_email.title")
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< ButtonRow() { row in
                        row.title = trans("settings.account.modify_mobile.title")
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< ButtonRow() { row in
                        row.title = trans("settings.account.modify_password.title")
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
            +++ Section()
                <<< SwitchRow() { row in
                        row.title = trans("settings.account.bind_wechat.title")
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< SwitchRow() { row in
                        row.title = trans("settings.account.bind_weibo.title")
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
                <<< SwitchRow() { row in
                        row.title = trans("settings.account.bind_github.title")
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未设置"
                    }
    }
    
}