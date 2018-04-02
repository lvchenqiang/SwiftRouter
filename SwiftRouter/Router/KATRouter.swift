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

typealias PresentType = @convention(c) (UIViewController, Selector, UIViewController, Bool, BlockVoidToVoid?) -> Void


typealias DismissType = @convention(c) (UIViewController, Selector, Bool,BlockVoidToVoid?)->(Void)

typealias BaseBlockType = (_ elements: Any...) -> (Void)


// MARK:定义常量
/// 主路由key
fileprivate let  kRouterRootHost = "router_root_host";
fileprivate let  kRouterQueueRouting = "dk_router_queue_routing";
fileprivate let  kROUTER_ROUTING_TEST_INTERVAL = (0.05);
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
    fileprivate let app:UIApplicationDelegate = UIApplication.shared.delegate!;
    // MARK:容器层
    /// 类表
    fileprivate  var classNameMap = [String:String]();
    
    /// 实例表
    fileprivate var instanceMap = [String:UIViewController]();
    
    /// 容器表
    fileprivate var valueMap = [String:NSDictionary]();
    
    /// 回退栈
    fileprivate var backwardStack = [String:String]();
     // MARK:视图层
    /// 根控制器
    fileprivate var rootVC = KATRouterRootVC();
    ///根VC背景图
    fileprivate var rootBg = UIImageView();
    /// 主窗口视图
    fileprivate var window = UIApplication.shared.keyWindow;
     // MARK:路由相关
      /// 路由是否可用  默认可用
      var isDisabled = false;
     /// 路由是否暂停  默认可用
      var isWaitting = false;
  
    /// 路由最大等待时长
    var routingWaitDuration:Double = 3.0;
    
    fileprivate let queueRouting = DispatchQueue(label: kRouterQueueRouting);
    
   // MARK:app 生命周期的回调
        /// app即将变为活跃
      fileprivate  var appDidBecomeActiveAction:BlockVoidToVoid?
        /// app即将推出活跃
      fileprivate   var appWillResignActiveAction:BlockVoidToVoid?
        /// app即将进入前台
      fileprivate   var appWillEnterForegroundAction:BlockVoidToVoid?
        /// app即将进入后台
      fileprivate  var appDidEnterBackgroundAction:BlockVoidToVoid?
        /// app 即将终止
      fileprivate   var appWillTerminateAction:BlockVoidToVoid?
        /// app 是否通过URL打开动作
      fileprivate  var appOpenedWithURLAction:((_ url:URL,_ info:NSDictionary) -> Bool)?
        ///App收到通知动作
      fileprivate   var appReceivedNotificationAction:((_ info:NSDictionary)-> Bool)?
        ///App注册远程通知动作
      fileprivate   var appRegisteredNotificationAction:((_ tocken:Data)-> Bool)?
    
      /// 路由跳转指定动作
      fileprivate var routeWithURIAction:((_ info:NSDictionary,_ addition:Any) -> NSDictionary)?;
      /// 所有的路由跳转动作
      fileprivate var routeAction:((NSDictionary) -> Void)?
       // MARK:实例化路由事件
    
    /// 对象共享一个操作的实例
    static let shareRouter:KATRouter = {
        let router =  KATRouter();
        
        
        ///注册屏幕旋转事件通知 方向改变
        NotificationCenter.default.addObserver(router, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil);
        
        
        
        /// app 进入前台
        router.appWillEnterForegroundAction = {
            debugPrint("应用进入前台:appWillEnterForegroundAction");
        }
        
        /// app 进入后台
        router.appDidBecomeActiveAction = {
            debugPrint("应用已经变为活跃:appDidBecomeActiveAction");
        }
        
        /// app 即将终止
        router.appWillTerminateAction = {
            debugPrint("应用即将终止");
        }
        
        
        //打开应用 本地或者远程
        router.appOpenedWithURLAction = {(url,info) in 
            debugPrint("打开应用 本地或者远程");
            return true;
        }
        
     
        //App代理方法挂钩
        hookAppDelegate();
        
       /// 处理跟视图
        router.rootVC = KATRouterRootVC();
        router.rootBg.frame = router.rootVC.view.bounds;
        router.rootBg.contentMode = .scaleAspectFill;
        router.rootBg.image = UIImage.launchImage();
        /// 添加启动图
        router.rootVC.view.addSubview(router.rootBg);
        
        if(router.window == nil){
            router.window = UIWindow(frame: M_RECT(0,0,kScreenW,kScreenH));
        }
        
        
      
//        initialize()
        /// 显示主控制器
        router.window?.rootViewController = router.rootVC;
        router.window?.makeKeyAndVisible();
        
   
        
        // MARK:存储相关数据
        router.classNameMap[kRouterRootHost] = router.rootVC.className;
        router.instanceMap[kRouterRootHost] = router.rootVC;
        router.valueMap[kRouterRootHost] = NSDictionary();
        
        return router;
    }();
    

    

    
}

// MARK:处理路由的app生命周期
extension KATRouter{
    
    
    
    
    // MARK:- APP代理方法回调以及动作(先执行该动作,再执行VC代理的回调方法) before
    
    ///设置App激活动作
    class func setAppDidBecomeActive(action:@escaping () -> Void){
        KATRouter.shareRouter.appDidBecomeActiveAction = action;
    }
    ///设置App将要退出活跃动作
    class func setAppWillResignActive(action:@escaping () -> Void){
        KATRouter.shareRouter.appWillResignActiveAction = action;
    }
    
    ///设置App将要进入前台动作(此动作有默认值，即徽标清零)
    class func setAppWillEnterForeground(action:@escaping () -> Void){
        KATRouter.shareRouter.appWillEnterForegroundAction = action;
    }
    ///设置App进入后台动作
    class func setAppDidEnterBackground(action:@escaping () -> Void){
        KATRouter.shareRouter.appDidEnterBackgroundAction = action;
    }
    ///设置App将要终止动作
    class func setAppWillTerminate(action:@escaping () -> Void){
        KATRouter.shareRouter.appWillTerminateAction = action;
    }
    
    ///设置App通过URL中打开动作(此动作有默认值，即跳转到URL)(因为没有对应的系统通知，需要在AppDlelgate中实现application:openURL:options:方法，空实现亦可)
    class func setAppOpenedWithURL(action:@escaping (URL,NSDictionary)-> Bool){
        KATRouter.shareRouter.appOpenedWithURLAction = action;
    }
  
}


// MARK:处理相关的通知方法
extension KATRouter{
 @objc func deviceOrientationDidChange(){
    
    
    switch KATAppUtil.currentOrientation() {
    case .unknown:
        debugPrint("unknown");
    case .portrait:
        debugPrint("Device oriented vertically, home button on the bottom");
    case .portraitUpsideDown:
        debugPrint("Device oriented vertically, home button on the top");
    case .landscapeLeft:
        debugPrint("Device oriented horizontally, home button on the right");
    case .landscapeRight:
        debugPrint("Device oriented horizontally, home button on the left");
    case .faceUp:
        debugPrint("Device oriented flat, face up");
    case .faceDown:
        debugPrint("Device oriented flat, face down");
    }
    }
    
}




// MARK:路由控制
extension KATRouter{
    ///设置路由跳转时的动作(
    class func setRouteWithURIAction(action:@escaping (NSDictionary,Any) -> NSDictionary){
        KATRouter.shareRouter.routeWithURIAction = action;
    }
    /// 设置路由跳转的所有的动作
    class func setRouteAction(action:@escaping (NSDictionary)-> Void){
        KATRouter.shareRouter.routeAction = action;
    }
     // MARK:注册路由
    // MARK:注册路由控制器 只有注册过的控制器才能使用
    
    /// 注册路由控制器 只有注册过的控制器才能使用
    ///
    /// - Parameters:
    ///   - className: 类名
    ///   - host: 对应的路由host
    /// - Returns: 是否成功
    @discardableResult
    class func registeRouter(className:String, host:String) -> Bool {
         if(className.length > 0 && host.length > 0)
         {
            let router = KATRouter.shareRouter;
            if(router.classNameMap[host] == nil){ /// 没有注册过
                router.classNameMap[host] = className;
            }
            
            return true;
        }
        return false;
    }
    
    class func registerRouter(cls:AnyClass, host:String) -> Bool {
        if(host.length > 0){
             let router = KATRouter.shareRouter;
            if(router.classNameMap[host] == nil){ /// 没有注册过
             registeRouter(className:cls.description().components(separatedBy: ".")[1], host: host);
                return true;
            }
        }
        
        return false;
    }
    
    
    @discardableResult
    class func registeRouter(instance:UIViewController,host:String) -> Bool{
        if(host.length > 0){
            let router = KATRouter.shareRouter;
            if(router.classNameMap[host] == nil){ /// 没有注册过
                router.classNameMap[host] = instance.className;
                router.valueMap[host] = NSDictionary();
                router.instanceMap[host] = instance;
            }
        }
        
        return false;
    }
    
    class func removeRegistered(host:String) -> Bool{
        if(host.length > 0){
            
          let router = KATRouter.shareRouter;
            if let _ = router.classNameMap.removeValue(forKey: host){
                return false;
            }else{
        
            }
        }
        return false;
    }
    
    
    
    // MARK:路由跳转
    class func route(to uri:String){
        let router = KATRouter.shareRouter;
        if(router.routeWithURIAction != nil){
            
        }
        
        if(uri.length > 0){
            
        }
        
        
    }
    /// 内部判断是否可以跳转
    fileprivate class func _routingAvailable() -> Bool{
        
        
        
        
        return false;
    }
    /// 内部路由的跳转
    ///
    /// - Parameters:
    ///   - uri: uri
    ///   - selector: 方法
    ///   - obj: 对象
    ///   - addition: 添加
    ///   - forward: 向前
    ///   - handle: 回调
    fileprivate class func route(to uri:String, selector:Selector?, obj:Any?, addition:Any?, forward:Bool, handle:@escaping ()->(Void)){
         let router = KATRouter.shareRouter;
        /// 异步执行
        router.queueRouting.async {
             var waitDuration : Double = 0.0; ///等待时间
            
                while (waitDuration < router.routingWaitDuration){ ///
                    if(router.isDisabled){ /// 禁用跳转
                        return ;
                    }
                    
                    if(router.isWaitting){ ///暂停跳转 等待中
                        if(!forward){/// 回退
                            return ; /// 回退不等待
                        }
                    }else{
                        waitDuration += kROUTER_ROUTING_TEST_INTERVAL;
                    }
                    Thread.sleep(forTimeInterval: waitDuration);
                }
            
            if(KATRouter._routingAvailable()){/// 路由是否可用
                
                
            }
          
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
        
        
        
    }
    
}


// MARK:函数挂钩 Hook Appdelegate
extension KATRouter{
    //// 函数的挂钩
  fileprivate  class func hookAppDelegate(){
        

        /// app已经激活
        KATSwizzle.KATSwizzleMethod(originalCls: APPController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)), swizzledSelector: #selector(applicationDidBecomeActive(_:)));
        
        
      /// app 进入后台
         KATSwizzle.KATSwizzleMethod(originalCls: APPController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)), swizzledSelector: #selector(applicationDidEnterBackground(_:)));
    
     /// app 进入前台
         KATSwizzle.KATSwizzleMethod(originalCls: APPController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIApplicationDelegate.applicationWillEnterForeground(_:)), swizzledSelector: #selector(applicationWillEnterForeground(_:)));
    
    /// app 进入失活状态
            KATSwizzle.KATSwizzleMethod(originalCls: APPController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), swizzledSelector: #selector(applicationWillResignActive(_:)));
    
    
    /// app 即将推出
        KATSwizzle.KATSwizzleMethod(originalCls: APPController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIApplicationDelegate.applicationWillTerminate(_:)), swizzledSelector: #selector(applicationWillTerminate(_:)));
    
    
    
    /// Present 视图

    
    /// mark:此处其实没有必要做真正的替换
//      KATSwizzle.KATSwizzleMethod(originalCls: UIViewController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIViewController.present(_:animated:completion:)), swizzledSelector: #selector(present(_:animated:completion:)));
    hookPresentVC();
   

    
    /// Dismiss 视图
    
//     KATRouter.shareRouter._dissmissViewController = class_getMethodImplementation(UIViewController.self, #selector(UIViewController.dismiss(animated:completion:)));
    
//     KATSwizzle.KATSwizzleMethod(originalCls: UIViewController.self, swizzleCls: KATRouter.self, originalSelector: #selector(UIViewController.dismiss(animated:completion:)), swizzledSelector: #selector(KATRouter.dismiss(animated:completion:)));
    hookDissVC();
    
   
    
    
    }
    
    
    /// 大量的@objc 会增加二进制文件的大小
    // MARK:app  已经变为激活状态
    @objc func applicationDidBecomeActive(_ application: UIApplication) {
        
        debugPrint("应用已经变为激活状态");
        
    }
    
     // MARK:app  已经进入后台
   @objc  func applicationDidEnterBackground(_ application: UIApplication) {
    
    debugPrint("应用已经进入后台");
    
    }
    
    // MARK:app  已经进入前台
   @objc func applicationWillEnterForeground(_ application: UIApplication) {
    
    debugPrint("应用即将进入前台");
    
    }
    
    
   // MARK: APP 已经失活
   @objc func applicationWillResignActive(_ application: UIApplication) {

    debugPrint("应用即将失活");
    }
    
    // MARK: app 即将退出
   @objc func applicationWillTerminate(_ application: UIApplication) {
    debugPrint("应用即将退出");
    }
    
}

// MARK:视图跳转控制
extension KATRouter {
    
    /// hook  present函数
  class  func hookPresentVC(){
        let originSelector =  #selector(UIViewController.present(_:animated:completion:))
        
        let originMethod = class_getInstanceMethod(UIViewController.self, originSelector)
        
        let originalIMP = unsafeBitCast(method_getImplementation(originMethod!), to: PresentType.self);
        
        let newFunc:@convention(block) (UIViewController,UIViewController,Bool,BlockVoidToVoid?)->(Void) = {
            (fromvc,tovc,flag,completion) in
            
            debugPrint("开始调用--present-----");
            debugPrint("fromvc: \(fromvc) \n tovc: \(tovc)")
            originalIMP(fromvc, originSelector, tovc, flag, completion);
            
             debugPrint("结束调用--present------");
            debugPrint("结束调用--present---%@---",KATAppUtil.topViewController());
            
        };
        
        
        let imp = imp_implementationWithBlock(unsafeBitCast(newFunc, to: AnyObject.self))
        
        method_setImplementation(originMethod!, imp)
    
        
    }
    
    /// hook dismiss函数
   class func hookDissVC(){
        
    let originSelector =  #selector(UIViewController.dismiss(animated:completion:))
    let originMethod = class_getInstanceMethod(UIViewController.self, originSelector)
//
    let originalIMP = unsafeBitCast(method_getImplementation(originMethod!), to: DismissType.self);

    let newFunc:@convention(block) (UIViewController, Bool,BlockVoidToVoid?)->(Void) = {
        (tovc,flag,completion) in

        debugPrint("开始调用--dismiss---%@----%d----%@-",tovc,flag);

        originalIMP(tovc,originSelector,flag,completion);


        debugPrint("结束调用--dismiss---%@---",KATAppUtil.topViewController());

    };

    let imp = imp_implementationWithBlock(unsafeBitCast(newFunc, to: AnyObject.self))
    method_setImplementation(originMethod!, imp)
    
    
 
    
    
    }
    
    
}



