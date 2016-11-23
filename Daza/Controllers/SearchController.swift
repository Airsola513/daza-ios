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

class SearchController: BaseTableViewController, UISearchBarDelegate {

    var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化搜索框
        self.searchBar = UISearchBar(frame: CGRectMake(96, 0, 200, 44))
        self.searchBar.showsCancelButton = true
        self.searchBar.backgroundColor = .clearColor()
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.barTintColor = .clearColor()
        self.searchBar.placeholder = "搜索你感兴趣的内容"
        for subView in self.searchBar.subviews {
            for ndLeveSubView in subView.subviews {
                if (ndLeveSubView.isKindOfClass(UITextField)) {
                    let textField = ndLeveSubView as? UITextField
                    textField?.backgroundColor = UIColor(rgba: "#ECEFF1")
                }
            }
        }
        self.searchBar.delegate = self

        let titleView: UIView = UIView(frame: (self.navigationController?.navigationBar.frame)!)
        titleView.backgroundColor = .clearColor()
        titleView.addSubview(self.searchBar)
        self.searchBar.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.centerY.equalTo(0)
        }
        self.navigationItem.titleView = titleView
        self.searchBar.becomeFirstResponder()
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }

}
