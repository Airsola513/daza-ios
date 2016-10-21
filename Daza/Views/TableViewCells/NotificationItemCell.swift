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

class NotificationItemCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var notification: Notification?
    
    var data: Notification {
        get {
            return self.notification!
        }
        set(newValue) {
            self.notification = newValue
            
            let reason: String = self.notification!.reason
            let from_user: User = self.notification!.from_user
            let topic: Topic = self.notification!.topic
            let article: Article = self.notification!.article
            
            switch reason {
            case "followed":
                contentLabel.text = "\(from_user.name) 关注了你"
                break
            case "subscribed":
                contentLabel.text = "\(from_user.name) 订阅了主题《\(topic.name)》"
                break
            case "upvoted":
                contentLabel.text = "\(from_user.name) 赞了文章《\(article.title)》"
                break
            case "comment":
                contentLabel.text = "\(from_user.name) 评论了文章《\(article.title)》"
                break
            case "mention":
                contentLabel.text = "\(from_user.name) "
                break
            default:
                contentLabel.text = "未知"
                break
            }
        }
    }
}