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
import SVProgressHUD

class NotificationSettingsController: BaseGroupedListController {
    
    var menuSave: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("settings.notifications.title")
        
        self.menuSave = UIBarButtonItem(image: UIImage(named: "ic_menu_save"), style: .Plain, target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSave

        
        print(Auth.userConfigs())
        
        print(NSUserDefaults.standardUserDefaults().stringForKey("auth.user_configs"))
        
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
//            +++ Section(footer: "开启后22:00到8:00间不会收到推送消息。")
//                <<< SwitchRow() { row in
//                        row.title = "勿扰模式"
//                        row.disabled = true
//                    }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didBecomeActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for row in form.allRows {
            row.updateCell()
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func didBecomeActive(notification: NSNotification) {
        form.rowByTag("statusRow")?.updateCell()
    }
    
    func closedByKey(key: String) -> Bool {
        if (Auth.check()) {
            let configs = Auth.userConfigs()
            if (configs == nil) {
                return false
            }
            for config: UserConfig in configs {
                if (config.key == key) {
                    return config.value == "true"
                }
            }
        }
        return false
    }
    
    
    
    func saveButtonPressed(sender: UIBarButtonItem) {
        let values = form.values()
        
        let notification_followed: Bool! = values["notification_followed"] as? Bool
        let notification_subscribed: Bool! = values["notification_subscribed"] as? Bool
        let notification_upvoted: Bool! = values["notification_upvoted"] as? Bool
        let notification_comment: Bool! = values["notification_comment"] as? Bool
        let notification_mention: Bool! = values["notification_mention"] as? Bool
        
        
        let completionBlock = { (data: [UserConfig]!, error: NSError!) in
            SVProgressHUD.dismiss()
            if (error != nil) {
                return
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        SVProgressHUD.showWithStatus("修改中...")
        Api.updateConfigs(notification_followed,
                          notification_subscribed,
                          notification_upvoted,
                          notification_comment,
                          notification_mention,
                          completion: completionBlock)
    }

}
