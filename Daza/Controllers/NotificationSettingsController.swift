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
                        row.tag = "statusRow"
                        row.title = trans("settings.notifications.push_notification.title")
                    }.cellUpdate { (cell, row) in
                        let isRegisteredForLocalNotifications = UIApplication.sharedApplication().currentUserNotificationSettings()?.types.contains(UIUserNotificationType.Alert) ?? false
                        cell.detailTextLabel?.text = isRegisteredForLocalNotifications ? "已开启" : "未开启"
                    }.onCellSelection { (cell, row) in
                        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                    }
            +++ Section(trans("settings.notifications.itmes.header"))
                <<< SwitchRow() { row in
                        row.tag = "notification_followed"
                        row.title = trans("settings.notifications.itmes.followed")
                    }.cellUpdate { (cell, row) in
                        row.value = self.closedByKey("notification_followed")
                    }
                <<< SwitchRow() { row in
                        row.tag = "notification_subscribed"
                        row.title = trans("settings.notifications.itmes.subscribed")
                    }.cellUpdate { (cell, row) in
                        row.value = self.closedByKey("notification_subscribed")
                    }
                <<< SwitchRow() { row in
                        row.tag = "notification_upvoted"
                        row.title = trans("settings.notifications.itmes.upvoted")
                    }.cellUpdate { (cell, row) in
                        row.value = self.closedByKey("notification_upvoted")
                    }
                <<< SwitchRow() { row in
                        row.tag = "notification_comment"
                        row.title = trans("settings.notifications.itmes.comment")
                    }.cellUpdate { (cell, row) in
                        row.value = self.closedByKey("notification_comment")
                    }
                <<< SwitchRow() { row in
                        row.tag = "notification_mention"
                        row.title = trans("settings.notifications.itmes.mention")
                    }.cellUpdate { (cell, row) in
                        row.value = self.closedByKey("notification_mention")
                    }
            +++ Section(footer: "开启后22:00到8:00间不会收到推送消息。")
                <<< SwitchRow() { row in
                        row.title = "勿扰模式"
                        row.disabled = true
                    }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        let statusRow: LabelRow = form.rowByTag("statusRow") as! LabelRow
//        statusRow.cell.detailTextLabel?.text = UIApplication.sharedApplication().currentUserNotificationSettings()?.types != .None ? "已开启" : "未开启"
//        statusRow.updateCell()
        
        print("test")
        for row in form.allRows {
            row.updateCell()
        }
    }
    
    func closedByKey(key: String) -> Bool {
        if (Auth.check()) {
            for config: UserConfig in Auth.user().configs {
                print("\(config.key): \(config.value)")
                if (config.key == key) {
                    return config.value == "true"
                }
            }
        }
        return false
    }

}
