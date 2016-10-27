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
    
    var logoImageView: UIImageView!
    var searchBar: UISearchBar!
    
    var menuRefresh: UIBarButtonItem!
    var pagerChildViewControllers: [UIViewController] = []
    
    var latestArticlesController: UIViewController  = ArticlesController(Category.latest())
    var popularArticlesController: UIViewController = ArticlesController(Category.popular())
    
    override func viewDidLoad() {
        // set up style before super view did load is executed
        settings.style.buttonBarHeight = 38
        settings.style.buttonBarItemFont = UIFont.systemFontOfSize(16)
        settings.style.buttonBarBackgroundColor = UIColor(rgba: "#F5F5F5")
        settings.style.selectedBarBackgroundColor = .clearColor()
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        //-
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(deepLinkingHandler(_:)), name: "DeepLinkingEvent", object: nil)

        self.menuRefresh = UIBarButtonItem(image: UIImage(named: "ic_menu_refresh"), style: .Plain, target: self, action: #selector(refreshButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = self.menuRefresh
        
        self.view.backgroundColor = UIColor(rgba: "#ECEFF1")
//        self.containerView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 49)
        
        self.changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = UIColor(rgba: "#999999")
            newCell?.label.textColor = UIColor(rgba: "#37474F")
            
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
        
        self.logoImageView = UIImageView(image: UIImage(named: "ic_logo_light"))
        // 初始化搜索框
        self.searchBar = UISearchBar(frame: CGRectMake(96, 0, 200, 44))
        self.searchBar.backgroundColor = .clearColor()
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.barTintColor = .clearColor()
        self.searchBar.placeholder = "搜索你感兴趣的内容"
//        for subView in self.searchBar.subviews {
//            for ndLeveSubView in subView.subviews {
//                if (ndLeveSubView.isKindOfClass(UITextField)) {
//                    let textField = ndLeveSubView as? UITextField
//                    textField?.backgroundColor = UIColor.whiteColor()
//                    textField?.textColor = UIColor.blackColor()
//                }
//            }
//        }
        let titleView: UIView = UIView(frame: (self.navigationController?.navigationBar.frame)!)
        titleView.backgroundColor = .clearColor()
        titleView.addSubview(self.logoImageView)
        titleView.addSubview(self.searchBar)
        self.logoImageView.snp_makeConstraints { (make) in
            make.left.equalTo(8)
            make.width.equalTo(80)
            make.height.equalTo(20)
            make.centerY.equalTo(0)
        }
        self.searchBar.snp_makeConstraints { (make) in
            make.left.equalTo(self.logoImageView.snp_right).inset(-12)
            make.right.equalTo(-8)
            make.centerY.equalTo(0)
        }
        self.navigationItem.titleView = titleView
    }
    
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
                self.buttonBarView.frame.size.width = self.view.bounds.width
            } else {
                self.navigationItem.rightBarButtonItem = self.menuRefresh
                self.buttonBarView.frame.size.width = self.view.bounds.width - 44
            }
            self.reloadPagerTabStripView()
            SVProgressHUD.dismiss()
        }
        SVProgressHUD.showWithStatus("加载中...")
        Api.getCategoryList(1, completion: completionBlock)
    }
    
    @objc func deepLinkingHandler(notification: NSNotification) {
        let urlString: String = notification.object as! String
        
        // 拆分URL，获取参数。
        let urlParameters = urlString.componentsSeparatedByString("/")
        let firstAction: String = urlParameters[2]
        let firstId: String = urlParameters.count >= 4 ? urlParameters[3] : "0"
        let secondAction: String = urlParameters.count >= 5 ? urlParameters[4] : ""
        let secondId: Int = urlParameters.count >= 6 ? Int(urlParameters[5])! : 0
        
        var controller: UIViewController!
        switch(firstAction) {
        case "users":
            controller = UserDetailController(Int(firstId)!)
            break
        case "categories":
            break
        case "topics":
            controller = TopicDetailController(Int(firstId)!)
            break
        case "articles":
            switch(secondAction) {
            case "comments":
                controller = ArticleCommentsController(Int(firstId)!)
                break
            default:
                controller = ArticleDetailController(Int(firstId)!)
                break
            }
            break
        case "tags":
            controller = TagDetailController(firstId)
            break
        default:
            break
        }

        if (controller != nil) {
            controller?.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller!, animated: true)
        }
    }
}
