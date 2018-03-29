//
//  DKArray.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/28.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation


fileprivate let ARRAY_CAPACITY_DEFAULT = (10)
fileprivate let ARRAY_CACHE_LENGTH = (16)


class DKArray<T>: NSObject{
    
    /// 数组的长度
    var length : Int {
        get{
            return _length;
        }
    }
    
    fileprivate var _length = 0;
    fileprivate let _value:T!
    ///  数组的容量
    fileprivate var _capacity = ARRAY_CAPACITY_DEFAULT
    /// 是否自动扩容
    var autoExpand:Bool = true
    
    /// 存取对应的值
    fileprivate var  _member = UnsafeMutablePointer<T>.allocate(capacity: ARRAY_CAPACITY_DEFAULT);
    /// 存取对应的缓存
    fileprivate var _cache = UnsafeMutablePointer<Int>.allocate(capacity: ARRAY_CACHE_LENGTH);
    
    
     init(_ value:T) {
        _value = value;
        super.init();
        self.initData(capacity: ARRAY_CAPACITY_DEFAULT, value: value);
    }
    
    deinit {
        _member.deallocate(capacity: self._capacity);
    }
}

// MARK:初始化对象
extension DKArray {
    
    // MARK: 类初始化对象
    class func array<T>(_ value:T ,capacity:Int = ARRAY_CAPACITY_DEFAULT) -> DKArray<T>{
        let array = DKArray<T>(value);
        if(capacity < array._capacity){
             array.initData(capacity: ARRAY_CAPACITY_DEFAULT, value:value);
        }else{
             array.initData(capacity: capacity, value:value);
        }
        
        return array ;
    }
    
   // MARK:多元素初始化对象
    class func array<T>(_ value:T,elements:T...) -> DKArray<T> {
        let array = DKArray<T>.array(value);
        // 添加多个元素
        for v in elements{
            array.put(value: v);
        }
        return array ;
    }
    
    
}

// MARK:对象操作方法
extension DKArray {
    
    /// 添加单个元素
    ///
    /// - Parameter m: 元素
    @discardableResult
    func put(value:T) -> Bool{
        if(_length < self._capacity){
            _member[_length] = value;
            _length += 1
            return true
          
        }else{
            if(self.autoExpand){ //自动扩容
            ///保存原先的数据
            let _len = _length;
            let memebers = _member;
         
            initData(capacity: 2 * _capacity,value: _value);
            _length = _len;
            _member.initialize(from: memebers, count: _len);
        
            free(memebers);
            return self.put(value: value);
  
                
            }
        }
        
        return false;
    }
    /// 获取元素
    func getValue(index:Int) -> T{
        if(index >= 0 && index < _length){
            return _member[index];
        }
        return _value
    }

    
    /// 添加DKArray对象元素
    @discardableResult
    func putArray(tmparray:DKArray, index:Int = 0) -> Bool {
        if(tmparray.length <= 0 || index<0 || index > self.length){ /// 数组长度小于0 索引位置不再当前数组范围内
            return false;
        }else if(tmparray.length + index > self._capacity){ /// 数组长度超过了容量
            if(self.autoExpand){ /// 允许自动扩容
                let tmpcap = self._capacity + tmparray.length;
                let _len = self.length;
                let memebers = _member;
                initData(capacity: tmpcap,value: _value);
                _length = _len;
                _member.initialize(from: memebers, count: _len);
                free(memebers);
                return self.putArray(tmparray: tmparray, index: index);
    
            }else{ /// 不扩容
                return false;
            }
            
        }else{ /// 当前容量充足
            /// 值偏移
            for i in (index+tmparray.length..<_length+tmparray.length).reversed(){
                _member[i] = _member[i - tmparray.length];
            }
            /// 重新赋值
            for i in index..<tmparray.length {
                _member[i] = tmparray.getValue(index: i - index);
            }
            return true;
        }
        
        
        
    }
    
    
    
    // MARK:私有方法
    //初始化数据
    fileprivate func initData(capacity:Int , value:T){
        _length = 0;
        autoExpand = true;
        self._capacity = capacity;
        _member = UnsafeMutablePointer<T>.allocate(capacity: capacity)
    
//    defer {
//        _member.deallocate(capacity: capacity);
//    }
    
    _member.initialize(to: value, count: capacity)

    }
}

// MARK:处理一些系统协议等相关的方法
extension DKArray{
    
    
}
