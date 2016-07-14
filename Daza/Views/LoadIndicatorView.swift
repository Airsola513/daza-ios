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

class LoadIndicatorView: UIView {
    
    var loadingView: UIActivityIndicatorView = UIActivityIndicatorView()
    var loadingLabel: UILabel = UILabel()
    var emptyLabel: UILabel = UILabel()
    var errorLabel: UILabel = UILabel()
    var retryButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.addSubview(self.loadingView)
        self.addSubview(self.loadingLabel)
        self.addSubview(self.emptyLabel)
        self.addSubview(self.errorLabel)
        self.addSubview(self.retryButton)
        self.backgroundColor = UIColor.blueColor()
        
        let offset = CGPointMake(0, -40)
        
        self.loadingView.snp_makeConstraints { (make) in
            make.center.equalTo(self).offset(offset)
        }
        self.emptyLabel.snp_makeConstraints { (make) in
            make.center.equalTo(self).offset(offset)
        }
        self.errorLabel.snp_makeConstraints { (make) in
            make.center.equalTo(self).offset(offset)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hide() {
        self.hidden = true
        self.hideLoading()
        self.hideEmpty()
        self.hideError()
    }
    
    func show() {
        self.hide()
        self.hidden = false
    }
    
    func hideLoading() {
        self.loadingView.hidden = true
        self.loadingLabel.hidden = true
        self.loadingView.stopAnimating()
    }
    
    func showLoading() {
        self.show()
        self.loadingView.hidden = false
        self.loadingLabel.hidden = false
        self.loadingView.startAnimating()
    }
    
    func hideEmpty() {
        self.emptyLabel.hidden = true
    }
    
    func showEmpty(text: String) {
        self.show()
        self.emptyLabel.hidden = false
        self.emptyLabel.text = text
    }
    
    func hideError() {
        self.errorLabel.hidden = true
    }

    func showError(text: String) {
        self.show()
        self.errorLabel.hidden = false
        self.errorLabel.text = text
    }
}