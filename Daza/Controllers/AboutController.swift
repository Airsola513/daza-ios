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

class AboutController: BaseGroupedListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("settings.about.title")
        
        form
            +++ Section()
            <<< ButtonRow() { row in
                    row.title = "开放源代码许可"
                    row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                }
            <<< ButtonRow() { row in
                    row.title = "服务条款"
                    row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                }
            <<< ButtonRow() { row in
                    row.title = "隐私权声明"
                    row.presentationMode = .Show(controllerProvider: .Callback( builder: { BaseTableViewController() }), completionCallback: nil)
                }

    }
    
}