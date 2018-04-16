//
//  KATMath.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/16.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

class KATMath: NSObject {
    
    
    /// 获取矩形的周长
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - height: 长度
    /// - Returns: 矩形周长
    class func perimeterOfRect(width:CGFloat, height:CGFloat) -> CGFloat {
        return 2*(width+height);
    }
    
    
    /// 获取矩形的面积
    ///
    /// - Parameters:
    ///   - width: 宽度
    ///   - height: 高度
    /// - Returns: 获取矩形的面积
    class func areaOfRect(width:CGFloat, height:CGFloat) -> CGFloat{
        return width * height;
    }
    
    

    /// 获取三角形的周长
    ///
    /// - Parameters:
    ///   - lenthA: 边长a
    ///   - lenthB: 边长b
    ///   - lenthC: 边长c
    /// - Returns: 边长
    class func perimeterOfTriangle(lenthA:CGFloat, lenthB:CGFloat, lenthC:CGFloat) -> CGFloat{
        return lenthA+lenthB+lenthC;
    }
    
    
    /// 获取三角形的面积
    ///
    /// - Parameters:
    ///   - lenthA: 边长a
    ///   - lenthB: 边长b
    ///   - lenthC: 边长c
    /// - Returns: 三角形面积
    class func areaOfTriangle(lenthA:CGFloat, lenthB:CGFloat, lenthC:CGFloat) -> CGFloat{
        let p = (lenthA+lenthB+lenthC)/2.0
        return sqrt(p*(p-lenthA)*(p-lenthB)*(p-lenthC))
    }
    
    
    /// 获取三角形的面积
    ///
    /// - Parameters:
    ///   - width: 三角形宽
    ///   - height: 三角形高
    /// - Returns: 三角形面积
    class func areaOfTriangle(width:CGFloat, height:CGFloat) -> CGFloat{
        return (width * height)/2.0
    }
    
    
    /// 获取圆形的周长
    ///
    /// - Parameter radius: 半径
    /// - Returns: 圆形的周长
    class func perimeterOfCircle(radius:CGFloat) ->CGFloat{
        return CGFloat.pi * 2 * radius;
    }
    
    
    /// 获取圆形的面积
    class func areaOfCircle(radius:CGFloat) ->CGFloat {
        return CGFloat.pi * radius * radius;
    }
    
    /// 计算两点间的距离
    class func distance(pointA:CGPoint, pointB:CGPoint) -> CGFloat{
        return sqrt(pow((pointA.x - pointB.x), 2) + pow((pointA.y - pointB.y), 2))
    }
    
    /// 已知三角形三边 计算sideA对应的夹角
    class func angleAOfTriangle(sideA:CGFloat, sideB:CGFloat, sideC:CGFloat) -> CGFloat {
        return acos((pow(sideB, 2) + pow(sideC, 2) - pow(sideA, 2)) / (2*sideB*sideC))
    }
    
    
    
    
    
    
    
    
    
    
}
