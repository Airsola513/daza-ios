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
import XLPagerTabStrip
import SVProgressHUD

class HomeIndexController: ButtonBarPagerTabStripViewController {
    
    var menuRefresh: UIBarButtonItem!
    var pagerChildViewControllers: [UIViewController] = []
    
    var latestArticlesController: UIViewController  = ArticlesController(Category.latest())
    var popularArticlesController: UIViewController = ArticlesController(Category.popular())
    
    override func viewDidLoad() {
        // set up style before super view did load is executed
        settings.style.buttonBarBackgroundColor = .clearColor()
        settings.style.selectedBarBackgroundColor = .clearColor()
        settings.style.buttonBarItemLeftRightMargin = 12
        settings.style.buttonBarItemsShouldFillAvailiableWidth = false
        //-
        super.viewDidLoad()
        
        self.menuRefresh = UIBarButtonItem(image: UIImage(named: "ic_menu_refresh"), style: .Plain, target: self, action: #selector(refreshButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuRefresh
        
        self.view.backgroundColor = UIColor(rgba: "#ECEFF1")
        self.containerView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 49)
        
        self.changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(white: 1, alpha: 0.6)
            newCell?.label.textColor = .whiteColor()
            
            if animated {
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransformMakeScale(1.0, 1.0)
                    oldCell?.transform = CGAffineTransformMakeScale(0.8, 0.8)
                })
            }
            else {
                newCell?.transform = CGAffineTransformMakeScale(1.0, 1.0)
                oldCell?.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }
        }
        // 加载分类
        self.reloadCategories()
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        self.buttonBarView.removeFromSuperview()
//        self.navigationController?.navigationBar.addSubview(buttonBarView)
//    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.buttonBarView.removeFromSuperview()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.buttonBarView.removeFromSuperview()
        self.navigationController?.navigationBar.addSubview(buttonBarView)
    }
    
//    override func viewDidDisappear(animated: Bool) {
//        super.viewDidDisappear(animated)
//        self.buttonBarView.removeFromSuperview()
//    }
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllersForPagerTabStrip(pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        if (self.pagerChildViewControllers.count == 0) {
            self.pagerChildViewControllers.append(self.latestArticlesController)
            self.pagerChildViewControllers.append(self.popularArticlesController)
        }
        return pagerChildViewControllers
    }
    
    override func configureCell(cell: ButtonBarViewCell, indicatorInfo: IndicatorInfo) {
        super.configureCell(cell, indicatorInfo: indicatorInfo)
        cell.backgroundColor = .clearColor()
    }

    func refreshButtonPressed(sender: UIBarButtonItem) {
        self.reloadCategories()
    }
    
    func reloadCategories() {
        let completionBlock = { (pagination: Pagination!, data: [Category]!, error: NSError!) in
            self.pagerChildViewControllers = []
            if (error == nil) {
                self.pagerChildViewControllers.append(self.latestArticlesController)
                self.pagerChildViewControllers.append(self.popularArticlesController)
                
                for category in data {
                    self.pagerChildViewControllers.append(ArticlesController(category))
                }
                self.navigationItem.rightBarButtonItem = nil
                self.buttonBarView.frame.size.width = self.view.bounds.width + 44
            } else {
                self.navigationItem.rightBarButtonItem = self.menuRefresh
                self.buttonBarView.frame.size.width = self.view.bounds.width - 44
            }
            self.reloadPagerTabStripView()
            SVProgressHUD.dismiss()
        }
        SVProgressHUD.showWithStatus("waiting...")
        Api.getCategoryList(1, completion: completionBlock)
    }
}
