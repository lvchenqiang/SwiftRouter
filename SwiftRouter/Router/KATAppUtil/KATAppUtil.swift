//
//  KATAppUtil.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

class KATAppUtil: NSObject {
   
    
    /// 获取屏幕的方向
    class func currentOrientation() -> UIDeviceOrientation{
        return UIDevice.current.orientation;
    }
    
    /// 切换屏幕的方向

    
    
    /// 设置自动锁屏
    class func setAutoLockScreen(_ disabled:Bool = false){
        UIApplication.shared.isIdleTimerDisabled = disabled;
    }
    
    ///获取view所在的视图控制器
    class func controllerWithView(view:UIView) -> UIViewController? {
        while view.superview != nil {
            
            if let nextResponder = view.next{
                if  nextResponder.isKind(of: UIViewController.self){
                    return nextResponder as? UIViewController;
                }
            }
        }
      return nil
    }
 
    // MARK: 获取当前的最顶层的controller
    class func topViewController() -> UIViewController{
        
        /// 获取视图的控制器
        var topVC:UIViewController!
        
        topVC = _topViewController(vc: (UIApplication.shared.keyWindow?.rootViewController)!);
        
        while topVC.presentedViewController != nil {
            topVC = _topViewController(vc: topVC.presentedViewController!);
        }
        
        return topVC;
    }
    /// 寻找顶层的VC
    fileprivate  class func _topViewController(vc:UIViewController) -> UIViewController{
        if(vc.isKind(of: UINavigationController.self)){ // 导航视图的控制器
            return self._topViewController(vc:(vc as! UINavigationController).topViewController!)
        }else if(vc.isKind(of: UITabBarController.self)){/// tabbar视图控制器
            return _topViewController(vc:(vc as! UITabBarController).selectedViewController!);
        }else{
            return vc;
        }
    }
    


    
    
    
    
}