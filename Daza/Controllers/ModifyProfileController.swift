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

class ModifyProfileController: BaseGroupedListController {

    var menuSave: UIBarButtonItem!

    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("modify_profile.title")


        self.menuSave = UIBarButtonItem(image: UIImage(named: "ic_menu_save"), style: .Plain, target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSave

        form
//            +++ Section()
//                <<< ImageRow() { row in
//                        row.tag = "avatarRow"
//                        row.title = trans("modify_profile.avatar.title")
//                    }.cellUpdate { (cell, row) in
//                        cell.height =  { 60 }
//                        if (self.user != nil) {
//                          cell.imageView!.sd_setImageWithURL(NSURL(string: self.user.avatar_small_url), placeholderImage: UIImage(named: "placeholder_image"))
//                        }
//                    }
            +++ Section()
                <<< TextRow() { row in
                        row.tag = "nameRow"
                        row.title = trans("modify_profile.name.title")
                        row.placeholder = trans("modify_profile.name.placeholder")
//                        row.textFieldPercentage = 0.7
                    }.cellUpdate { (cell, row) in
//                        cell.textField.textAlignment = .Left
                    }
//                <<< AlertRow<String>() { row in
//                        row.title = "性别"
//                        row.options = ["男生", "女生", "保密"]
//                        row.value = "保密"
//                    }
//                <<< DateRow() { row in
//                        row.title = "生日"
//                        row.value = NSDate()
//                    }
//            +++ Section()
//                <<< TextRow() { row in
//                        row.title = "国家"
//                        row.placeholder = "添加你的国家"
//                        row.textFieldPercentage = 0.7
//                    }.cellUpdate { (cell, row) in
//                        cell.textField.textAlignment = .Left
//                    }
                <<< TextRow() { row in
                        row.tag = "cityRow"
                        row.title = trans("modify_profile.city.title")
                        row.placeholder = trans("modify_profile.city.placeholder")
//                        row.textFieldPercentage = 0.7
                    }.cellUpdate { (cell, row) in
//                        cell.textField.textAlignment = .Left
                    }
                <<< TextRow() { row in
                        row.tag = "websiteRow"
                        row.title = trans("modify_profile.website.title")
                        row.placeholder = trans("modify_profile.website.placeholder")
//                        row.textFieldPercentage = 0.7
                    }.cellUpdate { (cell, row) in
//                        cell.textField.textAlignment = .Left
                    }
                <<< TextAreaRow() { row in
                        row.tag = "bioRow"
                        row.placeholder = trans("modify_profile.bio.placeholder")
                    }

        self.user = Auth.user()

        self.form.setValues([
            "nameRow": self.user.name,
            "cityRow": self.user.city,
            "websiteRow": self.user.website,
            "bioRow": self.user.bio,
        ])

        let completionBlock = { (data: User!, error: NSError!) in
            if (error == nil) {
                self.form.setValues([
//                    "avatarRow": NSURL(string: data.avatar_url),
                    "nameRow": data.name,
                    "cityRow": data.city,
                    "websiteRow": data.website,
                    "bioRow": data.bio,
                ])
            }
            self.tableView?.reloadData()
        }

        Api.profile(completion: completionBlock)
    }

    func saveButtonPressed(sender: UIBarButtonItem) {
        let values = form.values()
//        let avatarUrl = values["avatarRow"] as? String
        let avatarUrl = ""
        let name = values["nameRow"] as? String
        let city = values["cityRow"] as? String
        let website = values["websiteRow"] as? String
        let bio = values["bioRow"] as? String

        let completionBlock = { (data: User!, error: NSError!) in
            SVProgressHUD.dismiss()
            if (error != nil) {
                return
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        SVProgressHUD.showWithStatus("修改中...")
        Api.updateProfile(name, city, website, bio, completion: completionBlock)
    }

}
