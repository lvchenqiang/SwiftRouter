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
   
        self.view.backgroundColor = UIColor.white;
        
     
        let btn = UIButton();
         btn.frame = M_RECT(100, 100, 200, 40);
        btn.backgroundColor = UIColor.blue;
        btn.addTapAction {(ges) -> (Void) in
            
          KATRouter.backward();
            
        }
        btn.setTitle("111111View back ", for: .normal);
        self.view.addSubview(btn);
        
        
        
        let btn2 = UIButton();
        btn2.frame = M_RECT(100, 400, 200, 40);
        btn2.backgroundColor = UIColor.blue;
        btn2.addTapAction {(ges) -> (Void) in
            
            KATRouter.routeMap(to: "kSecondViewController");
            
        }
        btn2.setTitle("111111View forward ", for: .normal);
        self.view.addSubview(btn2);
        
        
        
       
        
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event);
        
        let viewtest =  KATSprite(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
//        viewtest.zoomInWithScale()
        viewtest.rollOutToPosition(position: CGPoint(x: 300, y: 400), duration: 1.5);
        viewtest.backgroundColor = UIColor.red
        self.view.addSubview(viewtest);
        
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

