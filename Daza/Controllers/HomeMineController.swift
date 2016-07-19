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
import GSKStretchyHeaderView

class HomeMineController: BaseGroupedListController {

    var menuNotifications: UIBarButtonItem?
    var menuSettings: UIBarButtonItem?
    
    var stretchyHeader: HomeMineHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_home_mine")

        self.stretchyHeader = HomeMineHeaderView.instanceFromNib()

//        self.stretchyHeader!.stretchDelegate = self
        self.tableView!.addSubview(self.stretchyHeader!)
        
        self.menuNotifications = UIBarButtonItem(image: UIImage(named: "ic_menu_notifications"), style: .Plain, target: self, action: #selector(notificationsButtonPressed(_:)))
        self.navigationItem.leftBarButtonItem = self.menuNotifications

        self.menuSettings = UIBarButtonItem(image: UIImage(named: "ic_menu_settings"), style: .Plain, target: self, action: #selector(settingsButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSettings

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
            self.presentViewController(controller, animated: true, completion: { _ in })
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

}