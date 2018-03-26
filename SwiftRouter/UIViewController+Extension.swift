//
//  UIViewController+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/22.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController
{
    class func initializeOnceMethod(){
        KATSwizzle.KATSwizzleMethod(self,
                        originalSelector: #selector(viewDidAppear(_:)),
                        swizzledSelector: #selector(kat_viewWillAppear))
        
        
    }
    
    @objc func kat_viewWillAppear(_ animated: Bool){
        debugPrint("-----kat_viewWillAppear");
    }
    
    
    
}
