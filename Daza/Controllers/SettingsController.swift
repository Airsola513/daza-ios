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

class SettingsController: BaseGroupedListController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_settings")
        
        self.itemsSource = [
            Section(title: nil, rows: [
                DefaultRow(title: trans("settings_item_notification")),
            ]),
            Section(title: nil, rows: [
                DefaultRow(title: "ITEM1"),
                DefaultRow(title: "ITEM2"),
                DefaultRow(title: "ITEM3")
            ]),
            Section(title: nil, rows: [
                DefaultRow(title: trans("settings_item_feedback"), subtitle: nil, action: { _ in
                    let controller = BrowserController()
                    self.navigationController?.pushViewController(controller, animated: true)
                }),
                DefaultRow(title: trans("settings_item_about"), subtitle: nil, action: { _ in
                    let controller = AboutController()
                    self.navigationController?.pushViewController(controller, animated: true)
                }),
            ]),
        ]
        self.tableView.reloadData()
    }
    
}