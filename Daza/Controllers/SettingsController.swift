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
import MessageUI

class SettingsController: BaseGroupedListController, MFMailComposeViewControllerDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("settings.title")
        
        form
            +++ Section()
                <<< ButtonRow() { row in
                        row.tag = "notificationRow"
                        row.title = trans("settings.notifications.title")
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { NotificationSettingsController() }), completionCallback: nil)
                        row.disabled = Auth.check() ? false : true
                    }
            +++ Section()
                <<< ButtonRow() { row in
                        row.tag = "accountRow"
                        row.title = trans("settings.account.title")
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { AccountController() }), completionCallback: nil)
                        row.disabled = Auth.check() ? false : true
                    }
            +++ Section()
                <<< ButtonRow() { row in
                        let mailComposeController = MFMailComposeViewController()
                        mailComposeController.mailComposeDelegate = self
                        mailComposeController.setToRecipients([BuildConfig.EMAIL_HI])
                        mailComposeController.setSubject("意见反馈")
                        mailComposeController.setMessageBody("", isHTML: true)
                        row.title = trans("settings.feedback.title")
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { mailComposeController }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.title = trans("settings.about.title")
                        row.cellStyle = .Value1
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { AboutController() }), completionCallback: nil)
                    }.cellUpdate { (cell, row) in
                        cell.detailTextLabel?.text = UIApplication.appVersion()
                    }
            +++ Section()
                <<< ButtonRow() { row in
                        row.title = trans("settings.logout.title")
                        row.hidden = Auth.check() ? false : true
                    }.cellUpdate { (cell, row) in
                        cell.textLabel?.textColor = UIColor.redColor()
                    }.onCellSelection { (cell, row) in
                        let completionBlock = { (error: NSError!) in
                            if (error != nil) {
                                return
                            }
                            row.hidden = true
                            row.evaluateHidden()
                            self.form.rowByTag("notificationRow")!.disabled = true
                            self.form.rowByTag("notificationRow")!.evaluateDisabled()
                            self.form.rowByTag("accountRow")!.disabled = true
                            self.form.rowByTag("accountRow")!.evaluateDisabled()
                        }
                        Api.logout(completion: completionBlock)
                    }
        
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
