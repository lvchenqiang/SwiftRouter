//
//  UILabel+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/27.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    class func createLabel(_ frame: CGRect = CGRect.zero,
                           font: UIFont = UIFont.systemFont(ofSize: 14),
                           textColor: UIColor = UIColor.white,
                           textAlignment: NSTextAlignment = .left,
                           text: String = "") -> UILabel{
        
        let label = UILabel()
        label.frame = frame
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        label.isUserInteractionEnabled = true;
        label.lineBreakMode = .byClipping;
        return label
    }
}
