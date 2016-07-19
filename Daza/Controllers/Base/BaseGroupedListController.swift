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

        let textLabelFont = UIFont.systemFontOfSize(15)
        let textFieldFont = UIFont.systemFontOfSize(15)

        LabelRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = textLabelFont
        }
        TextRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = textLabelFont
            cell.textField.font = textFieldFont
        }
        EmailRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = textLabelFont
            cell.textField.font = textFieldFont
        }
        PasswordRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = textLabelFont
            cell.textField.font = textFieldFont
        }
        ButtonRow.defaultCellUpdate = { cell, row in
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(15)
        }

        self.tableView!.backgroundColor = UIColor(rgba: "#ECEFF1")
    }

}