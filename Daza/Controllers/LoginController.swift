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
import SVProgressHUD

class LoginController: BaseGroupedListController {

    var menuClose: UIBarButtonItem?

    let onepasswordButton: UIButton = UIButton()
    let forgotPasswordButton: UIButton = UIButton()
    let submitButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("login.title")

        self.menuClose = UIBarButtonItem(image: UIImage(named: "ic_menu_close"), style: .Plain, target: self, action: #selector(clickMenuClose(_:)))
        self.navigationItem.leftBarButtonItem = self.menuClose

        self.tableView!.backgroundColor = UIColor.whiteColor()
        self.tableView!.separatorStyle = .None
        self.tableView!.scrollEnabled = false

        self.onepasswordButton.setImage(UIImage(named: "ic_onepassword"), forState: UIControlState.Normal)
        
        self.submitButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.submitButton.layer.masksToBounds = true
        self.submitButton.layer.cornerRadius = 5.0
        self.submitButton.layer.borderWidth = 1.4
        self.submitButton.layer.backgroundColor = UIColor(rgba: "#546E7A").CGColor
        self.submitButton.layer.borderColor = UIColor(rgba: "#455A64").CGColor
        self.submitButton.setTitle(trans("login.submit.title"), forState: UIControlState.Normal)
        
        self.forgotPasswordButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.forgotPasswordButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        self.forgotPasswordButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Selected)
        self.forgotPasswordButton.setTitle(trans("login.forgot_password.title"), forState: UIControlState.Normal)
        
        self.onepasswordButton.addTarget(self, action: #selector(onepasswordButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.submitButton.addTarget(self, action: #selector(submitButtonPressed(_:)), forControlEvents: .TouchUpInside)

        let dividerWidth: CGFloat = (self.tableView?.frame.width)! - 32

        form
            +++ Section()
                <<< LabelRow() { row in
                        row.title = trans("login.welcome_back.title")
                        row.cellStyle = .Subtitle
                    }.cellUpdate { (cell, row) in
                        cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
                        cell.detailTextLabel?.textColor = UIColor.grayColor()
                        cell.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                        cell.detailTextLabel?.text = self.trans("login.welcome_back.subtitle")

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
                    }
                <<< EmailRow() { row in
                        row.tag = "emailRow"
                        row.placeholder = trans("login.email.placeholder")
                    }.onChange { (row) in
                        self.onepasswordButton.hidden = row.value != nil || row.value == ""
                    }.cellUpdate { (cell, row) in
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
                            cell.contentView.addSubview(self.onepasswordButton)
                            self.onepasswordButton.snp_makeConstraints { (make) -> Void in
                                make.height.equalTo(cell.contentView.snp_height)
                                make.width.equalTo(cell.contentView.snp_height)
                                make.right.equalTo(cell.textField)
                                make.centerY.equalTo(cell.textField)
                            }
                        }
                    }
                <<< PasswordRow() { row in
                        row.tag = "passwordRow"
                        row.placeholder = trans("login.password.placeholder")
                    }.cellUpdate { (cell, row) in
                        let divider: UIView = UIView()
                        divider.backgroundColor = UIColor(rgba: "#e6e7e8")
                        cell.contentView.addSubview(divider)
                        divider.snp_makeConstraints { (make) -> Void in
                            make.width.equalTo(dividerWidth)
                            make.bottom.equalTo(0)
                            make.height.equalTo(1)
                            make.centerX.equalTo(cell)
                        }
                    }
                <<< LabelRow() { row in
                    }.cellUpdate { (cell, row) in
                        cell.height =  { 62 }

                        cell.contentView.addSubview(self.submitButton)

                        self.submitButton.snp_makeConstraints { (make) -> Void in
                            make.width.equalTo(dividerWidth)
                            make.height.equalTo(38)
                            make.centerX.equalTo(cell)
                            make.centerY.equalTo(cell)
                            make.top.equalTo(12)
                            make.bottom.equalTo(12)
                        }
                    }
                <<< LabelRow() { row in
                    }.cellUpdate { (cell, row) in
                        cell.height =  { 22 }

                        cell.contentView.addSubview(self.forgotPasswordButton)

                        self.forgotPasswordButton.snp_makeConstraints { (make) -> Void in
                            make.width.equalTo(dividerWidth)
                            make.height.equalTo(22)
                            make.centerX.equalTo(cell)
                            make.centerY.equalTo(cell)
                        }
                    }
    }

    func clickMenuClose(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    func onepasswordButtonPressed(sender: UIButton!) {
        OnePasswordExtension.sharedExtension().findLoginForURLString(URLs.webURL, forViewController: self, sender: sender) { (loginDictionary, error) in
            if loginDictionary == nil {
                if error!.code != Int(AppExtensionErrorCodeCancelledByUser) {
                    print("Error invoking 1Password App Extension for find login: \(error)")
                }
                return
            }
            
            self.form.setValues([
                "emailRow": loginDictionary?[AppExtensionUsernameKey] as? String,
                "passwordRow": loginDictionary?[AppExtensionPasswordKey] as? String
            ])
            self.tableView?.reloadData()
        }
    }
    
    func forgotPasswordButtonPressed(sender: UIButton) {
        let controller = ResetPasswordController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func submitButtonPressed(sender: UIButton) {
        let values = form.values()
        let email = values["emailRow"] as? String
        let password = values["passwordRow"] as? String
        
        if (email == nil || password == nil) {
            SVProgressHUD.showErrorWithStatus("用户名和密码不能为空")
            return
        }
        
        let completionBlock = { (data: User!, error: NSError!) in
            if (error != nil) {
                return
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        Api.login(email, password, completion: completionBlock)
    }

}
