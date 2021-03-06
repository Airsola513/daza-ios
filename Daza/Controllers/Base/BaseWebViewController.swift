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
import SnapKit
import NJKWebViewProgress

class BaseWebViewController: BaseViewController, UIWebViewDelegate, NJKWebViewProgressDelegate {
    
    var webView: UIWebView = UIWebView()
    var progressView: NJKWebViewProgressView?
    var progressProxy: NJKWebViewProgress = NJKWebViewProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = progressProxy
        self.progressProxy.webViewProxyDelegate = self
        self.progressProxy.progressDelegate = self
        
        let progressBarHeight: CGFloat = 2.0
        let navigationBarBounds: CGRect = self.navigationController!.navigationBar.bounds;
        let barFrame: CGRect = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight)
        self.progressView = NJKWebViewProgressView(frame: barFrame)
        self.progressView?.setProgress(0, animated: true)
        self.progressView?.progressBarView.backgroundColor = UIColor(rgba: "#ECEFF1")
        
        self.view.addSubview(self.webView)
        
        self.webView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.addSubview(self.progressView!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.progressView?.removeFromSuperview()
    }
    
    func webViewProgress(webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        self.progressView!.setProgress(progress, animated: true)
    }
    
}