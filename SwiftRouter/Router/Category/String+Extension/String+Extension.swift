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


extension String{
    
    var currentClass:AnyClass? {
        get{
          
            if  let appName: String = Bundle.main.infoDictionary!["CFBundleName"] as? String{
                return NSClassFromString("\(appName).\(self)")
            }
            return nil;
        }
        
    }
    
    var selector:Selector {
        get {
            return Selector(self);
        }
    }
    
}



// MARK:搜索str所有所在位置的集合
extension String {
    
        func indexesOf(pattern: String) -> [Int]? {
            let patternLength: Int = pattern.length
            /* Let's calculate the Z-Algorithm on the concatenation of pattern and text */
            let zeta = ZetaAlgorithm(ptrn: pattern + "💲" + self)
            
            guard zeta != nil else {
                return nil
            }
            
            var indexes: [Int] = [Int]()
            
            /* Scan the zeta array to find matched patterns */
            for i in 0 ..< zeta!.count {
                if zeta![i] == patternLength {
                    indexes.append(i - patternLength - 1)
                }
            }
            
            guard !indexes.isEmpty else {
                return nil
            }
            
            return indexes
        }
}



func ZetaAlgorithm(ptrn: String) -> [Int]? {
    
    let pattern = Array(ptrn.characters)
    let patternLength: Int = pattern.count
    
    guard patternLength > 0 else {
        return nil
    }
    
    var zeta: [Int] = [Int](repeating: 0, count: patternLength)
    
    var left: Int = 0
    var right: Int = 0
    var k_1: Int = 0
    var betaLength: Int = 0
    var textIndex: Int = 0
    var patternIndex: Int = 0
    
    for k in 1 ..< patternLength {
        if k > right {  // Outside a Z-box: compare the characters until mismatch
            patternIndex = 0
            
            while k + patternIndex < patternLength  &&
                pattern[k + patternIndex] == pattern[patternIndex] {
                    patternIndex = patternIndex + 1
            }
            
            zeta[k] = patternIndex
            
            if zeta[k] > 0 {
                left = k
                right = k + zeta[k] - 1
            }
        } else {  // Inside a Z-box
            k_1 = k - left + 1
            betaLength = right - k + 1
            
            if zeta[k_1 - 1] < betaLength { // Entirely inside a Z-box: we can use the values computed before
                zeta[k] = zeta[k_1 - 1]
            } else if zeta[k_1 - 1] >= betaLength { // Not entirely inside a Z-box: we must proceed with comparisons too
                textIndex = betaLength
                patternIndex = right + 1
                
                while patternIndex < patternLength && pattern[textIndex] == pattern[patternIndex] {
                    textIndex = textIndex + 1
                    patternIndex = patternIndex + 1
                }
                
                zeta[k] = patternIndex - k
                left = k
                right = patternIndex - 1
            }
        }
    }
    return zeta
}
