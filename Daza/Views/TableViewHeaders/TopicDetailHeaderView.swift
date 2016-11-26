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

class TopicDetailHeaderView: UITableViewCell {
    
    class func instanceFromNib() -> TopicDetailHeaderView {
        return UINib(nibName: "TopicDetailHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! TopicDetailHeaderView
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subscribeButton: UIButton!
    @IBOutlet weak var createrLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var topic: Topic?
    
    var data: Topic {
        get {
            return self.topic!
        }
        set(newValue) {
            self.topic = newValue
            self.coverImageView.sd_setImageWithURL(NSURL(string: (topic!.image_small_url)), placeholderImage: UIImage(named: "placeholder_image"))
            self.nameLabel.text = topic!.name
            if (self.topic!.subscribed != nil && self.topic!.subscribed) {
                self.subscribeButton.setTitle("已订阅 (\(self.topic!.subscriber_count))", forState: UIControlState.Normal)
//                self.subscribeButton.backgroundColor = UIColor(rgba: "#37474F")
//                self.subscribeButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            } else {
                self.subscribeButton.setTitle("订阅 (\(self.topic!.subscriber_count))", forState: UIControlState.Normal)
//                self.subscribeButton.backgroundColor = UIColor.whiteColor()
//                self.subscribeButton.setTitleColor(UIColor(rgba: "#37474F"), forState: UIControlState.Normal)
            }
            if (self.topic!.user != nil) {
                self.createrLabel.text = "由 \(topic!.user.name) 维护"
            } else {
                self.createrLabel.text = ""
            }
            self.descriptionLabel.text = topic!.description!
            
        }
    }


}
