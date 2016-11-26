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
import Foundation
import SVProgressHUD
import UserNotifications
import KSCrash

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = HomeController()
        self.window!.makeKeyAndVisible()
        self.window!.tintColor = UIColor.blackColor()
        
        // 初始化 KSCrash 配置
        let installation: KSCrashInstallationStandard = KSCrashInstallationStandard.sharedInstance()
        installation.url = NSURL(string: "https://collector.bughd.com/kscrash?key=3d58e0da5ec7d0b3fba0bd96dc98aa6b")
        installation.install()
        installation.sendAllReportsWithCompletion(nil)
        
        // 初始化 SVProgressHUD 的配置
        SVProgressHUD.setDefaultStyle(.Dark)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
        
        // 初始化PushNotification
        self.registerRemoteNotification()

        // 初始化 YunBa
        YunBaService.setupWithAppkey(BuildConfig.YUNBA_APP_KEY)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onMessageReceived), name: kYBDidReceiveMessageNotification, object: nil)
        // 设置YunBa别名成功
        let ybAlias = Auth.check() ? String(Auth.id()).md5 : nil
        YunBaService.setAlias(ybAlias) { (succ, error) in
            if (succ) {
                print("subscribe alias (\(ybAlias)) successed")
            } else {
                print("subscribe alias (\(ybAlias)) failed")
            }
        }
        
        // 初始化 GrowingIO
        Growing.startWithAccountId(BuildConfig.GROWING_ID)

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        Growing.handleUrl(url)
        if (url.absoluteString!.containsString("daza://")) {
            // 将DeepLink数据转发给HomeController处理
            NSNotificationCenter.defaultCenter().postNotificationName("DeepLinkingEvent", object: url.absoluteString!)
            return false
        }
        return true
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        YunBaService.storeDeviceToken(deviceToken) { (succ, error) -> Void in
            if (succ) {
                print("store device token to YunBa successed")
            } else {
                print("store device token to YunBa failed due to : \(error), recovery suggestion: \(error.localizedRecoverySuggestion)")
            }
        }
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    }
    
    func registerRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center: UNUserNotificationCenter = UNUserNotificationCenter.currentNotificationCenter()
            center.requestAuthorizationWithOptions(UNAuthorizationOptions(arrayLiteral: [.Alert, .Badge, .Sound]), completionHandler: { (granted, error) in
            })
        } else {
            let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
            UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        }
        
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func onMessageReceived(notification: NSNotification) {
        let message: YBMessage = notification.object as! YBMessage
        let jsonString = String(data: message.data, encoding: NSUTF8StringEncoding)
        print("YunBa >>> \(jsonString)")
    }
    
}

