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

/// 重置keywindow  此处需要注释掉
//    var window: UIWindow?
    
    
  
    /// 加载完成
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
                UIViewController.initializeOnceMethod();
        // Override point for customization after application launch.
        
        KATRouter.registeRouter(className: "ViewController", host: "kViewController");
        KATRouter.registeRouter(className: "SecondViewController", host: "kSecondViewController");
   
          LLog( KATRegularExpression.regularExpressionProtocolName(sourceText: "https=k#frag://=k#frag://"))
          LLog(KATRegularExpression.regularExpressionPort(sourceText: "https://kat@kantice.com:80/path?id=1&name=k#frag"))
        return true
    }
    
    ///
    func applicationWillResignActive(_ application: UIApplication) {
       
    }
    
    /// 应用进入已经后台
    func applicationDidEnterBackground(_ application: UIApplication) {
     
        
    }
    
    /// 应用将要进入前台
    func applicationWillEnterForeground(_ application: UIApplication) {
       
        LLog("应用进入前台");
    }
    
    /// 应用将要变为活跃
    func applicationDidBecomeActive(_ application: UIApplication) {
 
        
    }
    
    /// 应用即将终止
    func applicationWillTerminate(_ application: UIApplication) {
        
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
