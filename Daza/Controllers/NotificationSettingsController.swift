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
        self.title = trans("settings.notifications.title")

        form
            +++ Section(footer: trans("settings.notifications.push_notification.footer"))
                <<< LabelRow() { row in
                        row.title = trans("settings.notifications.push_notification.title")
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = UIApplication.sharedApplication().isRegisteredForRemoteNotifications() ? "已开启" : "未开启"
                    }.onCellSelection { (cell, row) in
                        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    }
            +++ Section(trans("settings.notifications.itmes.header"))
                <<< SwitchRow() { row in
                        row.title = trans("settings.notifications.itmes.followed")
                    }
                <<< SwitchRow() { row in
                        row.title = trans("settings.notifications.itmes.subscribed")
                    }
                <<< SwitchRow() { row in
                        row.title = trans("settings.notifications.itmes.upvoted")
                    }
                <<< SwitchRow() { row in
                        row.title = trans("settings.notifications.itmes.comment")
                    }
                <<< SwitchRow() { row in
                        row.title = trans("settings.notifications.itmes.mention")
            }
            +++ Section(footer: "开启后22:00到8:00间不会收到推送消息。")
                <<< SwitchRow() { row in
                        row.title = "勿扰模式"
                        row.disabled = true
                    }
    }

}
