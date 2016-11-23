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

class HomeController: UITabBarController {
    
    var indexController: UINavigationController!
    var exploreController: UINavigationController!
    var inboxController: UINavigationController!
    var mineController: UINavigationController!
    
    let homeIndexController   = HomeIndexController()
    let homeExploreController = HomeExploreController()
    let homeInboxController   = HomeInboxController()
    let homeMineController    = HomeMineController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(rgba: "#37474F")
        
        self.indexController = BaseNavigationController(rootViewController: homeIndexController, statusBarStyle: .LightContent)
        self.indexController.tabBarItem.title = trans("home.index.title")
        self.indexController.tabBarItem.image = UIImage(named: "ic_tab_home")
        self.addChildViewController(indexController)
        
        self.exploreController = BaseNavigationController(rootViewController: homeExploreController, statusBarStyle: .LightContent)
        self.exploreController.tabBarItem.title = trans("home.explore.title")
        self.exploreController.tabBarItem.image = UIImage(named: "ic_tab_explore")
        self.addChildViewController(exploreController)
        
        self.inboxController = BaseNavigationController(rootViewController: homeInboxController, statusBarStyle: .LightContent)
        self.inboxController.tabBarItem.title = trans("home.inbox.title")
        self.inboxController.tabBarItem.image = UIImage(named: "ic_tab_inbox")
        self.addChildViewController(inboxController)
        
        self.mineController = BaseNavigationController(rootViewController: homeMineController, statusBarStyle: .LightContent)
        self.mineController.tabBarItem.title = trans("home.mine.title")
        self.mineController.tabBarItem.image = UIImage(named: "ic_tab_mine")
        self.addChildViewController(mineController)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(deepLinkingHandler(_:)), name: "DeepLinkingEvent", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        Api.getNotificationCount { (data, error) in
            if (error == nil) {
                UIApplication.sharedApplication().applicationIconBadgeNumber = data.unread_count
                if (data.unread_count > 0) {
                    self.inboxController.tabBarItem.badgeValue = "\(data.unread_count)"
                } else {
                    self.inboxController.tabBarItem.badgeValue = nil
                }
            }
        }
    }
    
    @objc func deepLinkingHandler(notification: NSNotification) {
        let urlString: String = notification.object as! String
        
        // 拆分URL，获取参数。
        let urlParameters = urlString.componentsSeparatedByString("/")
        let firstAction: String = urlParameters[2]
        let firstId: String = urlParameters.count >= 4 ? urlParameters[3] : "0"
        let secondAction: String = urlParameters.count >= 5 ? urlParameters[4] : ""
        let secondId: Int = urlParameters.count >= 6 ? Int(urlParameters[5])! : 0
        
        var controller: UIViewController!
        switch(firstAction) {
        case "users":
            controller = UserDetailController(Int(firstId)!)
            break
        case "categories":
            break
        case "topics":
            controller = TopicDetailController(Int(firstId)!)
            break
        case "articles":
            switch(secondAction) {
            case "comments":
                controller = ArticleCommentsController(Int(firstId)!)
                break
            default:
                controller = ArticleDetailController(Int(firstId)!)
                break
            }
            break
        case "tags":
//            controller = TagDetailController(firstId)
            break
            return
        default:
            break
        }
        
        if (controller != nil) {
            controller?.hidesBottomBarWhenPushed = true
            // 获取当前所有Tab的UINavigationController，并由它启动新页面
            let navigationController: UINavigationController! = self.childViewControllers[self.selectedIndex] as! UINavigationController
            navigationController.pushViewController(controller!, animated: true)
        }
    }

}
