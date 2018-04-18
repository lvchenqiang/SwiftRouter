//
//  KATLock.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/26.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
/*
 互斥锁，当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放
 * 但是如果连续锁定两次，则会造成死锁问题。如果想在递归中使用锁，就要用到了 RecursiveLock 递归锁。
 */

/*
 *互斥锁与读写锁的区别：
 
 *当访问临界区资源时（访问的含义包括所有的操作：读和写），需要上互斥锁；
 
 *当对数据（互斥锁中的临界区资源）进行读取时，需要上读取锁，当对数据进行写入时，需要上写入锁。
 
 *读写锁的优点：
 
 *对于读数据比修改数据频繁的应用，用读写锁代替互斥锁可以提高效率。因为使用互斥锁时，即使是读出数据（相当于操作临界区资源）都要上互斥锁，而采用读写锁，则可以在任一时刻允许多个读出者存在，提高了更高的并发度，同时在某个写入者修改数据期间保护该数据，以免任何其它读出者或写入者的干扰。
 */

/*
  pop编程
 */
protocol DKLockable: class {
    func lock()
    func unlock()
}

/*
 自旋锁，当一个线程获得锁之后，其他线程将会一直循环在哪里查看是否该锁被释放。适用于锁的持有者保存时间较短的情况下
 *OSSpinLock已经不再安全,会出现优先级反转的问题。
 */
@available(iOS 10.0, OSX 10.12, watchOS 3.0, tvOS 10.0, *)
final class DKUnfairLock: DKLockable {
    private var unfairLock = os_unfair_lock_s()
    
    func lock() {
        os_unfair_lock_lock(&unfairLock)
    }
    
    func unlock() {
        os_unfair_lock_unlock(&unfairLock)
    }
}

fileprivate final class DKMutex: DKLockable {
    private var mutex = pthread_mutex_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}


/*
 * 递归锁  防止一个线程多次加锁 造成死锁
 *
 */

fileprivate final class DKRecursiveMutex: DKLockable {
    private var mutex = pthread_mutex_t()
    
    init() {
        var attr = pthread_mutexattr_t()
        pthread_mutexattr_init(&attr)
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attr)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
}

/*
 * 读写锁
 * 用来解决读者写者问题的，读操作可以共享，写操作是排他的，读可以有多个在读，写只有唯一个在写，同时写的时候不允许读
 */
fileprivate final class DKReadWriteLock:DKLockable
{
    private var rwlock_t = pthread_rwlock_t();
    private var rwlock_a = pthread_rwlockattr_t()
    init() {
        pthread_rwlock_init(&rwlock_t, &rwlock_a)
    }
    deinit {
        pthread_rwlock_destroy(&rwlock_t)
    }
    /// 写入锁
    func lock() {
        pthread_rwlock_wrlock(&rwlock_t)
    }
    
    func unlock() {
        pthread_rwlock_unlock(&rwlock_t)
    }
    
}
/// 自旋锁
fileprivate final class DKSpin: DKLockable {
    private let locker: DKLockable
    init() {
        if #available(iOS 10.0, macOS 10.12, watchOS 3.0, tvOS 10.0, *) {
            locker = DKUnfairLock()
        } else {
            locker = DKMutex()
        }
    }
    
    func lock() {
        locker.lock()
    }
    
    func unlock() {
        locker.unlock()
    }
}


/// 条件锁
fileprivate final class DKConditionLock: DKLockable {
    private var mutex = pthread_mutex_t()
    private var cond = pthread_cond_t()
    
    init() {
        pthread_mutex_init(&mutex, nil)
        pthread_cond_init(&cond, nil)
    }
    
    deinit {
        pthread_cond_destroy(&cond)
        pthread_mutex_destroy(&mutex)
    }
    
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
    
    func wait() {
        pthread_cond_wait(&cond, &mutex)
    }
    
    func wait(timeout: TimeInterval) {
        let integerPart = Int(timeout.nextDown)
        let fractionalPart = timeout - Double(integerPart)
        var ts = timespec(tv_sec: integerPart, tv_nsec: Int(fractionalPart * 1000000000))
        
        pthread_cond_timedwait_relative_np(&cond, &mutex, &ts)
    }
    
    func signal() {
        pthread_cond_signal(&cond)
    }
}
// MARK:锁机制
class KATLock: NSObject {
    
    
    static let shareLockManager:KATLock = {
        let lock = KATLock();
        return lock;
    }()
    fileprivate var condition_lock = DKConditionLock();
    
    /// synchronized锁 互斥锁 性能较差
    ///
    /// - Parameters:
    ///   - lock: 锁对象 实际上是把这个对象当做锁来使用。通过一个哈希表来实现的，OC 在底层使用了一个互斥锁的数组(你可以理解为锁池)，通过对对象去哈希值来得到对应的互斥锁。
    ///   - closure: 闭包
    ///
     func synchronizedLock(lock: AnyObject, closure: () -> ()){
        objc_sync_enter(lock);
        closure();
        objc_sync_exit(lock);
    }

    /// 条件锁
    ///
    /// - Parameter closure: 执行代码
     func conditionLock(closure: () -> ()){
        condition_lock.lock();
        closure()
        condition_lock.unlock();

    }
    
    
    
    
}
