//
//  SecondViewController.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/23.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
        // Do any additional setup after loading the view.
        
        let btn = UIButton();
        btn.frame = M_RECT(100, 100, 200, 40);
        btn.backgroundColor = UIColor.red;
        btn.addTapAction { (ges) -> (Void) in
            
//            KATRouter.backward();
            self.navigationController?.pushViewController(ViewController(), animated: false);
            
            
            
        }
         btn.setTitle("2222222Second  backward", for: .normal);
        self.view.addSubview(btn);
        
        
        let btn2 = UIButton();
        btn2.frame = M_RECT(100, 400, 200, 40);
        btn2.backgroundColor = UIColor.blue;
        btn2.addTapAction {(ges) -> (Void) in
            
//            KATRouter.routeMap(to: "kViewController");
            let alertC = UIAlertController(title: "hehe", message: "-----", preferredStyle: .alert);
            
            let action1 = UIAlertAction(title: "1111", style: .cancel) { (action) in
                
            }
            
            let action2 = UIAlertAction(title: "2222", style: .default) { (action) in
                
            }
            
            alertC.addAction(action1);
            alertC.addAction(action2);
            self.present(alertC, animated: false, completion: nil);
            
        }
        btn2.setTitle("2222222Second forward ", for: .normal);
        self.view.addSubview(btn2);

    }
  
    
    override func viewDidAppear(_ animated: Bool) {
       self.isFullScreenSlide = false;
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event);
        
//        self.dismiss(animated: false, completion: nil);
        
//        KATRouter.route(to: "kViewController");


        
        
        
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SecondViewController : KATRouterDelegate{
    
    func routingFinish(values: NSDictionary, backward: Bool) {
        
        LLog(values);
        
    }
    
    func allowRouting(values: NSDictionary) -> Bool {
        LLog(values);
        
        return true;
    }
}
