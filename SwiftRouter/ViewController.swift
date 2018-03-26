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
    
        KATRouter.shareRouter.topVC = self;
   
    
        
     
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event);
        
        
//        self.present(SecondViewController(), animated: false, completion: nil);
        
        
        
        let vc = UIAlertController(title: "哈哈哈", message: "-----", preferredStyle: .actionSheet);
        let action1 = UIAlertAction(title: "sure", style: .default) { (action) in
            
        }
  
        vc.addAction(action1);
        
        self.present(vc, animated: false, completion: nil);
        
    }
    
    
    func loadExchangeMethod(){
        
        debugPrint("触发了viewdidload");
        debugPrint("\(app)");
        
        
        
        var m_count:UInt32 = 0;
        
        if let methods = class_copyMethodList(type(of: self.app), &m_count){
            debugPrint(methods[0]);
            
            for i in 0..<m_count{
                let m = methods[Int(i)];
                let sel = method_getName(m);
                let name = sel_getName(sel);
                debugPrint("方法:\(name): \(NSStringFromSelector(sel))");
                
                
            }
        }
        
        var p_count : UInt32 = 0;
        
        if let propertys = class_copyPropertyList(type(of: self.app), &p_count)
        {
            for i in 0..<p_count{
                let p = propertys[Int(i)];
                let name = ivar_getName(p);
                debugPrint("成员变量:\(describing: name): \(String(cString:property_getName(p)))");
            }
        }
        
        
        
        
        
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

