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

public struct Section {
    
    public var title: String?
    public var rows: [Row]
    public var footer: String?
    
    public init(title: String?, rows: [Row], footer: String? = nil) {
        self.title = title
        self.rows = rows
        self.footer = footer
    }
    
}

public protocol Row {
    var title: String { get }
    var subtitle: String? { get }
    var action: ((Row) -> Void)? { get }
}

public struct DefaultRow: Row {

    public var title: String = ""
    public var subtitle: String?;
    
    /// A closure related to the navigation when the row is selected.
    public var action: ((Row) -> Void)?
    
    public init(title: String, subtitle: String? = nil, action: ((Row) -> Void)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
    
    private init() {}
}

class BaseGroupedListController: UITableViewController {
    
    var itemsSource: [Section] = []
    
    init() {
        super.init(style: .Grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemsSource.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = itemsSource[section].rows
        return rows.count
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let row = itemsSource[section]
        return row.title
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let row = itemsSource[section]
        return row.footer
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = itemsSource[indexPath.section].rows[indexPath.row]
        var cell: UITableViewCell! = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = row.title
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = itemsSource[indexPath.section].rows[indexPath.row]
        
        switch (row, row.action) {
        case (let row, let navigation) where row is DefaultRow:
            navigation?(row)
            break
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}