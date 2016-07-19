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
import SnapKit
import Eureka
import OnePasswordExtension

class LoginController: BaseGroupedListController {
    
    var menuClose: UIBarButtonItem?
    var onepasswordButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_login")
        
        self.menuClose = UIBarButtonItem(image: UIImage(named: "ic_menu_close"), style: .Plain, target: self, action: #selector(clickMenuClose(_:)))
        self.navigationItem.leftBarButtonItem = self.menuClose
        
        self.tableView!.backgroundColor = UIColor.whiteColor()
        self.tableView!.separatorStyle = .None
        self.tableView!.scrollEnabled = false
        
        self.onepasswordButton.setBackgroundImage(UIImage(named: "ic_onepassword"), forState: UIControlState.Normal)
        
        let dividerWidth: CGFloat = (self.tableView?.frame.width)! - 32

        form +++ Section()
            <<< LabelRow() { row in
                row.title = "欢迎回来"
                row.cellStyle = .Subtitle
                }.cellUpdate({ (cell, row) in
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
                    cell.detailTextLabel?.textColor = UIColor.grayColor()
                    cell.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                    cell.detailTextLabel?.text = "用邮箱登录，看看之前都错过了什么好文章吧。"
                    
                    cell.textLabel?.snp_makeConstraints{ (make) -> Void in
                        make.centerX.equalTo(cell.contentView)
                        make.top.equalTo(16)
                    }
                    cell.detailTextLabel?.snp_makeConstraints{ (make) -> Void in
                        make.top.equalTo((cell.textLabel?.snp_bottom)!).inset(-5)
                        make.centerX.equalTo(cell.contentView)
                    }
                    cell.height =  { 72 }

                    let divider: UIView = UIView()
                    divider.backgroundColor = UIColor(rgba: "#e6e7e8")
                    cell.contentView.addSubview(divider)
                    divider.snp_makeConstraints { (make) -> Void in
                        make.width.equalTo(dividerWidth)
                        make.bottom.equalTo(0)
                        make.height.equalTo(1)
                        make.centerX.equalTo(cell)
                    }
                })
            <<< EmailRow() { row in
                row.placeholder = "电子邮箱"
                }.onChange { (row) in
                    self.onepasswordButton.hidden = row.value != nil || row.value == ""
                }.cellUpdate({ (cell, row) in
                    let divider: UIView = UIView()
                    divider.backgroundColor = UIColor(rgba: "#e6e7e8")
                    cell.contentView.addSubview(divider)
                    divider.snp_makeConstraints { (make) -> Void in
                        make.width.equalTo(dividerWidth)
                        make.bottom.equalTo(0)
                        make.height.equalTo(1)
                        make.centerX.equalTo(cell)
                    }
                    // 添加onepassword按钮
                    if (OnePasswordExtension.sharedExtension().isAppExtensionAvailable()) {
//                        self.btnOnepassword.addTarget(self, action: Selector("onepassword:"), forControlEvents: .TouchUpInside)
                        cell.contentView.addSubview(self.onepasswordButton)
                        self.onepasswordButton.snp_makeConstraints { (make) -> Void in
                            make.height.equalTo(22)
                            make.width.equalTo(22)
                            make.right.equalTo(cell.textField).inset(4)
                            make.centerY.equalTo(cell.textField)
                        }
                    }
                })
            <<< PasswordRow() { row in
                row.placeholder = "密码"
                }.cellUpdate({ (cell, row) in
                    let divider: UIView = UIView()
                    divider.backgroundColor = UIColor(rgba: "#e6e7e8")
                    cell.contentView.addSubview(divider)
                    divider.snp_makeConstraints { (make) -> Void in
                        make.width.equalTo(dividerWidth)
                        make.bottom.equalTo(0)
                        make.height.equalTo(1)
                        make.centerX.equalTo(cell)
                    }
                })
            +++ Section()
            <<< ButtonRow() { row in
                row.title = "登录"
        }
    }
    
    func clickMenuClose(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}