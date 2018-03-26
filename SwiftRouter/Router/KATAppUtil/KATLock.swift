//
//  KATLock.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/26.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation


// MARK:锁机制
class KATLock: NSObject {
    
    /// synchronized锁  性能较差
    ///
    /// - Parameters:
    ///   - lock: 锁对象 实际上是把这个对象当做锁来使用。通过一个哈希表来实现的，OC 在底层使用了一个互斥锁的数组(你可以理解为锁池)，通过对对象去哈希值来得到对应的互斥锁。
    ///   - closure: 闭包
    ///
    class func synchronizedLock(lock: AnyObject, closure: () -> ()){
        objc_sync_enter(lock);
        closure();
        objc_sync_exit(lock);
    }
    
    
    
    
    
    
}
