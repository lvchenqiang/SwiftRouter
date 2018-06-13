//
//  Timer+WeakProxy.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/14.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
public typealias TimerExcuteClosure = @convention(block) () -> ()

extension Timer
{
    private class TimerActionBlockWrapper : NSObject {
        var block : TimerExcuteClosure
        init(block: @escaping TimerExcuteClosure) {
            self.block = block
        }
    }
    public class func LYU_scheduledTimerWithTimeInterval(_ ti:TimeInterval, closure: @escaping TimerExcuteClosure, repeats: Bool) -> Timer {
        return self.scheduledTimer(timeInterval: ti, target: self, selector: #selector(Timer.excuteTimerClosure(_:)), userInfo: TimerActionBlockWrapper(block: closure), repeats: true)
    }
    
    @objc private class func excuteTimerClosure(_ timer: Timer) {
        if let action = timer.userInfo as? TimerActionBlockWrapper {
            action.block()
        }
    }

}
