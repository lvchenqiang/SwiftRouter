//
//  NSObject+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/2.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

extension NSObject
{
    // MARK:返回className
    var className:String{
        get{
          let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }

        }
    }
    
}



