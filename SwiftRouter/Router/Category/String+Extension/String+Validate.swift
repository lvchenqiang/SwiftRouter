//
//  String+Validate.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension String{
  
    
    /// 手机号以13，14 , 15，17 ,18开头，八个 \d 数字字符
    var isValidateMobile:Bool{
        get{
            let phoneRegex = "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0-9]))\\d{8}$";
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
