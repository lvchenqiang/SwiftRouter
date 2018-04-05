//
//  KATRouterRootVC.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/16.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class KATRouterRootVC: UIViewController {
    var a = DKArray<NSString>("");
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow;

    }
    


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        self.present(ViewController(), animated: false, completion: nil);
        KATRouter.routeMap(to: "kViewController");
        
    }

}
