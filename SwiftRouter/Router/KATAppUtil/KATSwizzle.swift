//
//  KATSwizzle.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

class KATSwizzle : NSObject {
    
    
   /// 同对象方法的交换
   ///
   /// - Parameters:
   ///   - cls: 类
   ///   - originalSelector: 原始方法
   ///   - swizzledSelector: 交换的方法
   class func KATSwizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        
    KATSwizzleMethod(originalCls:cls, swizzleCls:cls, originalSelector: originalSelector, swizzledSelector: swizzledSelector);
    
    }
    
    
    
    /// 不同对象的方法的交换
    ///
    /// - Parameters:
    ///   - originalCls: 原始类
    ///   - swizzleCls: 交换类
    ///   - originalSelector: 原始方法
    ///   - swizzledSelector: 交换方法
    class func KATSwizzleMethod(originalCls:AnyClass, swizzleCls: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        
        let originalMethod = class_getInstanceMethod(originalCls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(swizzleCls, swizzledSelector)
        
        let didAddMethod = class_addMethod(swizzleCls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod!),
                                           method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(originalCls,
                                originalSelector,
                                method_getImplementation(swizzledMethod!),
                                method_getTypeEncoding(swizzledMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
        
    }
    
    
    /// hook传入的函数 并自定义回调
    ///
    /// - Parameters:
    ///   - originalCls: 类对象
    ///   - selector: 需要被hook的函数
    ///   - callback: 回调函数
    class func hookFunc<T>(originalCls:AnyClass, selector: Selector, callback:T){
        
        
     
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
