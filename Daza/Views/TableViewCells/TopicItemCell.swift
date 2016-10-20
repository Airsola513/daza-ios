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

class TopicItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var subscriberCountButton: UIButton!
    
    var topic: Topic?
    
    var data: Topic {
        get {
            return self.topic!
        }
        set(newValue) {
            self.topic = newValue
            self.nameLabel.text = topic!.name
            self.descriptionLabel.text = topic!.description
//            self.subscriberCountButton.setTitle("\(topic!.subscriber_count)订阅", forState: UIControlState.Normal)
            self.coverImageView.sd_setImageWithURL(NSURL(string: (topic!.image_small_url)), placeholderImage: UIImage(named: "placeholder_image"))
        }
    }
}