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
    
}
