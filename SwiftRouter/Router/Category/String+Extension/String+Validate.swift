//
//  String+Validate.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

/// 验证用户名
fileprivate let validUserName:String = "^[a-zA-Z]\\w{5,15}$"

/// 验证电话号码 eg：021-68686868  0511-6868686
fileprivate let kValid_Phone:String = "^([\\d{3,4}-)\\d{7,8}$]"

/// 验证手机号码
fileprivate let kValid_Mobile:String = "^1[3|4|5|7|8][0-9]\\d{8}$"

/// 验证身份证号码 15位或18位数字
fileprivate let kValid_Identity_Card = "\\d{14}[[0-9],0-9xX]"

/// 验证Email
fileprivate let kVaild_Email = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"

/// 验证只能输入由数字和26个英文字母组成的字符串
fileprivate let kValid_Number_Or_String = "^[A-Za-z0-9]+$"

/// 整数或者小数
fileprivate let kValid_DecimalsD = "^[0-9]+([.]{0,1}[0-9]+){0,1}$"

///只能输入数字
fileprivate let kValid_Number = "^[0-9]*$"

/// 只能输入n位数字
fileprivate let kValid_N_Number = "^\\d{n}$"

/// 只能输入至少n位数字
fileprivate let kValid_N_More_Number = "^\\d{n,}$"

/// 只能输入m-n位数字
fileprivate let kValid_M_N_Number = "^\\d{m,n}$"

/// 只能输入零和非零开头的数字
fileprivate let kValid_Zero_Number = "^(0|[1-9][0-9]*)$"

/// 只能输入有两位小数的正实数
fileprivate let kValid_Two_Decimal = "^[0-9]+(.[0-9]{2})?$"

/// 只能输入有1~3位小数的正实数
fileprivate let kValid_One_three_Decimal = "^[0-9]+(\\.[0-9]{1,3})?$"

/// 只能输入非零的正整数
fileprivate let kValid_NoZero_Integer = "^\\+?[1-9][0-9]*$"

/// 只能输入非零的负整数
fileprivate let kValid_Negative_Integer = "^\\-[1-9][]0-9″*$"

///只能输入长度为3的字符
fileprivate let kValid_Three_String = "^.{3}$"

/// 只能输入由26个英文字母组成的字符串
fileprivate let kValid_English_letters = "^[A-Za-z]+$"

/// 只能输入有26个大写英文字母组成的字符串
fileprivate let kValid_Uppercase_English_letters = "^[A-Z]+$"

/// 只能输入有26个小写英文字母组成的字符串
fileprivate let kValid_Lowercase_English_letters = "^[a-z]+$"

/// 验证是否含有 特殊字符 ^%&',;=?$
fileprivate let kValid_Special_Char = "[^%&',;=?$\\x22]+"


/// 只能输入汉字
fileprivate let kValid_Chinese_Characters = "^[\\u4e00-\\u9fa5]{0,}$"

///匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)
fileprivate let kValid_Account = "^[a-zA-Z][a-zA-Z0-9_]{4,15}$"

/// 匹配腾讯QQ号
fileprivate let kValid_QQ = "[1-9][0-9]\\{4,\\}"

/// 匹配中国邮政编码
fileprivate let kValid_Postal_Code = "[1-9]\\d{5}(?!\\d)"

/// 匹配ip地址
fileprivate let kValid_IP = "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)"

extension String{
  
    
    /// 手机号以13，14 , 15，17 ,18开头，八个 \d 数字字符
    var isValidateMobile:Bool{
        get{
            let phoneRegex = "^1[3|4|5|7|8][0-9]\\d{8}$";
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex);
            return phoneTest.evaluate(with:self)
        }
    }
    
        /// 验证邮箱是否合法
    var isValidateEmail:Bool{
        get{
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
            let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex);
            return emailTest.evaluate(with:self)
        }
    }
    
     /// 验证是否是纯数字
    var isAllNumber:Bool{
        let numRegex = "^[0-9]*$";
        let numTest = NSPredicate(format: "SELF MATCHES %@", numRegex);
        return numTest.evaluate(with:self)
    }
    
    
    
    
    
    
    
    
    
}
