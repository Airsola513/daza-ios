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

class NotificationSettingsController: BaseGroupedListController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ Section(footer: "请在 iPhone 的 \"设置\" - \"通知\" 中进行设置。")
                <<< LabelRow() { row in
                        row.title = "接收推送通知"
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = "未开启"
                    }
            +++ Section("通知项目")
                <<< SwitchRow() { row in
                        row.title = "主题"
                    }
                <<< SwitchRow() { row in
                        row.title = "文章"
                    }
                <<< SwitchRow() { row in
                        row.title = "系统消息"
                    }
    }

}
