//
//  String+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension String{
    // 拼音
    var pinyin:String{
        get{
            let str = NSMutableString(string: self)
            CFStringTransform(str as CFMutableString, nil, kCFStringTransformMandarinLatin, false)
            CFStringTransform(str as CFMutableString, nil, kCFStringTransformStripDiacritics, false)
            
            return str.replacingOccurrences(of: " ", with: "")
            
        }
    }
    
    //返回字符串的长度
    var length:NSInteger{
        get{
            return self.count;
        }
    }
    
 
    /// 返回文本的高度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 宽度
    /// - Returns: 高度
    func textHeight(font:UIFont,width:CGFloat)->CGFloat{
        
        let height =   self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options:  NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesDeviceMetrics.rawValue |   NSStringDrawingOptions.usesFontLeading.rawValue |    NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.truncatesLastVisibleLine.rawValue
        ), attributes: [NSAttributedStringKey.font:font], context: nil).size.height;
        return height;
    }
    
    /// 返回文本的宽度
    ///
    /// - Parameters:
    ///   - font: 字体
    ///   - height: 高度
    /// - Returns: 宽度
    func textWidth(font:UIFont,height:CGFloat)->CGFloat{
        
        let width =   self.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: NSStringDrawingOptions(rawValue:  NSStringDrawingOptions.usesFontLeading.rawValue |    NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.truncatesLastVisibleLine.rawValue)
            , attributes: [NSAttributedStringKey.font:font], context: nil).size.width;
        return width;
    }
    
    
}



// MARK:app相关路径
extension String{
    static var homePath:String {
        get{
            return NSHomeDirectory();
        }
    }
    
    static var documentPath:String {
        get{
            return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        }
    }
    
    
}
