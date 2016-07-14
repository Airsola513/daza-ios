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

class HomeEventsController: BaseListController<Event> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = trans("title_home_events")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let loadDataSuccess = { (pagination: Pagination, data: [Event]) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.getEventList(page, success: loadDataSuccess)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        let data = self.itemsSource[indexPath.row]
    }
    
}