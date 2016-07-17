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
import Former

class LoginController: BaseGroupedListController {
    
    var menuClose: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_login")
        
        self.menuClose = UIBarButtonItem(image: UIImage(named: "ic_menu_close"), style: .Plain, target: self, action: #selector(clickMenuClose(_:)))
        self.navigationItem.leftBarButtonItem = self.menuClose
        
//        self.itemsSource = [
//            Section(title: nil, rows: [
//                DefaultRow(title: trans("register"), subtitle: nil, action: { _ in
//                    let controller = RegisterController()
//                    self.navigationController?.pushViewController(controller, animated: true)
//                }),
//            ])
//        ]
//        self.tableView.reloadData()
        
        let emailRow = TextFieldRowFormer<FormTextFieldCell>()
            .configure { (row) in
                row.text = ""
                row.placeholder = "Email"
        }
        
        let passwordRow = TextFieldRowFormer<FormTextFieldCell>()
            .configure { (row) in
                row.text = ""
                row.placeholder = "Password"
                row.cell.formTextField().secureTextEntry = true
        }
        
        let submitRow = LabelRowFormer<FormLabelCell>()
            .configure { (row) in
                row.text = "Submit"
            }.onSelected { (row) in
                let email: String = emailRow.text!
                let password: String = passwordRow.text!
                Api.login(email, password, success: { (data) in
                    print(data.id)
                })
        }
    
        let section = SectionFormer(rowFormer: emailRow, passwordRow)
        let submitSection = SectionFormer(rowFormer: submitRow)
        
        former.append(sectionFormer: section)
        former.append(sectionFormer: submitSection)
    }
    
    func clickMenuClose(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}