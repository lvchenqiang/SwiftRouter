//
//  DKArray.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/28.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation


fileprivate let ARRAY_CAPACITY_DEFAULT = (100)
fileprivate let ARRAY_CACHE_LENGTH = (16)

protocol EqualValue{
    static func ev(l:Self,r:Self) -> Bool;
}




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
    
    
    override var description: String
        {
        get {
            var des = "";
            for i in 0..<_length{
             des += "\n \(_member[i]) "
            }
            
            return des;
        }
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

    /// 通过索引设置成员变量的值(索引必须在申请的内存空间内)
    ///
    /// - Parameters:
    ///   - value: value
    ///   - index: 索引
    func setValue(value:T,index:Int = 0){
        if(index>=0 && index<_capacity){
            _member[index] = value;
        }else{
            LLog("数组越界");
        }
    }
    
    
    
    /// 添加DKArray对象元素
    @discardableResult
    func putDKArray(tmparray:DKArray, index:Int = 0) -> Bool {
        if(tmparray.length <= 0 || index<0 || index > self.length){ /// 数组长度小于0 索引位置不再当前数组范围内(实际有可能可以进行插入)
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
                return self.putDKArray(tmparray: tmparray, index: index);
    
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
            _length += tmparray.length;
            return true;
        }
    }
    // MARK: Array对象元素
    @discardableResult
    func putArray(tmparray:Array<T>,index:Int = 0)->Bool{
        
        if(tmparray.count <= 0 || index<0 || index > self.length){ /// 数组长度小于0 索引位置不再当前数组范围内(实际有可能可以进行插入)
            return false;
        }else if(tmparray.count + index > self._capacity){ /// 数组长度超过了容量
            if(self.autoExpand){ /// 允许自动扩容
                let tmpcap = self._capacity + tmparray.count;
                let _len = self.length;
                let memebers = _member;
                initData(capacity: tmpcap,value: self._value);
                self._length = _len;
                self._member.initialize(from: memebers, count: _len);
                free(memebers);
                return self.putArray(tmparray: tmparray, index: index);
                
            }else{ /// 不扩容
                return false;
            }
            
        }else{ /// 当前容量充足
            /// 值偏移
            for i in (index+tmparray.count..<_length+tmparray.count).reversed(){
                self._member[i] = self._member[i - tmparray.count];
            }
            /// 重新赋值
            for i in index..<tmparray.count {
                self._member[i] = tmparray[i - index];
            }
            _length += tmparray.count;
            return true;
        }
    }
    
    // MARK:根据range获取子数组
    func subArray(range:NSRange)->DKArray{
        let array = DKArray<T>(self._value);
        for i in range.location..<(range.location+range.length) where i < _length
        {
            array.put(value: self.getValue(index: i));
        }
        
        return array;
    }
    
    func subArray(to index:Int) -> DKArray{
        return self.subArray(range: NSMakeRange(0, index));
    }
    func subArray(from index:Int) -> DKArray {
         return self.subArray(range: NSMakeRange(index, _length - index));
    }
    
    // MARK: 去除重复的元素 返回无序
    
    ///  去除重复的元素
    ///
    /// - Returns: 无序去重后排列的数组
    func removeDuplication() -> DKArray{
        let set = NSSet(array: self.toNSMutableArray() as! [Any]);
        let tmparray = DKArray(_value);
        tmparray.putArray(tmparray: set.allObjects as! [T]);
        LLog(tmparray);
        return tmparray;
    }
    
    
    
    
    
    /// 是否包含该元素
    ///
    /// - Parameter value: 元素
    /// - Returns: 是否包含
    func containElement(_ value:T) -> Bool{
        
        for _ in 0..<_length{
//
//            if(_member[i] === value){
//                return true;
//            }
        }
        return false;
        
    }
    // MARK:转换成NSMutableArray
    func toNSMutableArray() -> NSMutableArray{
        let arr = NSMutableArray();
        for i in 0..<_length{
            arr.add(_member[i]);
        }
        return arr;
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
    
        _member.initialize(repeating: value, count: capacity)

    }
}

// MARK:处理一些系统协议等相关的方法
extension DKArray{
   
    
}



//
//func equalValue<T:EqualValue>(v:T) -> Bool{
//    return ev(l,r);
//}


//extension String:CurrentLength{
//    var currentlength: Int
//    {
//        get{
//            return self.length;
//        }
//    }
//}
//
//






