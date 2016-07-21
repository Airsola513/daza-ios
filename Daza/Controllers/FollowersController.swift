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

class FollowersController: BaseListController<User> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(FollowersItemCell.self, forCellReuseIdentifier: "FollowersItemCell")
        self.tableView.registerNib(UINib(nibName: "FollowersItemCell", bundle: nil), forCellReuseIdentifier: "FollowersItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let loadDataSuccess = { (pagination: Pagination, data: [User]) -> Void in
            self.loadComplete(pagination, data)
        }
        let jsonString = "{\"status\": \"success\", \"pagination\": {}, \"data\": [{\"name\": \"痕迹\", \"username\": \"lijy91\", \"avatar_url\": \"\"},{\"name\": \"痕迹2\", \"username\": \"lijy912\", \"avatar_url\": \"\"}]}";
        print(jsonString)
        let result: ResultOfArray<User> = Mapper<ResultOfArray<User>>().map(jsonString)!
        
        loadDataSuccess(result.pagination!, result.data!)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FollowersItemCell = tableView.dequeueReusableCellWithIdentifier("FollowersItemCell", forIndexPath: indexPath) as! FollowersItemCell
        
        let data = self.itemsSource[indexPath.row]
        
        cell.data = data
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        let data = self.itemsSource[indexPath.row]
        
        let controller = UserDetailController(data)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}