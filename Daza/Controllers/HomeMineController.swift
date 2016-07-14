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

class HomeMineController: BaseGroupedListController {

    var menuSettings: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_home_mine")

        self.menuSettings = UIBarButtonItem(image: UIImage(named: "ic_menu_settings"), style: .Plain, target: self, action: #selector(settingsButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSettings
        
        self.itemsSource = [
            Section(title: nil, rows: [
                DefaultRow(title: trans("home_mine_login"), subtitle: nil, action: { _ in
                    let controller: BaseNavigationController = BaseNavigationController(rootViewController: LoginController())
                    self.presentViewController(controller, animated: true, completion: { _ in })
                }),
            ]),
            Section(title: nil, rows: [
                DefaultRow(title: trans("home_mine_topics"), subtitle: nil, action: { _ in
                    print("click item");
                }),
                DefaultRow(title: "ITEM2"),
                DefaultRow(title: "ITEM3")
            ]),
        ]
        self.tableView.reloadData()
    }
    
    func settingsButtonPressed(sender: UIBarButtonItem) {
        let controller = SettingsController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}