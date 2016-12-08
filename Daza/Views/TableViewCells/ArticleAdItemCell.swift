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
import GoogleMobileAds

class ArticleAdItemCell: UITableViewCell {
    
    @IBOutlet weak var nativeExpressAdView: GADNativeExpressAdView!
    
    var article: Article!
    
    var data: Article {
        get {
            return self.article
        }
        set(newValue) {
            self.article = newValue
        }
    }
    
    func loadAd(controller: UIViewController) -> Void {
        nativeExpressAdView.adUnitID = BuildConfig.AD_UNIT_ID
        nativeExpressAdView.rootViewController = controller
        
        let request = GADRequest()
        if (BuildConfig.DEBUG) {
            request.testDevices = [kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9b"]
        }
        nativeExpressAdView.loadRequest(request)
    }
}
