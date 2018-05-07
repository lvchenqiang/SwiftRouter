//
//  UIScrollView+Slide.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/7.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView:UIGestureRecognizerDelegate
{
    // MARK:此方法返回YES时，手势事件会一直往下传递，不论当前层次是否对该事件进行响应。
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    
        return self.panBack(gestureRecognizer: gestureRecognizer);
    }

    // MARK:location_X可自己定义，其代表的是滑动返回距左边的有效长度
    fileprivate func panBack(gestureRecognizer:UIGestureRecognizer) -> Bool{
        let location_X:CGFloat = 50.0;
        if(gestureRecognizer == self.panGestureRecognizer){
            
            let point:CGPoint = gestureRecognizer.location(in: self);
            if(gestureRecognizer.state == .began || gestureRecognizer.state == .possible){
                if(location_X >= point.x && point.x >= 0 ) {
                    return true;
                }
            }
            
        }
        return false;
    }

    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !self.panBack(gestureRecognizer: gestureRecognizer);
    }
}
