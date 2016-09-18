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

class InAppBrowserController: BaseWebViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        if (!Auth.check()) {
            return
        }
        let standardUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let authId = Auth.id();
        let authUser = standardUserDefaults.stringForKey("auth.user")
        let authJwtToken = standardUserDefaults.stringForKey("auth.jwt_token")
        var script = ""
        script += "localStorage.setItem('auth.id', '\(authId)');\n"
        script += "localStorage.setItem('auth.user', '\(authUser!)');\n"
        script += "localStorage.setItem('auth.jwt_token', '\(authJwtToken!)');\n"
        webView.stringByEvaluatingJavaScriptFromString(script)
    }

}