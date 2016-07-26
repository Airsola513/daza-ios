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
    
    var currentViewController: UIViewController!
    var ownArticlesController: OwnArticlesController = OwnArticlesController()
    var ownTopicsController: OwnTopicsController = OwnTopicsController()
    var ownFavoritesController: OwnFavoritesController = OwnFavoritesController()

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
        self.stretchyHeader.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

        self.tableView!.addSubview(self.stretchyHeader)
        
        self.menuNotifications = UIBarButtonItem(image: UIImage(named: "ic_menu_notifications"), style: .Plain, target: self, action: #selector(notificationsButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = self.menuNotifications

        self.menuSettings = UIBarButtonItem(image: UIImage(named: "ic_menu_settings"), style: .Plain, target: self, action: #selector(settingsButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSettings

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginStatusChanged(_:)), name: "LoginStatusChangedEvent", object: nil)

        currentViewController = ownArticlesController
        addChildViewController(currentViewController)
        currentViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.tableView.addSubview(currentViewController.view)
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
        if (!Auth.check(self)) {
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
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }

    func segmentedControlValueChanged(sender: UISegmentedControl) {
        let newController: UITableViewController!
        let oldController = currentViewController
        
        switch sender.selectedSegmentIndex {
        case 0:
            newController = ownArticlesController
            break
        case 1:
            newController = ownTopicsController
            break
        case 2:
            newController = ownFavoritesController
            break
        default:
            newController = ownArticlesController
            break
        }
        
        currentViewController = newController
        
        oldController.willMoveToParentViewController(nil)
        addChildViewController(newController)
        newController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.tableView.addSubview(newController.view)
        
        transitionFromViewController(oldController, toViewController: newController, duration: 0, options: .TransitionCrossDissolve, animations:{ () -> Void in
            // nothing needed here
            }, completion: { (finished) -> Void in
                oldController.removeFromParentViewController()
                newController.didMoveToParentViewController(self)
        })
    }
    
    // 我的问题列表发生变化
    @objc func loginStatusChanged(notification: NSNotification) {
        self.stretchyHeader?.updateIfNeeded()
    }
    
}