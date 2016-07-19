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

class SettingsController: BaseGroupedListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_settings")

        form +++ Section()
            <<< ButtonRow(){ row in
                row.title = "推送消息设置"
                row.presentationMode = .Show(controllerProvider: ControllerProvider.Callback(builder: { () -> UIViewController in
                    return BaseTableViewController()
                }), completionCallback: { (controller) in
                    
                })
            }
            +++ Section()
            <<< ButtonRow(){ row in
                row.title = "账号和密码"
                row.presentationMode = .Show(controllerProvider: ControllerProvider.Callback(builder: { () -> UIViewController in
                    return BaseTableViewController()
                }), completionCallback: { (controller) in
                    
                })
            }
            +++ Section()
            <<< ButtonRow() { row in
                row.title = "意见反馈"
                row.presentationMode = .Show(controllerProvider: ControllerProvider.Callback(builder: { () -> UIViewController in
                    return BaseTableViewController()
                }), completionCallback: { (controller) in
                    
                })
            }
            <<< ButtonRow() { row in
                row.title = "关于"
                row.presentationMode = .Show(controllerProvider: ControllerProvider.Callback(builder: { () -> UIViewController in
                    return AboutController()
                }), completionCallback: { (controller) in
                    
                })
            }
            +++ Section()
            <<< ButtonRow() { row in
                row.title = "退出"
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.textColor = UIColor.redColor()
                }
        )
    
    }

}