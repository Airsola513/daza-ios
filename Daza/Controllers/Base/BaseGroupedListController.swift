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
import Eureka

class BaseGroupedListController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultCellUpdate = { (cell: BaseCell, row: BaseRow) -> () in
            cell.textLabel?.font = UIFont.systemFontOfSize(15, weight: 1)
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(15)
            cell.detailTextLabel?.textColor = UIColor.lightGrayColor()
            
            if cell is TextFieldCell {
                let textFieldCell: TextFieldCell = cell as! TextFieldCell
                textFieldCell.textField.font = UIFont.systemFontOfSize(15)
            }
            if (row.cellStyle == UITableViewCellStyle.Subtitle) {
                cell.detailTextLabel?.font = UIFont.systemFontOfSize(13)
            }
        }
        
        LabelRow.defaultCellUpdate = defaultCellUpdate
        TextRow.defaultCellUpdate = defaultCellUpdate
        TextAreaRow.defaultCellUpdate = defaultCellUpdate
        NameRow.defaultCellUpdate = defaultCellUpdate
        EmailRow.defaultCellUpdate = defaultCellUpdate
        PasswordRow.defaultCellUpdate = defaultCellUpdate
        SwitchRow.defaultCellUpdate = defaultCellUpdate
        ButtonRow.defaultCellUpdate = defaultCellUpdate
        ImageRow.defaultCellUpdate = defaultCellUpdate
        DateRow.defaultCellUpdate = defaultCellUpdate
        TextAreaRow.defaultCellUpdate = { cell, row in
            defaultCellUpdate(cell, row)
            cell.textView.font = UIFont.systemFontOfSize(15)
            cell.placeholderLabel.font = UIFont.systemFontOfSize(15)
        }

        self.tableView!.backgroundColor = UIColor(rgba: "#ECEFF1")
    }

}
