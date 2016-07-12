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
import MJRefresh

class BaseListController<T>: UITableViewController {
    
    var itemsSource: [T] = []
    
    var mjHeader: MJRefreshNormalHeader?
    var mjFooter: MJRefreshAutoNormalFooter?
    
    init() {
        super.init(style: .Plain)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化 MJRefresh
        self.mjHeader = MJRefreshNormalHeader { () -> Void in
            self.delay(1, closure: {
                self.tableView.mj_header.endRefreshing();
                self.tableView.mj_footer.endRefreshing();
            })
        }
        self.mjFooter = MJRefreshAutoNormalFooter { () -> Void in
            self.delay(1, closure: {
                self.tableView.mj_header.endRefreshing();
                self.tableView.mj_footer.endRefreshing();
            })
        }
        self.mjHeader!.lastUpdatedTimeLabel.hidden = true
        
        self.tableView.mj_header = self.mjHeader
        self.tableView.mj_footer = self.mjFooter
        // 不显示多余的分割线
        self.tableView.tableFooterView = UIView()
    }
    
}