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

import ObjectMapper
import Foundation

class Thumbnail {
    
    var imageUrl: String = ""
    
    let defaultWidth = 120;
    let defaultHeight = 120;
    
    init(value: String) {
        self.imageUrl = value;
    }
    
    func imageView2(size: Int) -> String {
        var width = defaultWidth
        var height = defaultHeight
        if (self.imageUrl.containsString(BuildConfig.DOMAIN_NAME) || self.imageUrl.containsString("clouddn.com")) {
            if (size > 0) {
                width = size
                height = size
            }
            return "\(self.imageUrl)?imageView2/2/w/\(width)/h/\(height)"
        }
        return self.imageUrl
    }

    func small() -> String {
        return self.imageView2(200)
    }
    
    func medium() -> String {
        return self.imageView2(800)
    }
    
    func large() -> String {
        return self.imageView2(1200)
    }
}
