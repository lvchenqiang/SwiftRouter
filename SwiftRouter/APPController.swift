//
//  APPController.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/12.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit
import UserNotifications
// MARK:-生命周期
class APPController: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
  
    /// 加载完成
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        KATRouter.shareRouter.isDisabled = true;
        UIViewController.initializeOnceMethod();
       
        
        
        
        
        return true
    }
    
    ///
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    /// 应用进入已经后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    /// 应用将要进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    /// 应用将要变为活跃
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    /// 应用即将终止
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

// MARK:- 通知推送相关
extension APPController{
    
    /// iOS10以下使用这个方法接收通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo);
    }
    
    //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        
        let type = UIUserNotificationType.alert.rawValue |
            UIUserNotificationType.badge.rawValue |
            UIUserNotificationType.sound.rawValue;
        completionHandler(UNNotificationPresentationOptions(rawValue: type));
        
    }
    
    //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        
        
    }
    
    /// 获取token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let nsdataStr = NSData.init(data: deviceToken)
        let datastr = nsdataStr.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        print("deviceToken:\(datastr)");
   
    }
    
}

// MARK:- 远程启动 OPEN URL 相关
extension APPController{
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

        return false;
    }

 func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    
    return false;
}

func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
    
    return false;
}
    
}
