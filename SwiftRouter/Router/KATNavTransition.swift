//
//  KATNavTransition.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/3/13.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import UIKit

class KATNavTransition: NSObject {
   /// 动画时长
    var duration:Double = 0.4;
    ///是否为消失动画
    var isDismissAnimation = false;
    /// 是否为纵向动画
    var isVerticalAnimation = false;
    
    class  func shareTransition() -> KATNavTransition {
        let transition = KATNavTransition();
        transition.duration = 0.4;
        transition.isDismissAnimation = false;
        transition.isVerticalAnimation = false;
        return transition;
    }
    
    
    
}

// MARK:- UIViewControllerAnimatedTransitioning 代理事件
extension KATNavTransition:UIViewControllerAnimatedTransitioning{
    
   
    
    /// 实现动画逻辑
    func presentAnimation(using transitionContext: UIViewControllerContextTransitioning){
        
        //生成fromView 和 toView
        
        // 通过viewcontrollerforkey 取出转场前后的控制器
        let toView : UIView = transitionContext.view(forKey: UITransitionContextViewKey.to) ?? UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height));
        toView.frame  = UIScreen.main.bounds;
        
        // 通过viewcontrollerforkey 取出转场前后的控制器
        let fromView : UIView = transitionContext.view(forKey: UITransitionContextViewKey.from) ?? UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height));
        fromView.frame = UIScreen.main.bounds;
        
        
        /// 消失的view 截图
        let dissView:UIView = fromView.snapshotView(afterScreenUpdates: false)!;
        dissView.frame = UIScreen.main.bounds;
        
        //如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
        let containerView = transitionContext.containerView;
        
        if(!self.isDismissAnimation){ // 出现动画
           // 将截图视图和toVC的view 都加入containerView中
            containerView.addSubview(dissView);
            containerView.addSubview(toView);
            
            
            //阴影
            let shadow = UIView();
            shadow.backgroundColor = UIColor.gray;
            shadow.frame = dissView.bounds;
            dissView.addSubview(shadow);
            
            if(self.isVerticalAnimation){// 纵向动画
                dissView.frame = CGRect(x: 0, y: 0, width: fromView.frame.size.width, height: fromView.frame.size.height);
                toView.frame = CGRect(x: 0, y: toView.frame.size.height, width: toView.frame.size.width, height: toView.frame.size.height);
                shadow.alpha = 0;
                
                
            }else{// 横向动画
                
                dissView.frame = CGRect(x: 0, y: 0, width: fromView.frame.size.width, height: fromView.frame.size.height);
                toView.frame = CGRect(x: toView.frame.width, y: toView.frame.origin.y, width: toView.frame.size.width, height: toView.frame.size.height);
                shadow.alpha = 0;
            }
            //开启动画效果
            UIView .animate(withDuration: self.duration, animations: { () in
                
                if(!self.isVerticalAnimation){  // 横向
                    dissView.frame = CGRect(x: -min(kScreenH,kScreenW) * 0.2, y: 0, width: fromView.bounds.size.width, height: fromView.bounds.size.height);
                }
                
                toView.frame = toView.bounds;
                shadow.alpha = 0;
            }, completion: { (finish) in
                dissView.removeFromSuperview(); // 移除截图

            //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否则认为一直还在转场中，会出现无法交互的情况！
                transitionContext.completeTransition(true);
            });
            
            
            
            
        }else{// 消失动画
            
            // 将截图视图的view和toview加入到containerView 中
            containerView.addSubview(toView);
            containerView.addSubview(dissView);
            
            // 阴影
            let shadow = UIView();
            shadow.backgroundColor = UIColor.gray;
            shadow.frame = dissView.bounds;
            dissView.addSubview(shadow);
            
            if(!self.isVerticalAnimation){ //横向
                toView.frame = CGRect(x: -min(kScreenW, kScreenH) * 0.2, y: 0, width: fromView.bounds.size.width, height: fromView.bounds.size.height);
     
            }
        }
        
    }
    
    
    /// 实现动画逻辑
    func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning)
    {
        //生成fromView 和 toView
        
        // 通过viewcontrollerforkey 取出转场前后的控制器
        let toView : UIView = transitionContext.view(forKey: UITransitionContextViewKey.to) ?? UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height));
        toView.frame  = UIScreen.main.bounds;
        
        // 通过viewcontrollerforkey 取出转场前后的控制器
        let fromView : UIView = transitionContext.view(forKey: UITransitionContextViewKey.from) ?? UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.size.width , height: UIScreen.main.bounds.size.height));
        fromView.frame = UIScreen.main.bounds;
        
        
        /// 消失的view 截图
        let dissView:UIView = fromView.snapshotView(afterScreenUpdates: false)!;
        dissView.frame = UIScreen.main.bounds;
        
        //如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
        let containerView = transitionContext.containerView;
        containerView.addSubview(toView);
        containerView.addSubview(dissView);
        
        UIView.animate(withDuration: self.duration, animations: {
            dissView.frame = CGRect(x: dissView.frame.size.width, y: dissView.frame.origin.y, width: dissView.frame.size.width, height: dissView.frame.size.height);
            
        }) { (finished) in
            dissView.removeFromSuperview();
            transitionContext.completeTransition(true); // 完成动画
        };
        
        
    }
    
    /// 动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /// 定义动画效果
        self.presentAnimation(using: transitionContext);
        
    }
}

// MARK:- UIViewControllerTransitioningDelegate 代理事件
extension KATNavTransition:UIViewControllerTransitioningDelegate{

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self;
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self;
    }
    


}

