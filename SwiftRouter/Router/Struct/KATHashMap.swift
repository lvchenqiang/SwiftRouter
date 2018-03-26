//
//  KATHashMap.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

///散列表默认的容量
let HASH_MAP_CAPACITY_DEFAULT = 128;

///散列表默认的最大使用率
let HASH_MAP_MAX_USAGE_DEFAULT = 60;

class KATHashMap<T>: NSObject,NSCopying {

    /// 元素的个数
    var length:NSInteger = 0;
    
    /// 散列表的最大容量
    var capacity:NSInteger = 0;
    
    /// 散列表的最大使用率 最大的值 为 100
    var maxUsage:Int = 60;
    
    ///散列表的当前使用率
    var usage:Int = 0 ;
    
    /// 自动扩容 默认是true
    var autoExpand:Bool = true;
    /// 是否使用重复的索引覆盖原来的值 默认是true
    var replace:Bool = true;
    
    /// 转对象的类名
    var keyClass:String = ""
    
    /// 转对象的构造方法
    var keySelector:String = ""
    
    
//    private *_key:nss;//索引表
//    id *_value;//值表
//    int _deleteCount;//删除的次数
    /// 索引表
    
//    private key : *String!

    
//    var value:Dictionary<Hashable, Any>!
//    var value1:NSDictionary!
    
    
    // MARK:构造方法
    class func hashMap(_ capacity:NSInteger, _ maxUsage:NSInteger) -> KATHashMap{
        let hashMap = KATHashMap()
        if(capacity>0 && maxUsage>0 && maxUsage<=100){
            hashMap.initData(capacity, maxUsage);
            
        }else{
            hashMap.initData(capacity, maxUsage);
        }
     
        return hashMap;
    }
    
   // MARK:初始化基础的数据
    func initData(_ capacity:NSInteger, _ maxUsage:NSInteger){
        
        self.capacity = capacity;
        self.maxUsage = maxUsage;
        
        
    }
    

    func copy(with zone: NSZone? = nil) -> Any {
        let hashMap = KATHashMap();
        
        return hashMap;
    }
}


