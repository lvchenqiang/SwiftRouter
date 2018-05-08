//
//  UIView+Animation.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


protocol Shakeable:NSObjectProtocol {
    
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5


extension Shakeable where Self: UIView{
    
    //MARK:-移除所有的子视图
    func removeSubviews(){
        let _ =  self.subviews.map {
            $0.removeFromSuperview()
        }
    }
    
    //MARK:-缩放效果
    func scaleAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.1, 0.9, 1.1]
        animation.duration = 0.3
        animation.calculationMode = kCAAnimationCubic
        self.layer.add(animation, forKey: nil)
    }
    
    
    //MARK:-摇晃效果
    func shakeAnimation(){
        let shakeAnim =  CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnim.duration = 0.3
        shakeAnim.values = [0,15,-15,0];
        shakeAnim.repeatCount = 2;
        self.layer.add(shakeAnim, forKey: nil)
    }
    
    
    /**
     依照图片轮廓对控制进行裁剪
     
     - parameter stretchImage:  模子图片
     - parameter stretchInsets: 模子图片的拉伸区域
     */
    func clipShape(stretchImage: UIImage, stretchInsets: UIEdgeInsets) {
        // 绘制 imageView 的 bubble layer
        let bubbleMaskImage = stretchImage.resizableImage(withCapInsets: stretchInsets, resizingMode: .stretch)
        
        // 设置图片的mask layer
        let layer = CALayer()
        layer.contents = bubbleMaskImage.cgImage
        //  layer.contentsCenter = self.CGRectCenterRectForResizableImage(bubbleMaskImage)
        layer.frame = self.bounds
        layer.contentsScale = UIScreen.main.scale
        layer.opacity = 1
        self.layer.mask = layer
        self.layer.masksToBounds = true
    }
    
    
    /// EZSwiftExtensions
    internal func spring(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    /// EZSwiftExtensions
    internal func spring(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    
    /// EZSwiftExtensions
    internal func animate(duration: TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
    
    /// EZSwiftExtensions
    internal func animate(animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        animate(duration: UIViewAnimationDuration, animations: animations, completion: completion)
    }
    
    /// EZSwiftExtensions
    internal func pop() {
        setScale(x: 1.1, y: 1.1)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    
    /// EZSwiftExtensions
    internal func popBig() {
        setScale(x: 1.25, y: 1.25)
        spring(duration: 0.2, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
        })
    }
    
    //EZSE: Reverse pop, good for button animations
    internal func reversePop() {
        setScale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: UIViewAnimationOptions.allowUserInteraction, animations: { [weak self]  in
            self?.setScale(x: 1, y: 1)
        })
    }
}
