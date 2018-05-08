//
//  DispatchQueue+Once.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/7.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
public extension DispatchQueue {
    
     private static var _onceTracker = [String]()
     private static var _ignoreTracker = [String]()
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:()->Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
    
    public class func ignore(FirstExecute token: String, block:()->Void){
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        if _ignoreTracker.contains(token){
            block();
        }else{
            _ignoreTracker.append(token)
        }

    }
    // MARK:- 延时调用
    public class func dispatch_after(_ delayInSeconds:Double,block:@escaping ()->()){
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds, execute:block);
    }
    
    /// EZSE: Submits a block for asynchronous execution on the main queue
    public static func runThisInMainThread(_ block: @escaping () -> Void) {
        DispatchQueue.main.async(execute: block)
    }
    
    /// EZSE: Runs in Default priority queue
    public static func runThisInBackground(_ block: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async(execute: block)
    }
    
    /// EZSE: Runs every second, to cancel use: timer.invalidate()
    @discardableResult public static func runThisEvery(
        seconds: TimeInterval,
        startAfterSeconds: TimeInterval,
        handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    
    
    
}
