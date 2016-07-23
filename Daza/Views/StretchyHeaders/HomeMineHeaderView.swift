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
import GSKStretchyHeaderView

class HomeMineHeaderView: GSKStretchyHeaderView {
    
    class func instanceFromNib() -> HomeMineHeaderView {
        return UINib(nibName: "HomeMineHeaderView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! HomeMineHeaderView
    }

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var modifyProfileButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.modifyProfileButton.setTitle(trans("home.mine.modify_profile.title"), forState: .Normal)
        self.followingButton.setTitle(trans("home.mine.following.title"), forState: .Normal)
        self.followersButton.setTitle(trans("home.mine.followers.title"), forState: .Normal)
    }
    
    var user: User!
    
    var data: User! {
        get {
            return self.user
        }
        set(newValue) {
            self.user = newValue
            if (Auth.check()) {
                self.nameButton.setTitle(user.name, forState: UIControlState.Normal)
                self.usernameLabel.text = "@\(user!.username!)"
                self.avatarImageView.sd_setImageWithURL(NSURL(string: (user!.avatar_url)!), placeholderImage: UIImage(named: "placeholder_image"))
            } else {
                self.nameButton.setTitle(trans("home.mine.name.not_logged.title"), forState: UIControlState.Normal)
                self.usernameLabel.text = ""
                self.avatarImageView.sd_setImageWithURL(NSURL(string: ""), placeholderImage: UIImage(named: "placeholder_image"))
            }
        }
    }
    
    func updateIfNeeded() {
        self.data = Auth.user()
    }


}