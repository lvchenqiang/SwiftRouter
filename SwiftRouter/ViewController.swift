//
//  ViewController.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/12.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /// appdelegate
    fileprivate let app:APPController = UIApplication.shared.delegate! as! APPController;
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        KATRouter.shareRouter.topVC = self;
   
        self.view.backgroundColor = UIColor.blue;
        
     
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event);
        
        
        self.present(SecondViewController(), animated: false, completion: nil);
        
        
        
//        let vc = UIAlertController(title: "哈哈哈", message: "-----", preferredStyle: .actionSheet);
//        let action1 = UIAlertAction(title: "sure", style: .default) { (action) in
//
//        }
//
//        vc.addAction(action1);
//
//        self.present(vc, animated: false, completion: nil);
        
    }
    
    
    func loadExchangeMethod(){
        
   
        
        
        
        
//
//
//        if(self.app.responds(to: #selector(UIApplicationDelegate.applicationDidBecomeActive(_:)))){
//
//            debugPrint("执行方法 applicationDidBecomeActive");
//
//        }else{
//
//            debugPrint("未执行方法");
//            //            let originalSelector = #selector(APPController.applicationDidBecomeActive(_:));
//            //            let swizzledSelector = #selector(self.applicationDidBecomeActive(_:));
//            //
//            //            let  originalMethod  = class_getInstanceMethod(APPController.self, originalSelector);
//            //            let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector);
//            //
//            //
//            //            class_addMethod(UIViewController.self, Selector(("applicationDidBecomeActive")), method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!));
//
//
//            //            class_addMethod(app,Selector(("applicationWillResignActive")) ,method_getImplementation(class_getInstanceMethod(self.class, Selector(("applicationWillResignActive")))), NSNull);
//        }
//
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
}

