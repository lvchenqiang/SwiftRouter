//
//  KATMacros.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/13.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


//MARK:-UI  Layout
// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
//计算布局属性
func NEWWIDTH(_ x:CGFloat)->CGFloat{
    return ((x) / 750.0 * kScreenW);
}
func NEWHEIGHT(_ y:CGFloat)->CGFloat{
    return ((y)/1334.0 * kScreenH);
}
// MARK:- 颜色方法
func RGBA(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat = 1) -> UIColor {
    if #available(iOS 10.0, *) {
        return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha:a);
    } else {
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    };
    
}
