//
//  UserDefaults+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/8.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
extension UserDefaults {
    
    /// EZSE: Generic getter and setter for UserDefaults.
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key) as Any?
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// EZSE: Date from UserDefaults.
    public func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }
}
