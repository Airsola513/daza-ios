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

class ModifyPasswordController: BaseGroupedListController {

    var menuSave: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "修改账号密码"

        self.menuSave = UIBarButtonItem(image: UIImage(named: "ic_menu_save"), style: .Plain, target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSave

        form
            +++ Section()
                <<< PasswordRow() { row in
                        row.tag = "oldPasswordRow"
                        row.placeholder = "原密码"
                    }.cellUpdate { (cell, row) in
                    }
            +++ Section()
                <<< PasswordRow() { row in
                        row.tag = "newPasswordRow"
                        row.placeholder = "新密码"
                    }.cellUpdate { (cell, row) in
                    }
                <<< PasswordRow() { row in
                        row.tag = "newPasswordConfirmationRow"
                        row.placeholder = "确认密码"
                    }.cellUpdate { (cell, row) in
                    }
    }

    func saveButtonPressed(sender: UIBarButtonItem) {
        let values = form.values()
        let oldPassword = values["oldPasswordRow"] as? String
        let newPassword = values["newPasswordRow"] as? String
        let newPasswordConfirmation = values["newPasswordConfirmationRow"] as? String
        
        if oldPassword == nil {
            SVProgressHUD.showErrorWithStatus("请输入原密码")
            return
        }
        
        if newPassword == nil {
            SVProgressHUD.showErrorWithStatus("请输入新密码")
            return
        }
        
        if newPasswordConfirmation == nil {
            SVProgressHUD.showErrorWithStatus("请输入确认密码")
            return
        }
        
        if newPassword != newPasswordConfirmation {
            SVProgressHUD.showErrorWithStatus("两次输入的密码不一致")
            return
        }

        let completionBlock = { (data: Bool!, error: NSError!) in
            SVProgressHUD.dismiss()
            if (error != nil) {
                return
            }
            self.navigationController?.popViewControllerAnimated(true)
        }

        SVProgressHUD.showWithStatus("修改中...")
        Api.updatePassword(oldPassword, newPassword, completion: completionBlock)
    }

}
