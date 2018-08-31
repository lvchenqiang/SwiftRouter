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
        KATAppUtil.setOrientation(orientation: .portrait);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false);
        
        KATAppUtil.setOrientation(orientation: .portrait);
        
    }

    func gotobottom(){
        LLog("掉漆常用方法 ");
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        self.present(ViewController(), animated: false, completion: nil);
//          KATRouter.routeMap(to: "kViewController");
        self.navigationController?.pushViewController(ViewController(), animated: false);
//        self.present(BaseNavigationController(rootViewController: ViewController()), animated: false, completion: nil);
     
    }

    
   
    
}
