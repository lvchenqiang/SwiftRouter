//
//  KATRouter.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/12.
//  Copyright © 2018年 吕陈强. All rights reserved.
// 视图控制器切换路由器

import Foundation


typealias BlockVoidToVoid = () -> (Void)

class KATRouter: NSObject {
    
    /// 类表
    fileprivate  var classMap = [String:AnyClass]();
    //实例表
    fileprivate var instanceMap = [String:AnyClass]();
    
    /// 对象共享一个操作的实例
    static let shareRouter:KATRouter = {
        let router =  KATRouter();
        return router;
    }();
    
    
    
    var appDidBecomeActiveAction:BlockVoidToVoid!;
    
    // MARK:- APP代理方法回调以及动作(先执行该动作,再执行VC代理的回调方法)
    
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
