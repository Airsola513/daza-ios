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
import ObjectMapper
import GSKStretchyHeaderView
import XLPagerTabStrip

class HomeMineController: BaseTableViewController {

    var menuNotifications: UIBarButtonItem?
    var menuSettings: UIBarButtonItem?
    
    var stretchyHeader: HomeMineHeaderView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("home.mine.title")
        
        self.tableView.tableFooterView = UIView()

        self.stretchyHeader = HomeMineHeaderView.instanceFromNib()
        self.stretchyHeader.updateIfNeeded()
        self.stretchyHeader.nameButton.addTarget(self, action: #selector(nameButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.stretchyHeader.modifyProfileButton.addTarget(self, action: #selector(modifyProfileButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.stretchyHeader.followingButton.addTarget(self, action: #selector(followingButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.stretchyHeader.followersButton.addTarget(self, action: #selector(followersButtonPressed(_:)), forControlEvents: .TouchUpInside)

        self.tableView!.addSubview(self.stretchyHeader)
        
        self.menuNotifications = UIBarButtonItem(image: UIImage(named: "ic_menu_notifications"), style: .Plain, target: self, action: #selector(notificationsButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = self.menuNotifications

        self.menuSettings = UIBarButtonItem(image: UIImage(named: "ic_menu_settings"), style: .Plain, target: self, action: #selector(settingsButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSettings

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginStatusChanged(_:)), name: "LoginStatusChangedEvent", object: nil)
        
        let controller = ArticleListController(nil)
        controller.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        controller.tableView.mj_header.hidden = true
        controller.tableView.scrollEnabled = false
//        self.view.addSubview(controller.view)
        self.view.addSubview(controller.view)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let navigationController = self.navigationController as! BaseNavigationController
        navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let navigationController = self.navigationController as! BaseNavigationController
        navigationController.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.shadowImage = nil
    }
    
    func notificationsButtonPressed(sender: UIBarButtonItem) {
        if (!Auth.check()) {
            let controller: BaseNavigationController = BaseNavigationController(rootViewController: LoginController())
            self.presentViewController(controller, animated: true, completion: nil)
            return
        }
        let controller = NotificationsController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func settingsButtonPressed(sender: UIBarButtonItem) {
        let controller = SettingsController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func nameButtonPressed(sender: UIButton!) {
        if (!Auth.check()) {
            let controller: BaseNavigationController = BaseNavigationController(rootViewController: LoginController())
            self.presentViewController(controller, animated: true, completion: nil)
            return
        }
        let controller = UserDetailController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func modifyProfileButtonPressed(sender: UIButton!) {
        let controller = ModifyProfileController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func followingButtonPressed(sender: UIButton!) {
        let controller = FollowingController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func followersButtonPressed(sender: UIButton!) {
        let controller = FollowersController(Auth.user())
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 50
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
//        return cell
//    }
    
    
    // 我的问题列表发生变化
    @objc func loginStatusChanged(notification: NSNotification) {
        self.stretchyHeader?.updateIfNeeded()
    }
    
}