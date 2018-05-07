//
//  UIViewController+Slide.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/7.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController:UIGestureRecognizerDelegate
{
   private struct AssociatedKeys {
    static var kFullScreenKey = "kFullScreenKey"
    }
    

    /// 是否开启全屏滑动 默认false
    var isFullScreenSlide:Bool {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kFullScreenKey) as? Bool ?? false;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kFullScreenKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            if(newValue){
                self.addFullScreenSlideGestureRecognizer(); /// 添加全屏右滑的手势
            }else{
                self.setEnableFullScreenSlideGestureRecognizer() ///取消全屏右滑的手势
            }
        }
    }
    
    
    // MARK:开启全屏滑动事件
    fileprivate func addFullScreenSlideGestureRecognizer(){
        
        DispatchQueue.once(token: "FullScreenSlide") {
            if let target = self.navigationController?.interactivePopGestureRecognizer?.delegate, let targetView = self.navigationController?.interactivePopGestureRecognizer?.view
            {
                let handler:Selector = "handleNavigationTransition:".toSelector;
                let fullScreenGes = UIPanGestureRecognizer(target: target, action: handler);
                fullScreenGes.delegate = self;
                targetView.addGestureRecognizer(fullScreenGes);
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false;
            }
        }
      
        self.setEnableFullScreenSlideGestureRecognizer(true);
        if let ges = self.navigationController?.interactivePopGestureRecognizer {
            ges.delegate = self;
        }
        
    }
    // MARK:取消全屏右滑事件
    fileprivate func setEnableFullScreenSlideGestureRecognizer(_ enable:Bool = false){
        LLog("手势是否可用\(enable)")
        if let gesArr = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers{
            for popGesture in gesArr{
                popGesture.isEnabled = enable;
            }
        }
      
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if let targetView = gestureRecognizer.view ,gestureRecognizer.location(in:targetView).x <= 0{
            return false;
        }
        if let arr = self.navigationController?.childViewControllers{
            if arr.count > 1{
                return true;
            }
        }
        return false;

    }
    
    
    
    
    
    
    
    
    
    
    
    
}
