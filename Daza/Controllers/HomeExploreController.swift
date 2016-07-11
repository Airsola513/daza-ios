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

class HomeExploreController: BaseListController<Topic> {

    var menuSearch: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_home_explore")
        
        self.menuSearch = UIBarButtonItem(image: UIImage(named: "ic_menu_search"), style: .Plain, target: self, action: #selector(clickMenuSearch(_:)))
        self.navigationItem.rightBarButtonItem = self.menuSearch
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func clickMenuSearch(sender: UIBarButtonItem) {
        let controller: SearchController = SearchController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}