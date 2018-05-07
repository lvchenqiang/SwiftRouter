//
//  UIViewController+SlideHandle.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController{
    
    private struct AssociatedKeys{
         static var kAllowSlideKey = "kAllowSlideKey"
         static var kPanGestureRecognizerKey = "kPanGestureRecognizerKey"
         static var kSlideStartXPointKey = "kSlideStartXPointKey"
         static var kIsSlidingKey = "kIsSlidingKey"
         static var kSlideFinishProgressKey = "kSlideFinishProgressKey"
         static var kSlideDistancekey = "kSlideDistancekey"
         static var  kSlideBackgroundViewKey = "kSlideBackgroundViewKey"
    }
    /// 滑动手势
    fileprivate var panGR:UIPanGestureRecognizer? {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kPanGestureRecognizerKey) as? UIPanGestureRecognizer;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kPanGestureRecognizerKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    /// 是否允许滑动
    var allowSlide:Bool {
        get
        {
            return objc_getAssociatedObject(self, &AssociatedKeys.kAllowSlideKey) as? Bool ?? false;
        }
        set
        {
           objc_setAssociatedObject(self, &AssociatedKeys.kAllowSlideKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            if(newValue){
                self.addSlidePanGesture()
            }else{
                self.removeSlidePanGesture();
            }
        }
    }
    /// 允许滑动的开始范围
    var slideStartXPoint:CGFloat {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kSlideStartXPointKey) as? CGFloat ?? (self.view.bounds.size.width*0.5);
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kSlideStartXPointKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
    }
    /// 滑动是否成功的触发临界值  默认 半屏
    var slideFinishProgress:CGFloat {
        get{
          return objc_getAssociatedObject(self, &AssociatedKeys.kSlideFinishProgressKey) as? CGFloat ?? (100)
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kSlideFinishProgressKey, newValue, .OBJC_ASSOCIATION_COPY);
        }
    }
    /// 私有属性  允许触发的滑动事件
    fileprivate var isSliding:Bool {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kIsSlidingKey) as? Bool ?? false;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kIsSlidingKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    /// 滚动的距离
    fileprivate var slideDistance:CGFloat {
        get{
            return (objc_getAssociatedObject(self, &AssociatedKeys.kSlideDistancekey) as? CGFloat) ?? 0.0;
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kSlideDistancekey, newValue, .OBJC_ASSOCIATION_COPY);
        }
    }
    
    /// 滑动的前景图
    fileprivate var slideForegroundView:UIView {
        get{
          return self.view.snapshot()
        }
    }
    
    
    var slideBackgroundView:UIView {
        get{
            return objc_getAssociatedObject(self, &AssociatedKeys.kSlideBackgroundViewKey) as? UIView ?? self.view.snapshot();
        }
        set{
            objc_setAssociatedObject(self, &AssociatedKeys.kSlideBackgroundViewKey, newValue, .OBJC_ASSOCIATION_RETAIN);
        }
    }
}

extension UIViewController{
    fileprivate func addSlidePanGesture(){
        if(self.panGR == nil){
            let pan = UIPanGestureRecognizer(target: self, action: #selector(slideHandle(pan:)));
            self.panGR = pan;
            self.view.addGestureRecognizer(pan);
            
        }
        
        
        
    }
    
   fileprivate func removeSlidePanGesture(){
        if let pan = self.panGR{
            self.view.removeGestureRecognizer(pan);
        }
        
    }
    
    @objc fileprivate func slideHandle(pan:UIPanGestureRecognizer){
        if(!self.allowSlide){  /// 禁止滑动
            return;
        }
        switch pan.state {
        case .began:/// 滑动开始
            let location = pan.location(in: pan.view);
            if(location.x >= 0 && location.x <= self.slideStartXPoint){ /// 允许滑动的范围
               self.slideStart()
            }
            
            break
        case .changed:/// 滑动中
            if(self.isSliding){
                let location = pan.location(in: pan.view);
                let distance = location.x;
                self.slideWithDistance(distance: distance);
            }
            
            break;
        case .cancelled,.ended,.failed:/// 事件结束
            if(self.isSliding){
                LLog(self.slideDistance)
                LLog(self.slideFinishProgress)
                
                if(self.slideFinishProgress <= (self.view.center.x - kScreenW/2.0)){
                    self.slideFinish();
                }else{
                    self.slideCancel();
                }
            }
            break;
        default:
            break;
        }
        
        
        
    }
    
    /// 滑动开始事件
    fileprivate func slideStart(){
        self.isSliding = true;
  
        self.slideForegroundView.backgroundColor = .red;
        self.view.addSubview(self.slideBackgroundView);
        self.view.addSubview(self.slideForegroundView);
        
    }
    
    /// 滑动持续事件
    fileprivate func slideWithDistance(distance:CGFloat){
        if(self.isSliding){ /// 滑动中
            self.slideDistance = distance;
            if(self.slideDistance > 0){
                self.slideForegroundView.center.x += self.slideDistance * 0.8;
                LLog(self.slideDistance);
            }
        }
    }
    
    /// 滑动结束事件
    fileprivate func slideFinish(){
       
        self.restoreSlide()
        self.dismiss(animated: false, completion: nil);
    }
    
    /// 滑动取消事件
    fileprivate func slideCancel(){
        
        self.view.center.x = self.view.bounds.width/2.0;
        self.restoreSlide()
        
    }
 
    fileprivate func restoreSlide(){
        self.isSliding = false;
        self.slideDistance = 0.0;
        
    }
    
    
}
