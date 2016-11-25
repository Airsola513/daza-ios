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

class HomeMineController: BaseGroupedListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("home.mine.title")

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginStatusChanged(_:)), name: "LoginStatusChangedEvent", object: nil)

        form
            +++ Section()
                <<< LabelRow() { row in
                        row.tag = "profileRow"
                        row.cellStyle = UITableViewCellStyle.Subtitle
                        self.updateProfileRow(row)
                    }.cellUpdate { (cell, row) in
                        cell.height = { 70 }
                        cell.detailTextLabel?.text = "查看或编辑个人资料"
                    }.onCellSelection { (cell, row) in
                        if (!Auth.check(self)) {
                            return
                        }
                        let controller = ModifyProfileController()
                        controller.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
            +++ Section()
                <<< ButtonRow() { row in
                        row.tag = "ownTopicsRow"
                        row.title = "我的主题"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { OwnTopicsController(Auth.id()) }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.tag = "ownSubscribesRow"
                        row.title = "我订阅的"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { OwnSubscribesController(Auth.id()) }), completionCallback: nil)
                    }
                <<< ButtonRow() { row in
                        row.tag = "ownUpvotesRow"
                        row.title = "我赞过的"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { OwnUpvoteArticlesController(Auth.id()) }), completionCallback: nil)
                }
            +++ Section()
                <<< ButtonRow() { row in
                        row.tag = "settingsRow"
                        row.title = "设置"
                        row.presentationMode = .Show(controllerProvider: .Callback( builder: { SettingsController() }), completionCallback: nil)
                }
        self.updateCellsIfDisabled()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func updateProfileRow(row: LabelRow?) {
        if (!Auth.check()) {
            row?.title = "未登录"
            row?.cell.imageView!.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "placeholder_image"))
        } else {
            let user = Auth.user()
            row?.title = user.name
            row?.cell.imageView!.sd_setImageWithURL(NSURL(string: user.avatar_small_url), placeholderImage: UIImage(named: "placeholder_image"))
        }
        row?.updateCell()
    }
    
    func updateCellsIfDisabled() {
        self.form.rowByTag("ownTopicsRow")!.disabled = Auth.check() ? false : true
        self.form.rowByTag("ownTopicsRow")!.evaluateDisabled()
        self.form.rowByTag("ownSubscribesRow")!.disabled = Auth.check() ? false : true
        self.form.rowByTag("ownSubscribesRow")!.evaluateDisabled()
        self.form.rowByTag("ownUpvotesRow")!.disabled = Auth.check() ? false : true
        self.form.rowByTag("ownUpvotesRow")!.evaluateDisabled()
    }

    func nameButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = UserDetailController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func modifyProfileButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = ModifyProfileController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func followingButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = FollowingController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func followersButtonPressed(sender: UIButton!) {
        if (!Auth.check(self)) {
            return
        }
        let controller = FollowersController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

    // 登录状态发生变化
    @objc func loginStatusChanged(notification: NSNotification) {
        let row: LabelRow? = form.rowByTag("profileRow")
        self.updateProfileRow(row)
        self.updateCellsIfDisabled()
    }

}
