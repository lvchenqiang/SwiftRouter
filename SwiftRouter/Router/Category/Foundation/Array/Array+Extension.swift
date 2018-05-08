//
//  Array+Extension.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/8.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}


extension Array
{
  
    public func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    
    public mutating func removeAll(_ elements: [Element]) {
      
       
    }
    
    
    
}


extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    public subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
