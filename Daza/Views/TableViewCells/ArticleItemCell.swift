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
import DateTools
import SDWebImage

class ArticleItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var viewCountButton: UIButton!
    
    var article: Article?
    
    var data: Article {
        get {
            return self.article!
        }
        set(newValue) {
            self.article = newValue
            self.titleLabel.text = article!.title
            self.topicLabel.text = "\(article!.topic!.name!) · "
            self.timeLabel.text = article!.published_at?.timeAgoSinceNow()
            self.commentCountButton.setTitle("\(article!.comment_count)评论", forState: UIControlState.Normal)
            self.viewCountButton.setTitle("\(article!.view_count)阅读", forState: UIControlState.Normal)
            self.coverImageView.sd_setImageWithURL(NSURL(string: (article!.image_url)!))
        }
    }
}
