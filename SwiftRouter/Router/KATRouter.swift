//
//  KATRouter.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/12.
//  Copyright © 2018年 吕陈强. All rights reserved.
// 视图控制器切换路由器

import Foundation
import UIKit

typealias BlockVoidToVoid = () -> (Void)



// MARK:定义路由的协议
protocol KATRouterDelegate: NSObjectProtocol {
    // MARK:路由相关
    /// 路由跳转完成
    func routingFinish(values:NSDictionary,backward:Bool);
    /// 路由跳转即将开始
    func routingBegin(values:NSDictionary,backward:Bool);
    /// 路由跳转到其他vc
    func riutingDismiss(values:NSDictionary,backward:Bool);
   /// 是否允许路由的跳转 (VC上将要执行路由跳转行为时触发 返回YES表示允许，若没有实现该回调方法， 则都允许路由 侧滑无效)
    func allowRouting(values:NSDictionary) -> Bool;
    /// 接受到消息
    func receiverRouterMessage(values:NSDictionary);
    /// 实例即将被释放
    func instanceWillBeReleased();
    
    
    // MARK:app 生命周期
    ///App激活
    func appDidBecomeActive();
    
    ///App将要退出活跃
    func appWillResignActive();
    
    ///App将要进入前台
    func appWillEnterForeground();
    
    ///App进入后台
    func appDidEnterBackground();
    
    ///App将要终止
    func appWillTerminate();
    
    ///App通过URL中打开(此回调方法只在页面没有发生跳转的情况下正确执行，若有跳转，则会执行跳转前的VC的该回调方法，默认会发生跳转，推荐在routingFinishWithValues:回调方法中处理事件)
    func appOpened(url:URL,info:NSDictionary) -> Bool;
    
    ///App接收到通知(本地或远程)
    func appReceivedNotification(info:NSDictionary);
    
    ///App注册远程通知
    func appRegisteredRemoteNotificationWithDeviceToken(deviceToken:Data);

}

// MARK:定义路由的实体类
class KATRouter: NSObject {
    
    /// appdelegate
    fileprivate var app:UIApplicationDelegate = UIApplication.shared.delegate!;
    /// 类表
    fileprivate  var classMap = [String:String]();
    
    /// 实例表
    fileprivate var instanceMap = [String:UIViewController]();
    
    /// 容器表
    fileprivate var valueMap = [String:String]();
    
    /// 回退栈
    fileprivate var backwardStack = [String:String]();
    
    /// 根控制器
    fileprivate var rootVC = KATRouterRootVC();
    
    // MARK:app 生命周期的回调
    var appDidBecomeActiveAction:BlockVoidToVoid?
    var appWillResignActive:BlockVoidToVoid?
    var appWillEnterForeground:BlockVoidToVoid?
    var appDidEnterBackground:BlockVoidToVoid?
    var appWillTerminate:BlockVoidToVoid?
    var appOpenedWithURL:((_ url:URL,_ info:NSDictionary) -> Bool)?
    // MARK:实例化路由事件
    /// 对象共享一个操作的实例
    static let shareRouter:KATRouter = {
        let router =  KATRouter();
        
        //打开应用 本地或者远程
        router.appOpenedWithURL = {(url,info) in
            
            return true;
        }
        
        
        return router;
    }();
    

    

    
}

// MARK:处理路由的app生命周期
extension KATRouter{
    
    
    
    
    // MARK:- APP代理方法回调以及动作(先执行该动作,再执行VC代理的回调方法) before
    
    ///设置App激活动作
    class func setAppDidBecomeActive(action:@escaping () -> Void){
        
    }
    ///设置App将要退出活跃动作
    class func setAppWillResignActive(action:@escaping () -> Void){
        
    }
    
    ///设置App将要进入前台动作(此动作有默认值，即徽标清零)
    class func setAppWillEnterForeground(action:@escaping () -> Void){
        
    }
    ///设置App进入后台动作
    class func setAppDidEnterBackground(action:@escaping () -> Void){
        
    }
    ///设置App将要终止动作
    class func setAppWillTerminate(action:@escaping () -> Void){
        
    }
    
    ///设置App通过URL中打开动作(此动作有默认值，即跳转到URL)(因为没有对应的系统通知，需要在AppDlelgate中实现application:openURL:options:方法，空实现亦可)
    class func setAppOpenedWithURL(action:@escaping (URL,Dictionary<String,Any>)-> Bool){
        
    }
}
