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
    
    var pagination: Pagination? = nil
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
            self.pagination = nil
            self.tableView.mj_footer.resetNoMoreData()
            self.loadData(1)
        }
        self.mjFooter = MJRefreshAutoNormalFooter { () -> Void in
            let currentPage: Int = (self.pagination?.current_page)!
            self.loadData(currentPage + 1)
        }
        self.mjHeader!.lastUpdatedTimeLabel.hidden = true
        self.mjFooter!.automaticallyHidden = true
        
        self.tableView.mj_header = self.mjHeader
        self.tableView.mj_footer = self.mjFooter
        // 不显示多余的分割线
        self.tableView.tableFooterView = UIView()
    }
    // TableView 数量默认为 itemsSource.count
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = itemsSource[indexPath.row]
        var cell: UITableViewCell! = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        return cell
    }

    // 首次进入时刷新数据
    func firstRefreshing() {
        // 延时0.3秒后执行加载数据操作，延时是为了Loading不会因为加载速度过快造成一闪而过的不好体验
        self.delay(0.3) { () -> () in
            self.loadData(1)
        }
    }
    
    // 默认进入下拉刷新状态，如需要进入上拉加载状态请使用self.tableView.mj_footer.beginRefreshing()
    func beginRefreshing() {
        self.tableView.mj_header.beginRefreshing()
    }
    
    // 默认会结束下拉刷新及上拉加载刷新状态
    func endRefreshing() {
        if (self.tableView.mj_header.isRefreshing()) {
            self.tableView.mj_header.endRefreshing()
        }
        if (self.tableView.mj_footer.state != MJRefreshState.NoMoreData) {
            let currentPage = self.pagination!.current_page;
            let lastPage = self.pagination!.last_page;
            // 没有更多数据时禁止上拉加载
            if (lastPage == 0 || currentPage == lastPage) {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self.tableView.mj_footer.endRefreshing()
            }
        }
    }
    
    // 加载数据
    func loadData(page: Int) {
        delay(1) { () -> () in
            self.endRefreshing()
        }
    }
    
    func loadComplete(pagination: Pagination, _ data: [T]) {
        // 下拉刷新时清空数据源
        if (pagination.current_page == 1) {
            self.itemsSource = []
        }
        self.pagination = pagination
        self.itemsSource += data
        // 停止正在刷新
        self.endRefreshing()
        self.tableView.reloadData()
    }
    
    
}