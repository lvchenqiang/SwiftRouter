//
//  KATSprite.swift
//  SwiftRouter
//
//  Created by 吕陈强 on 2018/4/4.
//  Copyright © 2018年 吕陈强. All rights reserved.
//

import Foundation
import UIKit

//  精灵视图（用作基类或容器，方便使用动画和变形)(UIView关联的Layer不会有隐式动画)
//  为了防止循环引用，从父视图中删除时，会自动停止定时器

/*
 
 3D矩阵详解
 
 1    0    0    0
 0    1    0    0
 0    0    1    0
 tx  ty   tz    1
 
 struct CATransform3D
 {
 CGFloat     m11（x缩放）,    m12（y切变）,     m13（旋转）,     m14（）;
 
 CGFloat     m21（x切变）,    m22（y缩放）,     m23（）,        m24（）;
 
 CGFloat     m31（旋转）,     m32（ ）,        m33（）,         m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
 
 CGFloat     m41（x平移）,    m42（y平移）,     m43（z平移）,    m44（）;
 };
 
 */

enum KATRouterTransitionStyle:Int{
    case None = 0
    case Fade
    case MoveHorizontal
    case MoveVertical
    case PushHorizontal
    case PushVertical
    case RevealHorizontal
    case RevealVertical
    case CubeHorizontal
    case CubeVertical
    case FlipHorizontal
    case FlipVertical
    case Suck
    case Ripple
    case CurlLeft
    case CurlRight
    case CurlBottom
    case NavHorizontal
    case NavVertical
}


// MARK:- 常量

///动画键:类型(值为String )
let kSpriteKeyType : String = "kSpriteKeyType"

///动画键:模式(值为String )
let kSpriteKeyMode:String = "kSpriteKeyMode"

///动画键:模式组(动画组属性)(值为Array )
let kSpriteKeyModeGroup = "kSpriteKeyModeGroup";

///动画键:终点位置(值为CGPoint)
let kSpriteKeyPosition = "kSpriteKeyPosition"

/// 动画键:X轴旋转(值为float)
let kSpriteKeyRotationX = "kSpriteKeyRotationX"

///动画键:Y轴旋转(值为float)
let kSpriteKeyRotationY = "kSpriteKeyRotationY"

///动画键:Z轴旋转(值为float)
let kSpriteKeyRotationZ = "kSpriteKeyRotationZ"

///动画键:X轴缩放(值为float)
let kSpriteKeyScaleX = "kSpriteKeyScaleX"

/// 动画键:Y轴缩放(值为float)
let kSpriteKeyScaleY = "kSpriteKeyScaleY"

/// 动画键:Z轴缩放(值为float)
let kSpriteKeyScaleZ = "kSpriteKeyScaleZ"

///动画键:XY轴缩放(值为float)
let kSpriteKeyScaleXY = "kSpriteKeyScaleXY"

///动画键:内容(值为UIImage)
let kSpriteKeyContents = "kSpriteKeyContents"

///动画键:3d变形(值为Transform3D)
let kSpriteKey3DTransform =  "kSpriteKey3DTransform"

///动画键:转场类型
let kSpriteKeyTransition =  "kSpriteKeyTransition"

///动画键:不透明度(值为float)
let kSpriteKeyOpacity =  "kSpriteKeyOpacity"



///动画键:背景色(值为UIColor *)
let kSpriteKeyBgColor = "kSpriteKeyBgColor";

///动画键:圆角半径(值为float)
let kSpriteKeyCornerRadius = "kSpriteKeyCornerRadius"

///动画键:边线宽(值为float)
let kSpriteKeyBorderWidth = "kSpriteKeyBorderWidth"

///动画键:边线色(值为UIColor *)
let kSpriteKeyBorderColor = "kSpriteKeyBorderColor"

///动画键:名称(值为NSString *)
let kSpriteKeyName = "kSpriteKeyName"

///动画默认值:名称
let kSpriteDefaultName = "kSpriteDefaultName"

///动画模式:位移
let kSpriteModePosition = "kSpriteModePosition"

///动画模式:X轴旋转
let kSpriteModeRotationX = "kSpriteModeRotationX"

///动画模式:Y轴旋转
let kSpriteModeRotationY = "kSpriteModeRotationY"

///动画模式:Z轴旋转
let kSpriteModeRotationZ = "kSpriteModeRotationZ"

///动画模式:X轴缩放
let kSpriteModeScaleX = "kSpriteModeScaleX"

///动画模式:Y轴缩放
let kSpriteModeScaleY = "kSpriteModeScaleY"

///动画模式:Z轴缩放
let kSpriteModeScaleZ = "kSpriteModeScaleZ"

///动画模式:XY轴缩放
let kSpriteModeScaleXY = "kSpriteModeScaleXY"

///动画模式:内容
let kSpriteModeContents = "kSpriteModeContents"

///动画模式:3d变形(包含了缩放和旋转)
let kSpriteMode3DTransform = "kSpriteMode3DTransform"

///动画模式:不透明度
let kSpriteModeOpacity = "kSpriteModeOpacity"

///动画模式:背景色
let kSpriteModeBgColor = "kSpriteModeBgColor"

///动画模式:圆角半径
let kSpriteModeCornerRadius = "kSpriteModeCornerRadius"

///动画模式:线宽
let kSpriteModeBorderWidth = "kSpriteModeBorderWidth"

///动画模式:边线色
let kSpriteModeBorderColor = "kSpriteModeBorderColor"

///动画类型:基础
let kSpriteTypeBasic = "kSpriteTypeBasic"

///动画类型:关键帧
let kSpriteTypeKeyFrame = "kSpriteTypeKeyFrame"

///动画类型:路径
let kSpriteTypePath = "kSpriteTypePath"

///动画类型:组
let kSpriteTypeGroup = "kSpriteTypeGroup"

///动画类型:转场
let kSpriteTypeTransition  = "kSpriteTypeTransition"


///常用动画:心跳
let kSpriteAnimationHeartbeat = "kSpriteAnimationHeartbeat"

///常用动画:闪烁
let kSpriteAnimationBlink  = "kSpriteAnimationBlink"

///常用动画:旋转
let kSpriteAnimationRotate = "kSpriteAnimationRotate"

///常用动画:翻转
let kSpriteAnimationFlip = "kSpriteAnimationFlip"

///常用动画:摇晃
let kSpriteAnimationShake = "kSpriteAnimationShake"

///常用动画:震动
let kSpriteAnimationShock = "kSpriteAnimationShock"

///常用动画:抖动
let kSpriteAnimationDither = "kSpriteAnimationDither"

///常用动画:消失
let kSpriteAnimationDisappear = "kSpriteAnimationDisappear"

///常用动画:出现
let kSpriteAnimationAppear = "kSpriteAnimationAppear"

///常用动画:缩放消失
let kSpriteAnimationScaledDisappear = "kSpriteAnimationScaledDisappear"

///常用动画:缩放出现
let kSpriteAnimationScaledAppear = "kSpriteAnimationScaledAppear"

///常用动画:焦点进入
let kSpriteAnimationZoomIn = "kSpriteAnimationZoomIn"

///常用动画:焦点出去
let kSpriteAnimationZoomOut = "kSpriteAnimationZoomOut"

///常用动画:滚动
let kSpriteAnimationRoll = "kSpriteAnimationRoll"

///常用动画:滚进
let kSpriteAnimationRollIn = "kSpriteAnimationRollIn"

///常用动画:滚出
let kSpriteAnimationRollOut = "kSpriteAnimationRollOut"

///常用动画:旋转进
let kSpriteAnimationRotateIn = "kSpriteAnimationRotateIn"

///常用动画:旋转出
let kSpriteAnimationRotateOut = "kSpriteAnimationRotateOut"

///常用动画:掉落
let kSpriteAnimationDrop = "kSpriteAnimationDrop"

///常用动画:飘落
let kSpriteAnimationFloat = "kSpriteAnimationFloat"

///常用动画:快速移动
let kSpriteAnimationMoveQuickly = "kSpriteAnimationMoveQuickly"

///常用动画:移动
let kSpriteAnimationMove = "kSpriteAnimationMove"

///常用动画:移动进来
let kSpriteAnimationComeIn = "kSpriteAnimationComeIn"

///常用动画:移动出去
let kSpriteAnimationGoOut = "kSpriteAnimationGoOut"

///常用动画:跳跃
let kSpriteAnimationJump = "kSpriteAnimationJump"

enum KATSpriteResizeType:Int {
    case   None = 0//不自动调整尺寸
    case  Default = 1//左上角位置不变，不超过原来的尺寸
    case  Center = 2//中心位置不变，不超过原来的尺寸
    case  CenterHorizontal = 3//水平方向中心位置不变，不超过原来的尺寸
    case  CenterVertical = 4//垂直方向中心位置不变，不超过原来的尺寸
    case  Original = 5//左上角位置不变，图片原始尺寸
    case  CenterOriginal = 6//中心位置不变，图片原始尺寸
}


enum KATSpriteType:NSInteger{
    case Basic
    case KEY_Frame
    case Path
    case Group
}


enum KATSpriteMode:NSInteger{
    case POSITION
    case OPACITY
    case BG_COLOR
    case BORDER_COLOR
    case BORDER_WIDTH
    case CORNER_RADIUS
    case ROTATION_X
    case ROTATION_Y
    case ROTATION_Z
    case SCALE_X
    case SCALE_Y
    case SCALE_Z
    case SCALE_XY
    case CONTENTS
}


@objc  protocol KATSpriteDelegate:NSObjectProtocol {
    @objc optional
    ///动画开始
    func sprite(_ sprite:KATSprite ,didStartAnimation:String)
    ///动画停止
    func sprite(_ sprite:KATSprite ,didStopAnimation:String, finished:Bool)
    ///更改内容(图片)
    func spriteDidChangeContent(_ sprite:KATSprite)
    ///调整尺寸
    func spriteDidResize(_ sprite:KATSprite)
}
class KATSprite:UIView  {
    
 
    ///等待执行动画队列
    fileprivate var animationQueue = Array<CAAnimation>();
    /// 是否正在执行动画
    fileprivate var animating = false;
    /// 是否执行完动画后回到原来的位置
    fileprivate var restoreAfterAnimating = false;
    /// 是否在执行动画的时候进行交互
    fileprivate var interactInAnimating = true
    ///是否在动画停止时保持当前状态
    fileprivate var keepStateOnStop = true;
    ///是否手动停止动画
    fileprivate var animationStoped = false;
    ///执行的动画
    fileprivate var currentAnimation:CAAnimation? = nil
    ///x轴旋转角度
    fileprivate var angleX:CGFloat = 0.0;
    ///y轴旋转角度
    fileprivate var angleY:CGFloat = 0.0;
    ///z轴旋转角度
    fileprivate var  angleZ:CGFloat = 0.0;
    ///x轴尺寸比例
    fileprivate var  sizeX:CGFloat = 1.0;
    ///y轴尺寸比例
    fileprivate var  sizeY:CGFloat = 1.0;
    ///z轴尺寸比例
    fileprivate var   sizeZ:CGFloat = 1.0;
    ///XY轴等比例
    fileprivate var  sizeXY:CGFloat = 1.0
    ///透视点(x轴或y轴旋转时才有效果)，负数表示透视点在后，一般在-0.001~-0.002之间比较合适，越接近0效果越少，用公式表示则为-1/d(透视点在后)，d为眼睛离屏幕的距离，单位为像素
    fileprivate var  perspective:CGFloat = -0.002;
    /// 原始内容
    fileprivate var contents:UIImage? = nil
    /// 当前展示图层
    fileprivate var presentLayer:CALayer  {
        get{
            let present = self.layer.presentation()
            if(present == nil){
                return self.layer;
            }else{
                return present!
            }
        }
    }
    /// 是否自动调整尺寸
    fileprivate var isAutoResize = false;
    /// 调整尺寸类型
    fileprivate var resizeType = KATSpriteResizeType.Default;
     ///代理
    weak var spriteDelegate:KATSpriteDelegate?
    
    ///动画计算模式(作用于关键帧、路径动画)
    ///kCAAnimationLinear(线性模式,默认)
    ///kCAAnimationPaced(均匀模式,会忽略keyTimes)
    ///kCAAnimationDiscrete(离散模式，没有过渡动画)
    ///kCAAnimationCubic(平滑模式，对于位置变动关键帧动画运行轨迹更平滑)
    ///kCAAnimationCubicPaced(平滑均匀模式)
    var animationCalculationMode:String = "kCAAnimationLinear";
    
    
    ///动画填充模式(作用于关键帧、路径动画)
    ///kCAFillModeRemoved(默认填充模式，无填充)
    ///kCAFillModeForwards(前段填充模式)
    ///kCAFillModeBackwards(后段填充模式)
    ///kCAFillModeBoth(前后段填充模式)
    var animationFillMode = "kCAFillModeRemoved"
    
    ///动画转向模式(作用于位移关键帧、路径动画)
    ///kCAAnimationNone(默认为空，不改变方向)
    ///kCAAnimationRotateAuto(自动模式，沿轨迹改变方向)
    ///kCAAnimationRotateAutoReverse(自动反转模式)
    var animationRotateMode = "kCAAnimationNone"
    
    ///动画时间模式
    ///kCAMediaTimingFunctionDefault(默认，先加速后减速)
    ///kCAMediaTimingFunctionLinear(线性)
    ///kCAMediaTimingFunctionEaseIn(加速)
    ///kCAMediaTimingFunctionEaseOut(减速)
    ///kCAMediaTimingFunctionEaseInEaseOut(先加速后减速)
    var animationTimingMode = "default"
    
    
    //////系统刷屏定时器 每秒60帧
    fileprivate var displayLinkTimer:CADisplayLink? = nil
    
    ///系统刷屏动作是否进行
    var displayLinkActionsRunning = false;
    
    ///系统刷屏动作
    var   displayLinkActions : (() -> ())? = nil
    
    ///是否被调整过尺寸
    fileprivate var isResized:Bool = false;
    ///原始Frame
    fileprivate var originalFrame:CGRect = CGRect.zero;
    
    
    class func  sprite() -> KATSprite{
        let sprite = KATSprite();
        sprite.contentMode = .scaleAspectFit;
        sprite.isUserInteractionEnabled = true;
        sprite.backgroundColor = UIColor.clear
        sprite.layer.borderColor = UIColor.clear.cgColor;
        sprite.layer.borderWidth = 0.0;
        sprite.layer.cornerRadius = 0.0;
        return sprite
    }

    override func removeFromSuperview() {
        stopDisplayLinkActions()
        clearAnimations()
        super.removeFromSuperview();
    }
    
    deinit {
        stopDisplayLinkActions();
        clearAnimations();
        self.displayLinkTimer = nil;
        self.displayLinkActions = nil;
    }
}



// MARK:- 动画相关的方法
extension KATSprite{
    
    
    /** 获取转场动画
     
     动画类型  说明              对应常量 是否支持方向设置
     
     公开API
     fade    淡出效果            kCATransitionFade      是
     movein  新视图移动到旧视图上  kCATransitionMoveIn    是
     push    新视图推出旧视图     kCATransitionPush      是
     reveal  移开旧视图显示新视图  kCATransitionReveal    是
     
     私有API         私有API只能通过字符串访问
     cube    立方体翻转效果    无    是
     oglFlip    翻转效果    无    是
     suckEffect    收缩效果    无    否
     rippleEffect    水滴波纹效果    无    否
     pageCurl    向上翻页效果    无    是
     pageUnCurl    向下翻页效果    无    是
     cameralIrisHollowOpen    摄像头打开效果    无    否
     cameraIrisHollowClose    摄像头关闭效果    无    否
     
     动画子类型                    说明
     kCATransitionFromRight      从右侧转场
     kCATransitionFromLeft       从左侧转场
     kCATransitionFromTop        从顶部转场
     kCATransitionFromBottom     从底部转场
     */
    class func   transition(type:String  ,subtype:String? = nil, duration:Double, delay:Double = 0) -> CATransition{
        
       /// 创建转场动画
        let transition = CATransition();
        transition.type = type;
        transition.subtype = subtype;
        transition.duration = duration;
        transition.beginTime = CACurrentMediaTime() + delay;//延迟时间
        /// 携带值
        transition.setValue(kSpriteTypeTransition, forKey: kSpriteKeyType);
        transition.setValue(type, forKey: kSpriteKeyTransition);
        return transition;
    }
    
    
    // MARK: 获取动画
      ///获取位移动画
    func  animationToPosition(position:CGPoint, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
            //创建动画并指定动画属性
        let animation = CABasicAnimation(keyPath: "position");

        //设置动画属性初始值和结束值
        animation.fromValue =  NSValue.init(cgPoint: self.layer.position);
        animation.toValue = NSValue.init(cgPoint: position);
        
        /// 设置其他动画属性
        animation.duration = duration; //动画时间
        animation.repeatCount = repeatCount; // 设置重复次数
        animation.autoreverses = autoreverses; //是否回到原来的位置
        animation.beginTime = CACurrentMediaTime() + delay;//延迟时间
        
        if(self.animationTimingMode.length > 0 ){ /// 动画时间模式
            animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        }
        
        /// 设置携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType);
        animation.setValue(kSpriteModePosition, forKey: kSpriteKeyMode);
        animation.setValue(NSValue.init(cgPoint: position), forKey: kSpriteKeyPosition);

        return animation;
    }
    
    ///获取不透明度动画
    func  animationToOpacity(opacity:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        /// 创建动画并指定属性值
        let animation = CABasicAnimation(keyPath: "opacity");
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.layer.opacity;
        animation.toValue = opacity;
        
        
        
        /// 设置动画的其他属性
        animation.duration = duration; ///动画时间
        animation.repeatCount = repeatCount; /// 设置重复次数
        animation.autoreverses = autoreverses /// 是否回到原来的位置
        animation.beginTime = CACurrentMediaTime() + delay;
        /// 动画时间模式
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
         animation.setValue(kSpriteModeOpacity, forKey: kSpriteKeyMode)
        animation.setValue(opacity, forKey: kSpriteKeyOpacity);
        return animation;
    }
    
    
    /// 获取背景颜色动画
    func animationBgToColor(color:UIColor, duration:Double, repeatCount:Float, delay:Double) -> CABasicAnimation{
          //创建动画并指定动画属性
        let animation = CABasicAnimation(keyPath: "backgroundColor");
        /// 设置属性的初始值和结束值
        animation.fromValue = self.backgroundColor;
        animation.toValue = color;
        
        /// 设置其他动画属性
        animation.duration = duration; /// 动画时间
        animation.repeatCount = repeatCount;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.autoreverses = false; /// 是否回到原来的位置
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)// 类型
        animation.setValue(kSpriteModeBgColor, forKey: kSpriteKeyMode) /// 模式
        animation.setValue(color, forKey: kSpriteKeyBgColor);
        return animation;
    }
    
    /// 获取边线颜色动画
    func animationBorderToColor(color:UIColor, duration:Double, repeatCount:Float, delay:Double) -> CABasicAnimation{
        //创建动画并指定动画属性
        let animation = CABasicAnimation(keyPath: "borderColor");
        /// 设置动画属性初始值和结束值
        animation.fromValue = UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor);
        animation.toValue = color;
        
        /// 设置其他动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
       animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType) /// 类型
       animation.setValue(kSpriteModeBorderColor, forKey: kSpriteKeyMode) /// 模式
        animation.setValue(color, forKey: kSpriteKeyBorderColor);/// 值
        return animation;
    }
    
    /// 获取边线宽动画
    func animationBorderToWidth(width:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "borderWidth");
        
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.layer.borderWidth;
        animation.toValue = width;
        
        /// 设置其他动画的属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        /// 设置携带值
       animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeBorderWidth, forKey: kSpriteKeyMode)
        animation.setValue(width, forKey: kSpriteKeyBorderWidth)
        return animation;
    }
    
    ///获取圆角半径动画
    func animationCornerToRadius(radius:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "cornerRadius");
        
        /// 设置动画属性的初始值和结束值
        animation.duration =  duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeCornerRadius, forKey: kSpriteKeyMode)
        animation.setValue(radius, forKey: kSpriteKeyCornerRadius);
        return animation;
    }
    
    ///获取X轴旋转动画
    func animationRotationXToAngle(angle:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.rotation.x");
        
        /// 设置动画的属性值和结束值
        animation.fromValue = self.angleX;
        animation.toValue = angle;
        
        /// 设置其他动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeRotationX, forKey: kSpriteKeyMode)
        animation.setValue(angle, forKey: kSpriteKeyRotationX);
        animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,angle-self.angleX, 1.0, 0.0, 0.0)), forKey: kSpriteKey3DTransform);
        
        return animation;
    }
    
    ///获取Y轴旋转动画
    func animationRotationYToAngle(angle:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.rotation.y");
        
        
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.angleY;
        animation.toValue = angle;
        
        
        /// 设置动画的其他属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.timingFunction =  CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
       animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeRotationY, forKey: kSpriteKeyMode)
        animation.setValue(angle, forKey: kSpriteKeyRotationY)
        animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,angle-self.angleY, 0.0, 1.0, 0.0)), forKey: kSpriteKey3DTransform)
        return animation;
    }
    
    /// 获取Z轴旋转动画
    func animationRotationZToAngle(angle:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z");
        
        
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.angleZ;
        animation.toValue = angle;
        
        
        /// 设置动画的其他属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.timingFunction =  CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeRotationZ, forKey: kSpriteKeyMode)
        animation.setValue(angle, forKey: kSpriteKeyRotationZ)
        animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,angle-self.angleZ, 0.0, 0.0, 1.0)), forKey: kSpriteKey3DTransform)
        return animation;
    }
    
    
    ///获取X轴缩放动画
    func  animationScaleXToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        /// 设置动画并制定动画属性
        let animation = CABasicAnimation(keyPath: "transform.scale.x");
        
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.sizeX;
        animation.toValue = size;
        
        
        /// 设置其他动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        
        /// 携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeScaleX, forKey: kSpriteKeyMode);
        animation.setValue(size, forKey: kSpriteKeyScaleX);
        
        if(self.sizeX != 0){
          animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,size/self.sizeX, 0.0, 0.0, 1.0)), forKey: kSpriteKey3DTransform)
        }else{
               animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, size/self.sizeX, 1.0, 1.0)), forKey: kSpriteKey3DTransform)
        }
        return animation;
    }
    
    ///获取Y轴缩放动画
    func animationScaleYToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.scale.y");
        
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.sizeY;
        animation.toValue = size;
        
        
        /// 设置其他动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        
        /// 携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeScaleY, forKey: kSpriteKeyMode);
        animation.setValue(size, forKey: kSpriteKeyScaleY);
        
        if(self.sizeY != 0){
            animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, 1.0, size/self.sizeY, 1.0)), forKey: kSpriteKey3DTransform)
        }else{
            animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform,1.0, size/self.sizeY, 1.0)), forKey: kSpriteKey3DTransform)
        }
        
        
        
        return animation;
    }
    
    ///获取Z轴(2D关系没有效果)缩放动画
    func animationScaleZToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation {

        let animation = CABasicAnimation(keyPath: "transform.scale.z");
        
        /// 设置动画属性初始值和结束值
        animation.fromValue = self.sizeZ;
        animation.toValue = size;
        
        
        /// 设置其他动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        
        /// 携带值
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeScaleZ, forKey: kSpriteKeyMode);
        animation.setValue(size, forKey: kSpriteKeyScaleZ);
        
        if(self.sizeZ != 0){
            animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, 1.0, 1.0, size/self.sizeZ)), forKey: kSpriteKey3DTransform)
        }else{
            animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform,1.0, 1.0, size/self.sizeZ)), forKey: kSpriteKey3DTransform)
        }
        
        return animation;
    }
    
    ///获取XY轴(等比例)缩放动画
    func animationScaleXYToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "transform.scale");
        
        ///设置动画初始值和结束值
        animation.fromValue = self.sizeXY;
        animation.toValue = size;
        
        /// 设置动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        
        animation.autoreverses = autoreverses;
        animation.beginTime = CACurrentMediaTime() + delay;
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        /// 设置携带值
        
        animation.setValue(kSpriteTypeBasic, forKey: kSpriteKeyType)
        animation.setValue(kSpriteModeScaleXY, forKey: kSpriteKeyMode)
        animation.setValue(size, forKey: kSpriteKeyScaleXY);
        if(self.sizeXY != 0){
            animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, size/self.sizeXY*self.sizeX/self.sizeXY, size/self.sizeXY*self.sizeY/self.sizeXY, 1.0)), forKey: kSpriteKey3DTransform);
        }else{
               animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, size, size, 1.0)), forKey: kSpriteKey3DTransform);
        }
        
        return animation;
    }
    
    ///获取路径动画(特殊的位移关键帧动画，优先级高于位移关键帧)
    func animationWithPath(path:UIBezierPath, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CAKeyframeAnimation{
        
        //创建关键帧动画并设置动画属性
        let animation = CAKeyframeAnimation(keyPath: "position");
        animation.path = path.cgPath;
        
        /// 设置其他动画属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay; /// 延迟时间
        animation.calculationMode = self.animationCalculationMode;///计算模式
        animation.fillMode = self.animationFillMode; /// 填充模式
        animation.rotationMode = self.animationRotateMode;/// 旋转模式
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode)
        /// 设置携带值
        animation.setValue(kSpriteTypePath, forKey: kSpriteKeyType);
        animation.setValue(kSpriteModePosition, forKey: kSpriteKeyMode)
        animation.setValue(NSValue.init(cgPoint: path.currentPoint), forKey: kSpriteKeyPosition);
        return animation;

    }
    
    ///获取关键帧动画（!颜色属性无效果）(!Z轴旋转会使XY缩放反向)
    func animationWithMode(mode:KATSpriteMode, keyValues:NSArray, keyTimes:[NSNumber], duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CAKeyframeAnimation{
       
        let animation:CAKeyframeAnimation!
        var keyValues = NSArray(array: keyValues);
        
        switch mode {
        case .POSITION: /// 位移模式
            animation = CAKeyframeAnimation(keyPath: "position");
            
            /// 设置携带值
            animation.setValue(kSpriteModePosition, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyPosition) /// 值
            
            
        case .OPACITY: /// 透明模式
            animation = CAKeyframeAnimation(keyPath: "position");
            /// 设置携带值
            animation.setValue(kSpriteModePosition, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyPosition);///值
      
            
        case .BG_COLOR: /// 背景颜色
            animation = CAKeyframeAnimation(keyPath: "backgroundColor");
            /// 设置携带值
            animation.setValue(kSpriteModeBgColor, forKey: kSpriteKeyMode); // 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyBgColor) /// 值
            
            let bgColors = NSMutableArray();
            for color in keyValues{
                if(color is UIColor){
                    bgColors.add((color as! UIColor).cgColor);
                    
                }
            }
            
            keyValues = bgColors;
            
        case .BORDER_WIDTH:/// 边线宽模式
            animation = CAKeyframeAnimation(keyPath: "borderWidth");
            
            /// 设置携带值
            animation.setValue(kSpriteModeBorderWidth, forKey: kSpriteKeyMode); //  模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyBorderWidth);///值
           
        case .CORNER_RADIUS: /// 圆角模式
            animation = CAKeyframeAnimation(keyPath: "cornerRadius");
            
            /// 设置携带值
            animation.setValue(kSpriteModeCornerRadius, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyCornerRadius) /// 值
            
        case .ROTATION_X:/// x轴旋转
            animation = CAKeyframeAnimation(keyPath: "transform.rotation.x");
            
            /// 设置携带值
            animation.setValue(kSpriteModeRotationX, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyRotationX) ///
             animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,(keyValues.lastObject as! CGFloat) - self.angleX, 1.0, 0.0, 0.0)), forKey: kSpriteKey3DTransform);
            
            
            
        case .ROTATION_Y:/// y轴旋转
            animation = CAKeyframeAnimation(keyPath: "transform.rotation.y");
            
            /// 设置携带值
            animation.setValue(kSpriteModeRotationY, forKey: kSpriteKeyMode);
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyRotationY) /// 值
            animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,(keyValues.lastObject as! CGFloat) - self.angleY, 0.0, 1.0, 0.0)), forKey: kSpriteKey3DTransform)
           
        case .ROTATION_Z: /// z轴旋转
            animation = CAKeyframeAnimation(keyPath: "transform.rotation.z");
            animation.setValue(kSpriteModeRotationZ, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyRotationZ) /// 值
            animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,(keyValues.lastObject as! CGFloat) - self.angleZ, 0.0, 0.0, 1.0)), forKey: kSpriteKey3DTransform)
        case .SCALE_X: /// X轴缩放模式
            animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
            
            ///设置携带值
            animation.setValue(kSpriteModeScaleX, forKey: kSpriteKeyMode) // 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyScaleX) /// 值
            
            if(self.sizeX != 0){
                animation.setValue(NSValue.init(caTransform3D: CATransform3DRotate(self.layer.transform,(keyValues.lastObject as! CGFloat)/self.sizeX, 0.0, 0.0, 1.0)), forKey: kSpriteKey3DTransform)
            }else{
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, (keyValues.lastObject as! CGFloat)/self.sizeX, 1.0, 1.0)), forKey: kSpriteKey3DTransform)
            }
            
        case .SCALE_Y: /// y轴缩放模式
            animation = CAKeyframeAnimation(keyPath: "transform.scale.y");
            
            /// 设置携带值
            animation.setValue(kSpriteModeScaleY, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyScaleY) // 值
            
            if(self.sizeY != 0){
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, 1.0, (keyValues.lastObject as! CGFloat)/self.sizeY, 1.0)), forKey: kSpriteKey3DTransform)
            }else{
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform,1.0, (keyValues.lastObject as! CGFloat)/self.sizeY, 1.0)), forKey: kSpriteKey3DTransform)
            }
            
        case .SCALE_Z: /// z轴的缩放
            animation = CAKeyframeAnimation(keyPath: "transform.scale.z")
            
            /// 设置携带值
            animation.setValue(kSpriteModeScaleZ, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyScaleZ) /// 值
            
            if(self.sizeZ != 0){
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, 1.0, 1.0, (keyValues.lastObject as! CGFloat)/self.sizeZ)), forKey: kSpriteKey3DTransform)
            }else{
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform,1.0, 1.0, (keyValues.lastObject as! CGFloat)/self.sizeZ)), forKey: kSpriteKey3DTransform)
            }
         
        case .SCALE_XY: /// xy缩放
            animation = CAKeyframeAnimation(keyPath: "transform.scale");
            
            /// 设置携带值
            animation.setValue(kSpriteModeScaleXY, forKey: kSpriteKeyMode) /// 模式
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyScaleXY);
            
            if(self.sizeXY != 0){
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, (keyValues.lastObject as! CGFloat)/self.sizeXY*self.sizeX/self.sizeXY, (keyValues.lastObject as! CGFloat)/self.sizeXY*self.sizeY/self.sizeXY, 1.0)), forKey: kSpriteKey3DTransform);
            }else{
                animation.setValue(NSValue.init(caTransform3D: CATransform3DScale(self.layer.transform, (keyValues.lastObject as! CGFloat), (keyValues.lastObject as! CGFloat), 1.0)), forKey: kSpriteKey3DTransform);
            }
            
            
        case .CONTENTS: /// 内容变换模式
            if(self.layer.contents != nil && self.contents!  !=  (self.layer.contents as! UIImage)){
                self.contents = self.layer.contents as? UIImage;
            }
            animation = CAKeyframeAnimation(keyPath: "contents");
            
            /// 设置携带值
            animation.setValue(kSpriteModeContents, forKey: kSpriteKeyMode)
            animation.setValue(keyValues.lastObject, forKey: kSpriteKeyContents)
            
            let images = NSMutableArray();
            for img in keyValues{
                if(img is UIImage){
                    images.add((img as! UIImage).cgImage as Any);
                }
            }
            
            keyValues = images;
            
        default: /// 默认位移模式
            animation = CAKeyframeAnimation(keyPath: "position");
            break;
        }
        
        
        
        animation.values = keyValues as? [Any];
        animation.keyTimes = keyTimes;
        
        
        /// 设置动画的其他属性
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        
        animation.autoreverses = false;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.fillMode = self.animationFillMode; /// 填充模式
        animation.rotationMode = self.animationRotateMode; /// 旋转模式
        
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode); /// 加速模式
        
        /// 设置携带值
        animation.setValue(kSpriteTypeKeyFrame, forKey: kSpriteKeyType) /// 类型
        
        return animation;
    }
    
    /// 获取动画组
    func animationWithGroup(group:[CAAnimation], duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CAAnimationGroup{
        let  animation = CAAnimationGroup();
       /// 设置携带值
        animation.setValue(kSpriteTypeGroup, forKey: kSpriteKeyType) ///类型
        
        var transform  = self.layer.transform;
        let array = NSMutableArray() ; /// //最终放入动画组的数组（过滤重复模式）
       
        for an in group{
            an.beginTime = an.beginTime - CACurrentMediaTime();
            let mode:String = an.value(forKey: kSpriteKeyMode) as! String;
            var key:String = ""
            
            
            if(kSpriteModePosition == mode){ /// 位移模式
               key = kSpriteKeyPosition
                if(animation.value(forKey: key) == nil){ /// 没有该值则插入
                    animation.setValue(an.value(forKey: key), forKey: key);
                    array.add(an);
                }
            }else if (mode == kSpriteModeOpacity){ /// 透明模式
                key = kSpriteKeyOpacity
                if(animation.value(forKey: key) == nil){ ///没有该值则插入
                    animation.setValue(an.value(forKey: key), forKey: key)
                    array.add(an);
                }
            }else if(mode == kSpriteModeBgColor){ /// 背景颜色模式
                key = kSpriteKeyBgColor
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    array.add(an);
                }
            }else if(mode == kSpriteModeBorderColor){ /// 边线色模式
                key = kSpriteKeyBorderColor;
                
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key);
                    array.add(an);
                }
                
            }else if(mode == kSpriteModeBorderWidth){ /// 边线宽模式
                key = kSpriteKeyBorderWidth
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key);
                    array.add(an)
                }
            }else if(mode == kSpriteKeyCornerRadius){ /// 圆角模式
                key = kSpriteKeyCornerRadius
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    array.add(an)
                }
            }else if(mode == kSpriteModeRotationX){ /// X旋转模式
                key = kSpriteModeRotationX
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key);
                    transform = CATransform3DRotate(transform, an.value(forKey: key) as! CGFloat, 1.0, 0.0, 0.0); /// 形变
                    array.add(an);
                }
            }else if(mode == kSpriteModeRotationY){ /// Y旋转模式
                key = kSpriteKeyRotationY;
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key);
                    transform = CATransform3DRotate(transform, an.value(forKey: key) as! CGFloat, 0.0, 1.0, 0.0)
                    array.add(an)
                }
    
            }else if(mode == kSpriteModeRotationZ){ /// z轴旋转模式
                key = kSpriteKeyRotationZ
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    transform = CATransform3DRotate(transform, an.value(forKey: key) as! CGFloat, 0.0, 0.0, 1.0);
                    array.add(an);
                }
                
            }else if(mode == kSpriteModeScaleX){ /// x缩放模式
                key = kSpriteKeyScaleX;
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    if(self.sizeX != 0.0){
                        transform = CATransform3DScale(transform, (an.value(forKey: key) as! CGFloat)/self.sizeX, 1.0, 1.0); /// 形变
                        
                    }else{
                        transform = CATransform3DScale(transform, (an.value(forKey: key) as! CGFloat), 1.0, 1.0); /// 形变
                    }
                    array.add(an);
                }
                
                
            }else if(mode == kSpriteModeScaleY){ /// y缩放
                key = kSpriteKeyScaleY
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    if(self.sizeY != 0.0){
                        transform = CATransform3DScale(transform, 1.0, (an.value(forKey: key) as! CGFloat)/self.sizeY, 1.0); /// 形变
                    }else{
                        transform = CATransform3DScale(transform, 1.0, (an.value(forKey: key) as! CGFloat), 1.0); /// 形变
                    }
                    
                    array.add(an)
                }
            } else if(mode == kSpriteModeScaleZ){
                key = kSpriteKeyScaleZ;
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key);
                    if(self.sizeZ != 0){
                        transform = CATransform3DScale(transform, 1.0,1.0,  (an.value(forKey: key) as! CGFloat)/self.sizeZ); /// 形变
                    }else{
                        transform = CATransform3DScale(transform, 1.0,1.0,  (an.value(forKey: key) as! CGFloat)); /// 形变
                    }
                    array.add(an)
                }
                
                
            }else if(mode == kSpriteModeScaleXY){
                key = kSpriteKeyScaleXY;
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    if(self.sizeXY != 0.0){
                        transform = CATransform3DScale(transform, (an.value(forKey: key) as! CGFloat)/self.sizeXY, (an.value(forKey: key) as! CGFloat)/self.sizeXY,  1.0); /// 形变
                    }else{
                        transform = CATransform3DScale(transform, (an.value(forKey: key) as! CGFloat), (an.value(forKey: key) as! CGFloat),  1.0); /// 形变
                    }
                    array.add(an);
                    
                }
                
            }else if(mode == kSpriteModeContents){
                key = kSpriteKeyContents;
                if(animation.value(forKey: key) == nil){
                    animation.setValue(an.value(forKey: key), forKey: key)
                    array.add(an);
                }
            }
        
        
        }
        
        animation.setValue(NSValue.init(caTransform3D: transform), forKey: kSpriteKey3DTransform);
        animation.animations = array as? [CAAnimation] /// 设置动画组
        
        animation.duration = duration;
        animation.repeatCount = repeatCount;
        animation.autoreverses = autoreverses
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.fillMode = self.animationFillMode
        animation.timingFunction = CAMediaTimingFunction(name: self.animationTimingMode);
        
        
        
        return animation;
    }
    
    
}

// MARK:动画执行
extension KATSprite{
    
    
    ///开始动画(设置动画名字),同一时间只能执行一个动画（组）
    func startAnimation(animation:CAAnimation, name:String, delay:Double) {
        animation.delegate = self;
        animation.beginTime = CACurrentMediaTime() + delay; /// 设置开始的时间
        animation.setValue(name, forKey: kSpriteKeyName);
        if(!self.animating){/// 当前没有动画在执行
//            let mode = animation.value(forKey: kSpriteKeyMode) as! String;
            if let mode = animation.value(forKey: kSpriteKeyMode){
                if((mode as! String)  == kSpriteModePosition){ /// 包含位移动画，则在动画中取消交互
                    self.interactInAnimating = false;
                }
            }
            
            self.animating = true;
            self.layer.add(animation, forKey: name);
            
        }else{
            self.animationQueue.append(animation);
        }
        
        
        
    }
    
    /// 开始动画 默认名字
    func startAnimation(animation:CAAnimation, delay:Double) {
        if(animation.value(forKey: kSpriteKeyName) != nil){ /// 本身带名字的(队列里的动画)
            self.startAnimation(animation: animation, name: animation.value(forKey: kSpriteKeyName) as! String, delay: delay)
        }else{
            self.startAnimation(animation: animation, name: kSpriteDefaultName, delay: delay);
        }
        
    }
    
   
    
    
    /// 暂停动画
    func pauseAnimation(){
        if(self.layer.speed > 0){ ///取得指定图层动画的媒体时间，后面参数用于指定子图层，这里不需要
            let interval = self.layer.convertTime(CACurrentMediaTime(), from: nil);
            //设置时间偏移量，保证暂停时停留在旋转的位置
            self.layer.timeOffset = interval;
            /// 速度设置为0 暂停动画
            self.layer.speed = 0;
        }
        
    }
    
    
    /// 恢复动画
    func resumeAnimation(){
        if(self.layer.speed < 1.0){
            let beginTime = CACurrentMediaTime() - self.layer.timeOffset;
            
            /// 设置偏移量
            self.layer.timeOffset = 0;
            
            /// 设置开始的时间
            self.layer.beginTime = beginTime;
            
            /// 设置动画速度 开始运行
            self.layer.speed = 1.0;
        }
    }
    
    
    ///开始系统刷屏动作(interval表示每间隔几帧刷屏执行一次，1代表每帧执行一次，约为每秒60次),不能同时进行多个刷屏动作，新的会替换旧的
    func startDisplayLinkActions(actions:@escaping ()->(), interval:Int){
        stopDisplayLinkActions() ///首先停止之前的刷屏动画
        self.displayLinkTimer = CADisplayLink(target: self, selector: #selector(displayLinkActionsRun));
        self.displayLinkTimer?.frameInterval = interval;
        self.displayLinkActions = actions;
        
        //添加定时器对象到主运行循环
        //可以同时加入NSDefaultRunLoopMode和UITrackingRunLoopMode来保证它不会被滑动打断，也不会被其他UIKit控件动画影响性能
        self.displayLinkTimer?.add(to: RunLoop.main, forMode: .defaultRunLoopMode);
        self.displayLinkTimer?.add(to: RunLoop.main, forMode: .UITrackingRunLoopMode);
        self.displayLinkActionsRunning = true;
        
        
    }
    
    ///停止并移除系统刷屏动作
    func stopDisplayLinkActions(){
        if(self.displayLinkTimer != nil){
            self.displayLinkTimer = nil;
            self.displayLinkActionsRunning = false;
            if(self.displayLinkActions != nil){
                self.displayLinkActions = nil;
            }
        }
        
    }
    ///清除所有动画(包括当前动画和队列里的动画)
    func clearAnimations(){
        if(self.animationQueue.count != 0){
            self.animationQueue.removeAll();
        }
        self.stopAnimation();
    }
    
    
    ///停止并移除当前动画
    func stopAnimation(){
        /// 首先取消暂停
        self.resumeAnimation();
        
        if(self.keepStateOnStop && self.currentAnimation != nil){ /// 停止时保持现场
            let present = self.layer.presentation()
            if(present != nil){ /// 获取当前的内容层
                if(self.animating){ /// 动画中
                let  type = self.currentAnimation?.value(forKey: kSpriteKeyType) as! String /// 类型
                    if(kSpriteTypeBasic == type || kSpriteTypeKeyFrame == type){ /// 关键帧动画 基础动画
                        let mode = self.currentAnimation?.value(forKey: kSpriteKeyMode) as! String
                        
                        if(mode == kSpriteModePosition){ /// 位移模式
                            self.layer.position = present!.position;
                            
                        }else if(mode == kSpriteModeRotationX || mode == kSpriteModeRotationY || mode == kSpriteModeRotationZ){//x y z轴旋转模式
                            self.layer.transform = present!.transform;
                            /// 保存变换的角度
                            self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
                            self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
                            self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
                            
                            /// 保存变换的尺寸
                            self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
                            self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
                            self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
                            self.sizeXY = (self.sizeX+self.sizeY)/2.0;
                            
                            
                        }else if(mode == kSpriteModeScaleX || mode == kSpriteModeScaleY || mode == kSpriteModeScaleZ){// x y z轴缩放模式
                            
                            self.layer.transform = present!.transform;
                            /// 保存变换的角度
                            self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
                            self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
                            self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
                            
                            /// 保存变换的尺寸
                            self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
                            self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
                            self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
                            self.sizeXY = (self.sizeX+self.sizeY)/2.0;
                            
                        } else if(mode == kSpriteModeOpacity){ /// 不透明模式
                            self.layer.opacity = present!.opacity;
                        }else if(mode == kSpriteModeBgColor){ /// 背景色模式
                            /// 无效设置
                            self.layer.backgroundColor = present?.backgroundColor;
                        }else if(mode == kSpriteModeCornerRadius){ /// 圆角半径模式
                            self.layer.cornerRadius = present!.cornerRadius;
                        }else if(mode == kSpriteModeBorderWidth){ /// 边线宽模式
                            self.layer.borderWidth = present!.borderWidth;
                        }else if(mode == kSpriteModeBorderColor){ /// 边线色模式
                            // 无效的设置
//                            self.layer.borderColor = present!.borderColor;
                        }else if(mode == kSpriteModeContents){ /// 内容模式
                            self.layer.contents = present!.contents;
                        }
 
                    }else if(type == kSpriteTypePath){ //路径类型
                        
                          let mode = self.currentAnimation!.value(forKey: kSpriteKeyMode) as! String
                        if(mode == kSpriteModePosition){
                            self.layer.position = present!.position
                            self.layer.transform = present!.transform;
                            
                            /// 保存变换的角度
                            self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
                            self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
                            self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
                            
                            /// 保存变换的尺寸
                            self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
                            self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
                            self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
                            self.sizeXY = (self.sizeX+self.sizeY)/2.0;
               
                        }
                        
                        
                        
                        
                    }else if(type == kSpriteTypeGroup){ //组类型
                        self.layer.position = present!.position;
                        self.layer.opacity = present!.opacity;
                        self.layer.borderWidth = present!.borderWidth;
                        self.layer.cornerRadius = present!.cornerRadius;
                        self.layer.transform = present!.transform;
                        self.layer.contents = present!.contents;
                        
                        
                        
                        /// 保存变换的角度
                        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
                        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
                        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
                        
                        /// 保存变换的尺寸
                        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
                        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
                        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
                        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
                        
                    }
                    
                    
                    
                }else { /// 非动画中
                    
                }
                
                
                
                
            }else{/// 当前的内容层为空
                
                
                
            }
            
            
            
            
        }
        
        
        
        self.layer.removeAllAnimations(); /// 清楚所有的动画
        self.animating = false;
    }
    
    // MARK:完成后保持动画状态
    func keepFinishState(){
        
    }
    
    @objc func displayLinkActionsRun(){
        if((self.displayLinkActions) != nil){
            self.displayLinkActions!();
        }
    }
    
}


// MARK: 动画变形
extension KATSprite{

    ///旋转(相对初始值)
    func transformRotateToAngle(angle:CGFloat){
        self.layer.transform = CATransform3DRotate(CATransform3DIdentity, angle, 0.0, 0.0, 1.0);
        
        // 保存变换角度
        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
        
        /// 保存变换的尺寸
        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
        
        
    }
    ///旋转X轴（上下转）
    func transformRotateXToAngle(angle:CGFloat){
        var transform = CATransform3DIdentity;
        transform.m34 = self.perspective; /// 透视点
        self.layer.transform = CATransform3DRotate(transform, angle, 1.0, 0.0, 0.0)
        
        // 保存变换角度
        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
        
        /// 保存变换的尺寸
        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
        
        
    }
    
    ///旋转Y轴（左右转）
    func transformRotateYToAngle(angle:CGFloat){
        
        var transform = CATransform3DIdentity;
        transform.m34 = self.perspective; /// 透视点
        self.layer.transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0)
        
        // 保存变换角度
        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
        
        /// 保存变换的尺寸
        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
        
        
    }
    
    ///水平镜像(相对初始值)
    func transformHorizontalMirror(){
        
        self.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(Double.pi), 1.0, 0.0, 0.0);
        // 保存变换角度
        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
        
        /// 保存变换的尺寸
        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
        
        
        
    }
    
    /// 垂直镜像(相对初始值)
    func transformVerticalMirror(){
        self.layer.transform = CATransform3DRotate(CATransform3DIdentity, CGFloat(Double.pi), 0.0, 1.0, 0.0);
        // 保存变换角度
        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
        
        /// 保存变换的尺寸
        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
    }
    
    ///缩放(相对初始值)(宽高,比例,1为原始值)
    func transformScaleToWitdh(width:CGFloat, height:CGFloat){
        self.layer.transform = CATransform3DScale(CATransform3DIdentity, width, height, 1.0);
        
        
        // 保存变换角度
        self.angleX = self.layer.value(forKey:"transform.rotation.x") as! CGFloat
        self.angleY = self.layer.value(forKey: "transform.rotation.y") as! CGFloat
        self.angleZ = self.layer.value(forKey: "transform.rotation.z") as! CGFloat
        
        /// 保存变换的尺寸
        self.sizeX = self.layer.value(forKey: "transform.scale.x") as! CGFloat;
        self.sizeY = self.layer.value(forKey: "transform.scale.y") as! CGFloat;
        self.sizeZ = self.layer.value(forKey: "transform.scale.z") as! CGFloat;
        self.sizeXY = (self.sizeX+self.sizeY)/2.0;
        
        
        
    }
    
    ///复位
    func restoreSprite(){
        self.stopAnimation();
        self.layer.transform = CATransform3DIdentity;
        self.sizeX = 1.0
        self.sizeY = 1.0
        self.sizeZ = 1.0
        self.sizeXY = 1.0
        
        self.angleX = 0.0
        self.angleY = 0.0
        self.angleZ = 0.0
        
        self.layer.opacity = 1.0
        
        if(self.contents != nil){
            self.layer.contents = contents?.cgImage;
        }
        
        
        
        
        
    }
    
    ///内容调整尺寸
    func resizeForContents(){
        
        
    }
    
    
    
    // MARK:-常用动画
    ///心跳(等比缩放)(参数小于0则用默认值)
    func heartbeatWithScale(scale:CGFloat, duration:Double,repeatCount:Float){
        
        self.startAnimation(animation: self.animationScaleXToSize(size: scale < 0 ? 1.16:scale, duration: duration < 0 ? 0.6:duration, repeatCount: repeatCount, autoreverses: true, delay: 0.0), name: kSpriteAnimationHeartbeat, delay: 0.0);
        
        
    }
    
    ///闪烁(透明变化)(参数小于0则用默认值)
    func  blinkWithAlpha(alpha:CGFloat, duration:Double, repeatCount:Float) {
        
        self.startAnimation(animation: self.animationToOpacity(opacity: alpha<0 ? 0.2 : alpha, duration: duration < 0.3 ? 0.3:duration, repeatCount: repeatCount, autoreverses: true, delay: 0.0), name: kSpriteAnimationBlink, delay: 0);
    }
    
    ///转动(Z轴旋转)(参数小于0则用默认值)
    func rotateWithDuration(duration:Double, repeatCount:Float, clockwise:Bool){
        self.animationTimingMode = kCAMediaTimingFunctionLinear
        self.startAnimation(animation: self.animationRotationZToAngle(angle: clockwise ? (self.angleZ + CGFloat.pi * 2) : (self.angleZ - CGFloat.pi * 2), duration: duration, repeatCount: repeatCount, autoreverses: false, delay: 0.0), name: kSpriteAnimationRotate, delay: 0)
    }
    
    ///翻转(XY轴旋转)(参数小于0则用默认值)
    func flipWithDuration(duration:Double, repeatCount:Float, clockwise:Bool, vertical:Bool){
         self.animationTimingMode=kCAMediaTimingFunctionLinear;
        if(vertical){
            startAnimation(animation: self.animationRotationXToAngle(angle: clockwise ? (self.angleZ + CGFloat.pi * 2) : (self.angleZ - CGFloat.pi * 2), duration: duration, repeatCount: repeatCount, autoreverses: false, delay: 0.0), name: kSpriteAnimationRotate, delay: 0.0)
        }else{
             startAnimation(animation: self.animationRotationYToAngle(angle: clockwise ? (self.angleZ + CGFloat.pi * 2) : (self.angleZ - CGFloat.pi * 2), duration: duration, repeatCount: repeatCount, autoreverses: false, delay: 0.0), name: kSpriteAnimationRotate, delay: 0.0)
            
        }
        
    }
    
    /// 摇晃(左右)(参数小于0则用默认值)
    func shakeWithDegree(degree:CGFloat, duration:Double, repeatCount:Float){
        
        let  keyValues = [CGPoint(x: self.layer.position.x - degree, y: self.layer.position.y), self.layer.position, CGPoint(x: self.layer.position.x + degree, y: self.layer.position.y), self.layer.position];
        
        let keyTimes = [0.25,0.5,0.75, 1.0];
        
        self.startAnimation(animation: self.animationWithMode(mode: .POSITION, keyValues: keyValues as NSArray, keyTimes: keyTimes as [NSNumber], duration: duration, repeatCount: repeatCount, autoreverses: false, delay: 0.0), name: kSpriteAnimationShake, delay: 0)
        
        
    }
    
    //////震动(上下)(参数小于0则用默认值)
    func shockWithDegree(degree:CGFloat, duration:Double, repeatCount:Float){
        
        
        
        let  keyValues = [CGPoint(x: self.layer.position.x , y: self.layer.position.y - degree ), self.layer.position, CGPoint(x: self.layer.position.x , y: self.layer.position.y + degree), self.layer.position];
        
        let keyTimes = [0.25,0.5,0.75, 1.0];
        
        self.startAnimation(animation: self.animationWithMode(mode: .POSITION, keyValues: keyValues as NSArray, keyTimes: keyTimes as [NSNumber], duration: duration, repeatCount: repeatCount, autoreverses: false, delay: 0.0), name: kSpriteAnimationShock, delay: 0)
        
        
        
    }
    
    ///抖动(旋转)(参数小于0则用默认值)
    func ditherWithDegree(degree:CGFloat = 2.0, duration:Double = 0.1, repeatCount:Float){
        
        let  keyValues = [self.angleZ - CGFloat.pi/180.0 * degree, self.angleZ, self.angleZ + CGFloat.pi/180.0 * degree, self.angleZ];
    
        let keyTimes = [0.25,0.5,0.75, 1.0];
        
        startAnimation(animation: animationWithMode(mode: .ROTATION_Z, keyValues: keyValues as NSArray, keyTimes: keyTimes as [NSNumber], duration: duration, repeatCount: repeatCount, autoreverses: false, delay: 0.0), name: kSpriteAnimationDither, delay: 0.0)
    
    }
    
    ///消失(透明变化)
    func disappearWithDuration(duration:Double = 0.6){
        startAnimation(animation: animationToOpacity(opacity: 0.0, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), name: kSpriteAnimationDisappear, delay: 0)
    }
    
    ///出现(透明变化)
    func appearWithDuration(duration:Double = 0.6){
         startAnimation(animation: animationToOpacity(opacity: 1.0, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), name: kSpriteAnimationAppear, delay: 0)
    }
    
    ///消失(缩放变化)
    func scaledDisappearWithDuration(duration:Double = 0.6){
        startAnimation(animation: animationScaleXYToSize(size: 0.0, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), name: kSpriteAnimationScaledDisappear, delay: 0)
    }
    
    /// 出现(缩放变化)
    func scaledAppearWithDuration(duration:Double){
        if(self.sizeXY == 0){
            self.restoreSprite();/// 复位动画
        }
        startAnimation(animation: animationScaleXYToSize(size: 1.0, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), name: kSpriteAnimationScaledDisappear, delay: 0)
        
        
    }
    
    
    
    ///焦点出(缩放、透明变化)
    func zoomOutWithScale(scale:CGFloat = 1.62, duration:Double = 1.38){
    
        startAnimation(animation: animationWithGroup(group: [animationWithMode(mode: .SCALE_XY, keyValues: [1.0,scale], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0),animationWithMode(mode: .OPACITY, keyValues: [1.0, 0.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationZoomOut, delay: 0.0);
        
        
    }
    
    /// 焦点进(缩放、透明变化)
    func zoomInWithScale(scale:CGFloat = 1.62, duration:Double = 1.38){
        
        startAnimation(animation: animationWithGroup(group: [animationWithMode(mode: .SCALE_XY, keyValues: [scale, 1.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0),animationWithMode(mode: .OPACITY, keyValues: [0.0, 1.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationZoomOut, delay: 0.0);
        
    }
    
    ///滚动(旋转、位移变化)
    func  rollToPosition(position:CGPoint, duration:Double){
        /// 半径
        let radius = (self.layer.bounds.size.width + self.layer.bounds.size.height)/2.0/2.0 ; /// 半径
        let distance = KATMath.distance(pointA: position, pointB: self.layer.position) /// 距离
        let clockwise = position.x >= self.layer.position.x ? true : false
        self.animationTimingMode = kCAMediaTimingFunctionLinear;
    
        startAnimation(animation: animationWithGroup(group: [animationToPosition(position: position, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), animationRotationZToAngle(angle: self.angleZ + (clockwise ? (distance/radius):(-distance/radius)), duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), name: kSpriteAnimationRoll, delay: 0.0)
        
        
        
        
    }
    
    ///滚进(旋转、位移、透明变化)
    func rollInToPosition(position:CGPoint, duration:Double){
       
        let radius = (self.layer.bounds.size.width + self.layer.bounds.size.height)/2.0/2.0 ; /// 半径
        let distance = KATMath.distance(pointA: position, pointB: self.layer.position) /// 距离
        let clockwise = position.x >= self.layer.position.x ? true : false
        
        self.animationTimingMode = kCAMediaTimingFunctionLinear;
        
        startAnimation(animation: self.animationWithGroup(group: [animationToPosition(position: position, duration: duration, repeatCount: 1, autoreverses: false, delay: 0), animationRotationZToAngle(angle: self.angleZ + (clockwise ? (distance/radius):(-distance/radius)), duration: duration, repeatCount: 1, autoreverses: false, delay: 0),animationWithMode(mode: .OPACITY, keyValues: [0.0, 1.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationRollIn, delay: 0)

        
    }
    
    ///滚出(旋转、位移、透明变化)
    func rollOutToPosition(position:CGPoint, duration:Double){
        
        
        let radius = (self.layer.bounds.size.width + self.layer.bounds.size.height)/2.0/2.0 ; /// 半径
        let distance = KATMath.distance(pointA: position, pointB: self.layer.position) /// 距离
        let clockwise = position.x >= self.layer.position.x ? true : false
        
        self.animationTimingMode = kCAMediaTimingFunctionLinear;
        
        startAnimation(animation: animationWithGroup(group: [animationToPosition(position: position, duration: duration, repeatCount: 1, autoreverses: false, delay: 0),animationRotationZToAngle(angle: self.angleZ+(clockwise ? (distance/radius) : (-distance/radius)), duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0),animationWithMode(mode: .OPACITY, keyValues: [1.0,0.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationRollOut, delay: 0);
        
        
        
    }
    
    ///转进(旋转、缩放、透明变化)
    func rotateInWithCircles(circles:Int = 3, duration:Double = 1.38){
        self.animationTimingMode = kCAMediaTimingFunctionLinear;
        startAnimation(animation: animationWithGroup(group: [animationWithMode(mode: .SCALE_XY, keyValues: [0.0,1.0], keyTimes: [0.0,1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), animationWithMode(mode: .OPACITY, keyValues: [0.0, 1.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), animationRotationZToAngle(angle: self.angleZ + CGFloat.pi * 2, duration: duration/Double(circles), repeatCount: 1, autoreverses: false, delay: 0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationRotateIn, delay: 0)
        
        
    }
    
    ///转出(旋转、缩放、透明变化)
    func rotateOutWithCircles(circles:Int = 3, duration:Double = 1.38){
        self.animationTimingMode = kCAMediaTimingFunctionLinear;
        startAnimation(animation: animationWithGroup(group: [animationWithMode(mode: .SCALE_XY, keyValues: [1.0,0.0], keyTimes: [0.0,1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), animationWithMode(mode: .OPACITY, keyValues: [1.0, 0.0], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), animationRotationZToAngle(angle: self.angleZ - CGFloat.pi * 2, duration: duration/Double(circles), repeatCount: 1, autoreverses: false, delay: 0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationRotateIn, delay: 0)
        
    }
    
    ///掉落
    func dropToPosition(position:CGPoint, duration:Double){
        
         self.animationTimingMode=kCAMediaTimingFunctionEaseIn;
         let path = UIBezierPath()
         path.move(to: self.layer.position)
        /// 路径
         path.addQuadCurve(to: position, controlPoint: CGPoint(x: position.x, y: position.y))
        
        /// 角度
        let angle = atan2(position.x - self.layer.position.x, position.y - self.layer.position.y);
        startAnimation(animation: animationWithGroup(group: [animationWithPath(path: path, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0),animationWithMode(mode: .ROTATION_Z, keyValues: [self.angleZ - angle,self.angleZ,self.angleZ + angle, self.angleZ], keyTimes: [0.0, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationDrop, delay: 0)
        
    }
    
    ///飘落
    func floatToPosition(position:CGPoint, duration:Double){
       
      
        let distance = KATMath.distance(pointA: position, pointB: self.layer.position) /// 距离
        let angle = atan2(position.x - self.layer.position.x, position.y - self.layer.position.y)
        /// 路径
        let path = UIBezierPath()
        path.move(to: self.layer.position)
        
        path.addCurve(to: position, controlPoint1: CGPoint(x: (position.x+self.layer.position.x)/2.0-(distance/2.00/tan(CGFloat.pi/6.0)*sin(CGFloat.pi/2.0-angle)), y: (position.y+self.layer.position.y)/2.0-(distance/2.0/tan(CGFloat.pi/2.0-CGFloat.pi/6.0)*cos(CGFloat.pi/2.0-angle))), controlPoint2: CGPoint(x:(position.x+self.layer.position.x)/2.0+(distance/2.0/tan(CGFloat.pi/6.0)*sin(CGFloat.pi/2.0+angle)), y:(position.y+self.layer.position.y)/2.0+(distance/2.0/tan(CGFloat.pi/2.0-CGFloat.pi/6.0)*cos(CGFloat.pi/2.0-angle))))
        
        ///调整z轴
        self.layer.zPosition = self.layer.zPosition + self.layer.bounds.size.height;
        self.animationTimingMode = kCAMediaTimingFunctionLinear;
        startAnimation(animation: animationWithGroup(group: [animationWithPath(path: path, duration: duration, repeatCount: 1, autoreverses: false, delay: 0),animationWithMode(mode: .ROTATION_Z, keyValues: [self.angleZ - angle, self.angleZ - angle + CGFloat.pi, self.angleZ - angle], keyTimes: [0.0, 0.5, 1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0),animationWithMode(mode: .ROTATION_X, keyValues: [self.angleX, self.angleX+CGFloat.pi, self.angleX], keyTimes: [0.0,0.5,1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationFloat, delay: 0)
    
    }
    
    ///快速移动
    func moveQuicklyToPosition(position:CGPoint, degree:Double, duration:Double){
        
        var directionX:Double = 0.0
        var directionY:Double = 0.0
        if(position.x > self.layer.position.x){
            directionX = 1.0
        }else{
            directionX = -1.0
        }
        
        if(position.y > self.layer.position.y){
            directionY = 1.0
        }else{
            directionY = -1.0
        }
        
        self.animationTimingMode = kCAMediaTimingFunctionEaseInEaseOut;
        
        startAnimation(animation:animationWithMode(mode: .POSITION, keyValues: [self.layer.position,CGPoint(x: Double(position.x) + directionX * degree, y: Double(position.y) + directionY * degree), CGPoint(x: Double(position.x) - directionX*degree*0.4, y: Double(position.y) - directionY*degree*0.4), CGPoint(x: Double(position.x) + directionX*degree*0.2, y: Double(position.y) + directionY*degree*0.2),self.layer.position], keyTimes: [0.0,0.55,0.7,0.85,1.0], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationMoveQuickly, delay: 0);
        
    }
    
    ///移动
    func moveToPosition(position:CGPoint, duration:Double){
        self.startAnimation(animation: animationToPosition(position: position, duration: duration, repeatCount: 1, autoreverses: false, delay: 0.0), name: kSpriteAnimationMove, delay: 0)
    }
    
    ///移动出现
    func comeInToPosition(position:CGPoint, duration:Double){
        self.startAnimation(animation: animationWithGroup(group: [animationToPosition(position: position, duration: duration, repeatCount: 1, autoreverses: false, delay: 0),animationToOpacity(opacity: 1.0, duration: duration, repeatCount: 1.0, autoreverses: false, delay: 0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationComeIn, delay: 0)
    }
    
    /// 移动消失
    func goOutToPosition(position:CGPoint, duration:Double){
                self.startAnimation(animation: animationWithGroup(group: [animationToPosition(position: position, duration: duration, repeatCount: 1, autoreverses: false, delay: 0),animationToOpacity(opacity: 0.0, duration: duration, repeatCount: 1.0, autoreverses: false, delay: 0)], duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationComeIn, delay: 0)
    }
    
    /// 跳跃
    func jumpToPosition(position:CGPoint, height:CGFloat, duration:Double){
        let x1 = position.x - self.layer.position.x
        let y1 = self.layer.position.y - position.y
        
        let k = height
        let h = x1/(sqrt(1.0 - y1/k) + 1.0)
        let path = UIBezierPath()
        path.move(to: self.layer.position)
        path.addQuadCurve(to: self.layer.position, controlPoint: CGPoint(x: self.layer.position.x + h, y: self.layer.position.y - k - (k-y1/2.0)))
        self.animationTimingMode = kCAMediaTimingFunctionEaseInEaseOut
        startAnimation(animation: animationWithPath(path: path, duration: duration, repeatCount: 1, autoreverses: false, delay: 0), name: kSpriteAnimationJump, delay: 0.0);
        
    }
    
    
}


// MARK:- 实现CAAnimationDelegate协议 动画执行
extension KATSprite:CAAnimationDelegate{
     /// 动画开始
    func animationDidStart(_ anim: CAAnimation) {
        self.animating = true
        self.animationStoped = false;
        self.currentAnimation = anim;
        if(!self.interactInAnimating){
            self.isUserInteractionEnabled = false;
        }
        
        if(!self.restoreAfterAnimating && !anim.autoreverses){
            keepFinishState()
        }
        
        /// 回调
        if(self.spriteDelegate != nil){
            self.spriteDelegate!.sprite!(self, didStartAnimation: anim.value(forKey: kSpriteKeyName) as! String);
        }
 
    }
    
    /// 动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        self.isUserInteractionEnabled = true; ///结束动画时恢复交互事件
        self.layer.beginTime = 0; /// 恢复开始的时间
        let aniName = anim.value(forKey: kSpriteKeyName) as! String;
        //飘落动画，需要调整Z轴
        if(aniName == kSpriteAnimationFloat){
            self.layer.zPosition = self.layer.zPosition - self.layer.bounds.size.height;
        }
        
        // 回调
        if(self.spriteDelegate != nil){
            self.spriteDelegate?.sprite(self, didStopAnimation: anim.value(forKey: kSpriteKeyName) as! String, finished: flag);
        }
        
        /// 执行队列剩下的动画
        if(self.animationQueue.count != 0){ /// 全部执行完
            let nextAnimation = self.animationQueue.first!;
            if(kSpriteModePosition == (nextAnimation.value(forKey: kSpriteKeyMode) as! String)){
                self.interactInAnimating = false;
            }
            nextAnimation.beginTime = CACurrentMediaTime() /// 队列里面的动画取消延迟时间
            self.layer.add(nextAnimation, forKey: nextAnimation.value(forKey: kSpriteKeyName) as? String);
            
        }else{
            self.currentAnimation = nil;
            self.animationStoped = false;
            self.animating = false;
            
        }
 
    }

    
    /// 重新播放
    func replay(){
        
    }
    
    /// 播放（继续播放）
    func play(){
        
    }
    
    ///停止
    func stop(){
        
        
    }
}
