//
//  main.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/12.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

//UIApplicationMain(C_ARGC, C_ARGV, NSStringFromClass(UIApplication), NSStringFromClass(AppDelegate))

UIApplicationMain(CommandLine.argc, UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(
        to: UnsafeMutablePointer<Int8>.self,
        capacity: Int(CommandLine.argc)), NSStringFromClass(UIApplication.self), NSStringFromClass(APPController.self))






















