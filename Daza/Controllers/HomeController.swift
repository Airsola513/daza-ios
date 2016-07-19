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
    
    let homeIndexController   = HomeIndexController()
    let homeExploreController = HomeExploreController()
    let homeEventsController  = HomeEventsController()
    let homeMineController    = HomeMineController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(rgba: "#37474F")
        
        let indexController: UINavigationController = BaseNavigationController(rootViewController: homeIndexController, statusBarStyle: .LightContent)
        indexController.tabBarItem.title = trans("title_home_index")
        indexController.tabBarItem.image = UIImage(named: "ic_tab_home")
        self.addChildViewController(indexController)
        
        let exploreController: UINavigationController = BaseNavigationController(rootViewController: homeExploreController, statusBarStyle: .LightContent)
        exploreController.tabBarItem.title = trans("title_home_explore")
        exploreController.tabBarItem.image = UIImage(named: "ic_tab_explore")
        self.addChildViewController(exploreController)
        
        let eventsController: UINavigationController = BaseNavigationController(rootViewController: homeEventsController, statusBarStyle: .LightContent)
        eventsController.tabBarItem.title = trans("title_home_events")
        eventsController.tabBarItem.image = UIImage(named: "ic_tab_event")
        self.addChildViewController(eventsController)
        
        let mineController: UINavigationController = BaseNavigationController(rootViewController: homeMineController, statusBarStyle: .LightContent)
        mineController.tabBarItem.title = trans("title_home_mine")
        mineController.tabBarItem.image = UIImage(named: "ic_tab_mine")
        self.addChildViewController(mineController)
    }

}