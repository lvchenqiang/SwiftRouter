//
//  UIImage+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    
    // MARK:获取启动图
    
    /// 获取启动图
    ///
    /// - Returns: 启动图片
    class func launchImage() -> UIImage {

        var _lauchImage:UIImage!
        let viewSize = UIScreen.main.bounds.size
        let orientation = UIApplication.shared.statusBarOrientation
        var viewOrientation:String = ""
        if(orientation == .landscapeLeft || orientation == .landscapeRight){
            viewOrientation = "Landscape"
        }else{
            viewOrientation = "Portrait"
        }
        let imagesDictionary = Bundle.main.infoDictionary!["UILaunchImages"]
        if let imagesD = imagesDictionary {
            
            for dic:Dictionary<String,String> in imagesD as! Array{
                let imageSize = CGSizeFromString(dic["UILaunchImageSize"]!);
                if imageSize.equalTo(viewSize) && viewOrientation == dic["UILaunchImageOrientation"] {
                    _lauchImage = UIImage(named:dic["UILaunchImageName"]!);
                }
            }
            
        }else{
            _lauchImage =  UIImage.createImage(color: UIColor.white, size: viewSize);
        }
        
        return _lauchImage;

    }
    
    // MARK:
    ///  根据颜色生成指定大小的图片
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    class func  createImage(color:UIColor,size:CGSize) -> UIImage{
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image!
    }
    
    // MARK:获取圆形图片
    /// 获取圆形图片
    ///
    /// - Returns: 处理后的图片
    func circleImage() -> UIImage{
       
        ///  开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        
        ///  获得图形的上下文
        let ctx = UIGraphicsGetCurrentContext();
        
        /// 设置一个范围
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        /// 根据一个rect创建一个椭圆
        ctx?.addEllipse(in: rect);
        
        /// 裁剪
        ctx?.clip();
        
        /// 将原照片画到图形上下文
        self.draw(in: rect);
        
        /// 从上下文 获取裁后的照片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        /// 关闭上下文
        UIGraphicsEndImageContext();
        
        return newImage!
    }
    
    
    
    
    
}
