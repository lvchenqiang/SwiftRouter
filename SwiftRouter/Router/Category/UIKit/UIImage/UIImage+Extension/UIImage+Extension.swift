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
        viewOrientation = "Portrait"
        let imagesDictionary = Bundle.main.infoDictionary!["UILaunchImages"]
        if let imagesD = imagesDictionary {
        
            for dic:Dictionary<String,String> in imagesD as! Array{
                let imageSize = CGSizeFromString(dic["UILaunchImageSize"]!);
           
                if (imageSize.equalTo(viewSize) || imageSize.equalTo(CGSize(width: viewSize.height, height: viewSize.width))) && viewOrientation == dic["UILaunchImageOrientation"] {
                    LLog(UIImage(named:dic["UILaunchImageName"]!));
                    _lauchImage = UIImage(named:dic["UILaunchImageName"]!);
                    break;
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
    
    
    /// EZSE: Returns base64 string
    public var base64: String {
        return UIImageJPEGRepresentation(self, 1.0)!.base64EncodedString()
    }
    
    /// EZSE: Returns compressed image to rate from 0 to 1
    public func compressImage(rate: CGFloat) -> Data? {
        return UIImageJPEGRepresentation(self, rate)
    }
    
    /// EZSE: Returns Image size in Bytes
    public func getSizeAsBytes() -> Int {
        return UIImageJPEGRepresentation(self, 1)?.count ?? 0
    }
    
    /// EZSE: Returns Image size in Kylobites
    public func getSizeAsKilobytes() -> Int {
        let sizeAsBytes = getSizeAsBytes()
        return sizeAsBytes != 0 ? sizeAsBytes / 1024 : 0
    }
    
    /// EZSE: scales image
    public class func scaleTo(image: UIImage, w: CGFloat, h: CGFloat) -> UIImage {
        let newSize = CGSize(width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// EZSE Returns resized image with width. Might return low quality
    public func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))
        
        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    /// EZSE Returns resized image with height. Might return low quality
    public func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)
        
        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    /// EZSE:
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    /// EZSE:
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    
    /// EZSE: Returns cropped image from CGRect
    public func croppedImage(_ bound: CGRect) -> UIImage? {
        guard self.size.width > bound.origin.x else {
            print("EZSE: Your cropping X coordinate is larger than the image width")
            return nil
        }
        guard self.size.height > bound.origin.y else {
            print("EZSE: Your cropping Y coordinate is larger than the image height")
            return nil
        }
        let scaledBounds: CGRect = CGRect(x: bound.origin.x * self.scale, y: bound.origin.y * self.scale, width: bound.width * self.scale, height: bound.height * self.scale)
        let imageRef = self.cgImage?.cropping(to: scaledBounds)
        let croppedImage: UIImage = UIImage(cgImage: imageRef!, scale: self.scale, orientation: UIImageOrientation.up)
        return croppedImage
    }
    
    /// EZSE: Use current image for pattern of color
    public func withColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}
