//
//  UIView+Snapshot.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/24.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit
extension UIView
{
    func snapshot() -> UIView{
        return self.snapshotView(afterScreenUpdates: true) ?? self;
    }

}
