//
//  LYUSwiftFunctions.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/5/8.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation

struct LYUFunctions {
    
    /// EZSE: Returns app's name
    public static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        
        return nil
    }
    
    
    /// EZSE: Returns app's version number
    public static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// EZSE: Return app's build number
    public static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
    
    /// EZSE: Return app's bundle ID
    public static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }
    
    /// EZSE: Returns both app's version and build numbers "v0.3(7)"
    public static var appVersionAndBuild: String? {
        if appVersion != nil && appBuild != nil {
            if appVersion == appBuild {
                return "v\(appVersion!)"
            } else {
                return "v\(appVersion!)(\(appBuild!))"
            }
        }
        return nil
    }
    
    
    /// EZSE: Return device version ""
    public static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    /// EZSE: Returns true if DEBUG mode is active //TODO: Add to readme
    public static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    /// EZSE: Returns true if RELEASE mode is active //TODO: Add to readme
    public static var isRelease: Bool {
        #if DEBUG
        return false
        #else
        return true
        #endif
    }
    
    /// EZSE: Returns true if its simulator and not a device //TODO: Add to readme
    public static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }

    /// EZSE: Returns true if its on a device and not a simulator //TODO: Add to readme
    public static var isDevice: Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }
    
    /// EZSE: Returns the locale country code. An example value might be "ES". //TODO: Add to readme
    public static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
    
    #if os(iOS) || os(tvOS)
    
    /// EZSE: Calls action when a screen shot is taken
    public static func detectScreenShot(_ action: @escaping () -> Void) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { _ in
            // executes after screenshot
            action()
        }
    }
    #endif
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
