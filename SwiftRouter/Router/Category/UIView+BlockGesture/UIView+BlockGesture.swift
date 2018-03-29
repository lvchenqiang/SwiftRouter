//
//  UIView+BlockGesture.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/29.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

/// 事件回调
typealias GestureActionBlock = (UIGestureRecognizer) -> (Void)

extension UIView
{
    private struct AssociatedKeys {
        static var kActionHandlerTapBlockKey = "kActionHandlerTapBlockKey"
        static var kActionHandlerTapGestureKey = "kActionHandlerTapGestureKey"
        static var kActionHandlerLongPressBlockKey  = "kActionHandlerLongPressBlockKey"
        static var kActionHandlerLongPressGestureKey = "kActionHandlerLongPressGestureKey"
    }
    
    /// 添加单击手势事件的回调
    ///
    /// - Parameter block: 闭包回调
    func addTapAction(block:@escaping GestureActionBlock){
        var gesture = objc_getAssociatedObject(self, &AssociatedKeys.kActionHandlerTapGestureKey) as? UITapGestureRecognizer;
        if(gesture == nil){
            gesture = UITapGestureRecognizer(target: self, action: #selector(handleActionForTapGesture(gesture:))) ;
            self.addGestureRecognizer(gesture!);
            objc_setAssociatedObject(self, &AssociatedKeys.kActionHandlerTapGestureKey, gesture, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        objc_setAssociatedObject(self, &AssociatedKeys.kActionHandlerTapBlockKey, block, .OBJC_ASSOCIATION_COPY);
    }
    
    @objc func handleActionForTapGesture(gesture:UITapGestureRecognizer){
        if(gesture.state == .recognized){
            let block = objc_getAssociatedObject(self, &AssociatedKeys.kActionHandlerTapBlockKey) as? GestureActionBlock;
            if(block != nil){
                UIApplication.shared.keyWindow?.endEditing(true);
                block!(gesture);
            }
        }
    }
    
    
    /// 添加长按手势事件的回调
    ///
    /// - Parameter block: 闭包回调
    func addLongPressAction(block:@escaping GestureActionBlock){
        
        var gesture = objc_getAssociatedObject(self, &AssociatedKeys.kActionHandlerLongPressGestureKey) as? UILongPressGestureRecognizer;
        gesture?.minimumPressDuration = 1.0;
        if(gesture == nil){
            gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleActionForLongPressGesture(gesture:)));
            self.addGestureRecognizer(gesture!);
            objc_setAssociatedObject(self, &AssociatedKeys.kActionHandlerLongPressGestureKey, gesture, .OBJC_ASSOCIATION_RETAIN);
        }
        
        objc_setAssociatedObject(self, &AssociatedKeys.kActionHandlerLongPressBlockKey, block, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        
    }
    
    @objc func handleActionForLongPressGesture(gesture:UILongPressGestureRecognizer){
        if(gesture.state == .began){
            let block = objc_getAssociatedObject(self, &AssociatedKeys.kActionHandlerLongPressBlockKey) as? GestureActionBlock;
            if(block != nil){
                UIApplication.shared.keyWindow?.endEditing(true);
                block!(gesture);
            }
        }
    }
    
}
