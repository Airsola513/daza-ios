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

public enum LeftBarButtonItemType {
    case Close
    case Cancel
    case None
}

class BaseNavigationController: UINavigationController {
    
    var statusBarStyle: UIStatusBarStyle = .LightContent
    var leftBarButtonItemType: LeftBarButtonItemType = .None
    
    convenience init(rootViewController: UIViewController, statusBarStyle: UIStatusBarStyle = .Default) {
        self.init(rootViewController: rootViewController, statusBarStyle: statusBarStyle, leftBarButtonItemType: .None)
    }

    init(rootViewController: UIViewController, statusBarStyle: UIStatusBarStyle = .Default, leftBarButtonItemType: LeftBarButtonItemType) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers.append(rootViewController)
        self.statusBarStyle = statusBarStyle
        switch leftBarButtonItemType {
        case .Close:
            let item: UIBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(close(_:)))
            self.childViewControllers[0].navigationItem.leftBarButtonItem = item
            break
        case .Cancel:
            let item: UIBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(cancel(_:)))
            self.childViewControllers[0].navigationItem.leftBarButtonItem = item
            break
        default:
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var tintColor = UIColor.blackColor()
        var barTintColor = UIColor.whiteColor()
        var titleTintColor = UIColor.blackColor()

        if (self.statusBarStyle == .LightContent) {
            tintColor = UIColor.whiteColor()
            barTintColor = UIColor(rgba: "#37474F")
            titleTintColor = UIColor.whiteColor()
        }
        
        self.navigationBar.tintColor = tintColor
        self.navigationBar.barTintColor = barTintColor
        self.navigationBar.translucent = false
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleTintColor]
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    func close(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
}

