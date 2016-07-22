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

class FollowingController: BaseListController<UserRelationship> {
    
    var user: User?
    
    init(_ data: User?) {
        super.init()
        self.user = data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.tableView.registerClass(FollowingItemCell.self, forCellReuseIdentifier: "FollowingItemCell")
        self.tableView.registerNib(UINib(nibName: "FollowingItemCell", bundle: nil), forCellReuseIdentifier: "FollowingItemCell")
        
        self.firstRefreshing()
    }
    
    override func loadData(page: Int) {
        let loadDataSuccess = { (pagination: Pagination, data: [UserRelationship]) -> Void in
            self.loadComplete(pagination, data)
        }
        Api.following(page, userId: user!.id!, success: loadDataSuccess)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FollowingItemCell = tableView.dequeueReusableCellWithIdentifier("FollowingItemCell", forIndexPath: indexPath) as! FollowingItemCell
        
        let data = self.itemsSource[indexPath.row]
        
        cell.data = data.target_user!
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        let data = self.itemsSource[indexPath.row]
        
        let controller = UserDetailController(data.target_user)
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}