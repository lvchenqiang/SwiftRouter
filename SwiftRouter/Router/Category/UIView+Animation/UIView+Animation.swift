//
//  UIView+Animation.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
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
    
}
