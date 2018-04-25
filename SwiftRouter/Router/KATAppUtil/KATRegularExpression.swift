//
//  KATRegularExpression.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/17.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit
//URI例: https://kat@kantice.com:80/path?id=1&name=k&age=3#frag
//       scheme://user@host:80/path?query#fragment

/*
 正则表达式在线评测
 http://tool.oschina.net/regex/?optionGlobl=global
 */

class KATRegularExpression: NSObject {
    /*
     
     caseInsensitive                    不区分大小写的
     
     allowCommentsAndWhitespace         忽略空格和# -
     
     ignoreMetacharacters:              整体化
     
     dotMatchesLineSeparators:          匹配任何字符，包括行分隔符
     
     anchorsMatchLines:                 允许^和$在匹配的开始和结束行
     
     useUnixLineSeparators:             (查找范围为整个的话无效)
     
     useUnicodeWordBoundaries:           (查找范围为整个的话无效)
     
     */
    /// 协议类型
    static fileprivate let KProtocolNameExpression = "(.*?)://"
    /// 域名
    static fileprivate let KHostNameExpression = "://(.*?):|://(.*?)/"
    /// 限制端口号 最多四位数字
    static fileprivate let KPortExpression = ":\\d{1,4}"
    /// 匹配url里面的参数
    static fileprivate let KParamsExpressionAll = "\\?[0-9a-zA-Z&=]*"
    
    
    /// 多匹配 获取结果
   fileprivate class func matchesRegularExpression(pattern:String,sourceText:String) -> [String]{
        var arr = [String]()
        let regularEx  =  try? NSRegularExpression(pattern: pattern, options: .caseInsensitive);
    
        if let regularEx = regularEx{
          let matchResult = regularEx.matches(in: sourceText, options: .reportProgress, range: NSRange(location: 0, length: sourceText.length))
            for result in matchResult{
                arr.append(sourceText.sliceString(result.range.location..<(result.range.location + result.range.length)));
            }
        }
        return arr;
    }
    
    /// 多匹配 返回对应的位置信息
    fileprivate class func matchesNSRangeRegularExpression(pattern:String,sourceText:String) -> [NSRange] {
         var arr = [NSRange]()
        let regularEx  =  try? NSRegularExpression(pattern: pattern, options: .caseInsensitive);
        
        if let regularEx = regularEx{
            let matchResult = regularEx.matches(in: sourceText, options: .reportProgress, range: NSRange(location: 0, length: sourceText.length))
            for result in matchResult{
               arr.append(result.range)
            }
        }
        return arr;
    }
    
    
    
    ///  返回唯一匹配的结果
    fileprivate class func firstMatchRegularExpression(pattern:String,sourceText:String) -> String {
        var result = "";
        let regularEx  =  try? NSRegularExpression(pattern: pattern, options: .caseInsensitive);
        if let regularEx = regularEx{
        let matchResult = regularEx.firstMatch(in: sourceText, options: .reportProgress, range: NSRange(location: 0, length: sourceText.length));
         if let matchResult = matchResult{
            result = sourceText.sliceString(matchResult.range.location..<(matchResult.range.location + matchResult.range.length))
         }
        }
        return result
    }
    
    /// 返回符合匹配的结果的个数
    fileprivate class func numberOfMatchesRegularExpression(pattern:String,sourceText:String) -> Int{
        var num = 0;
        let regularEx  =  try? NSRegularExpression(pattern: pattern, options: .caseInsensitive);
        if let regularEx = regularEx{
          num =  regularEx.numberOfMatches(in: sourceText, options: .reportProgress, range: NSRange(location: 0, length: sourceText.length))
        }
        return num;
    }
}


extension KATRegularExpression{
   
    // MARK:获取url的协议名
    class func regularExpressionProtocolName(sourceText:String) -> [String]{
        return matchesRegularExpression(pattern: KProtocolNameExpression, sourceText: sourceText).compactMap({ (index) -> String in
              return index.replacingOccurrences(of: "://", with: "");
        })
    }
    // MARK:获取url的域名
    class func regularExpressionHostName(sourceText:String) -> [String]{
        return matchesRegularExpression(pattern: KHostNameExpression, sourceText: sourceText).compactMap({ (index) -> String in
            return index.replacingOccurrences(of: "://", with: "").replacingOccurrences(of: ":", with: "").replacingOccurrences(of: "/", with: "")
        })
    }
    // MARK:获取url的端口号
    class func regularExpressionPort(sourceText:String) -> [String]{
        return matchesRegularExpression(pattern: KPortExpression, sourceText: sourceText).compactMap({ (index) -> String in
            return index.replacingOccurrences(of: ":", with: "");
        })
    }
    // MARK:返回url里面的参数
    class func regularExpressionParam(sourceText:String) ->[String:String]{
        var params = [String:String]()
        firstMatchRegularExpression(pattern: KParamsExpressionAll, sourceText: sourceText).replacingOccurrences(of: "?", with: "").split(separator: "&").forEach { (index) in
            let tmp =  index.split(separator: "=")
            if(tmp.count > 1){
               params[String(tmp[0])] = String(tmp[1])
            }
        }
        return params;
    }
    
    
    
    
}
