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
    fileprivate var animation:CAAnimation? = nil
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
    var animationTimingMode = "kCAMediaTimingFunctionDefault"
    
    
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
        let animation = CABasicAnimation(keyPath: "opacity");
        
        return animation;
    }
    
    
    /// 获取背景颜色动画
    func animationBgToColor(color:UIColor, duration:Double, repeatCount:Float, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    /// 获取边线颜色动画
    func animationBorderToColor(color:UIColor, duration:Double, repeatCount:Float, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    /// 获取边线宽动画
    func animationBorderToWidth(width:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取圆角半径动画
    func animationCornerToRadius(radius:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取X轴旋转动画
    func animationRotationXToAngle(angle:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取Y轴旋转动画
    func animationRotationYToAngle(angle:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    /// 获取Z轴旋转动画
    func animationRotationZToAngle(angle:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    
    ///获取X轴缩放动画
    func  animationScaleXToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取Y轴缩放动画
    func animationScaleYToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取Z轴(2D关系没有效果)缩放动画
    func animationScaleZToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取XY轴(等比例)缩放动画
    func animationScaleXYToSize(size:CGFloat, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CABasicAnimation{
        let animation = CABasicAnimation(keyPath: "");
        
        return animation;
    }
    
    ///获取路径动画(特殊的位移关键帧动画，优先级高于位移关键帧)
    func animationWithPath(path:UIBezierPath, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "");
        
        return animation;

    }
    
    ///获取关键帧动画（!颜色属性无效果）(!Z轴旋转会使XY缩放反向)
    func animationWithMode(mode:Int, keyValues:NSArray, keyTimes:NSArray, duration:Double, repeatCount:Float, autoreverses:Bool, delay:Double) -> CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "");
        
        return animation;
    }
    
    /// 获取动画组
    func animationWithGroup() -> CAAnimationGroup{
        let  animation = CAAnimationGroup();
        return animation;
    }
    
    
}



// MARK:- 实现CAAnimationDelegate协议 动画执行
extension KATSprite:CAAnimationDelegate{
     /// 动画开始
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    /// 动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
    }
    
    ///开始动画(设置动画名字),同一时间只能执行一个动画（组）
    func startAnimation(animation:CAAnimation, name:String = kSpriteDefaultName, delay:Double) {
        
    }
    
     ///停止并移除当前动画
    func stopAnimation(){
        
    }
    /// 暂停动画
    func pauseAnimation(){
        
        
    }
    /// 恢复动画
    func resumeAnimation(){
        
    }
    
    ///开始系统刷屏动作(interval表示每间隔几帧刷屏执行一次，1代表每帧执行一次，约为每秒60次),不能同时进行多个刷屏动作，新的会替换旧的
    func startDisplayLinkActions(actions:@escaping ()->(), interval:Int){
        
    }
    
    ///停止并移除系统刷屏动作
    func stopDisplayLinkActions(){
        
        
    }
    ///清除所有动画(包括当前动画和队列里的动画)
    func clearAnimations(){
        
    }
    
    // MARK:- 变形
    ///旋转(相对初始值)
    func transformRotateToAngle(angle:CGFloat){
        
    }
    ///旋转X轴（上下转）
    func transformRotateXToAngle(angle:CGFloat){
        
    }
    
    ///旋转Y轴（左右转）
    func transformRotateYToAngle(angle:CGFloat){
        
    }
    
    ///水平镜像(相对初始值)
    func transformHorizontalMirror(){
        
    }
    
    /// 垂直镜像(相对初始值)
    func transformVerticalMirror(){
        
    }
    
    ///缩放(相对初始值)(宽高,比例,1为原始值)
    func transformScaleToWitdh(width:CGFloat, height:CGFloat){
        
    }
    
    ///复位
    func restoreSprite(){
        
    }
    
    ///内容调整尺寸
    func resizeForContents(){
        
        
    }
    
    
    // MARK:-常用动画
    ///心跳(等比缩放)(参数小于0则用默认值)
    func heartbeatWithScale(scale:CGFloat, duration:Double,repeatCount:Float){
        
    }
    
    ///闪烁(透明变化)(参数小于0则用默认值)
    func  blinkWithAlpha(alpha:CGFloat, duration:Double, repeatCount:Float) {
        
    }
    
    ///转动(Z轴旋转)(参数小于0则用默认值)
    func rotateWithDuration(duration:Double, repeat:CGFloat, clockwise:Bool){
        
        
    }
    
    ///翻转(XY轴旋转)(参数小于0则用默认值)
    func flipWithDuration(duration:Double, repeatCount:Float, clockwise:Bool, vertical:Bool){
        
    }
    
    /// 摇晃(左右)(参数小于0则用默认值)
    func shakeWithDegree(degree:CGFloat, duration:Double, repeatCount:Float){
        
    }
    
    //////震动(上下)(参数小于0则用默认值)
    func shockWithDegree(degree:CGFloat, duration:Double, repeatCount:Float){
        
    }
    
    ///抖动(旋转)(参数小于0则用默认值)
    func ditherWithDegree(degree:CGFloat, duration:Double, repeatCount:Float){
        
    }
    
    ///消失(透明变化)
    func disappearWithDuration(duration:Double){
        
    }

    ///出现(透明变化)
    func appearWithDuration(duration:Double){
        
    }

 ///消失(缩放变化)
    func scaledDisappearWithDuration(duration:Double){
        
    }

   /// 出现(缩放变化)
    func scaledAppearWithDuration(duration:Double){
        
    }

    
    
    ///焦点出(缩放、透明变化)
    func zoomOutWithScale(scale:CGFloat, duration:Double){
        
    }
 
    /// 焦点进(缩放、透明变化)
    func zoomInWithScale(scale:CGFloat, duration:Double){
        
    }

    ///滚动(旋转、位移变化)
    func  rollToPosition(position:CGPoint, duration:Double){
        
    }
    
    ///滚进(旋转、位移、透明变化)
    func rollInToPosition(position:CGPoint, duration:Double){
        
    }
    
    ///滚出(旋转、位移、透明变化)
    func rollOutToPosition(position:CGPoint, duration:Double){
        
    }
    
    ///转进(旋转、缩放、透明变化)
    func rotateInWithCircles(circles:Int, duration:Double){
        
    }
    
    ///转出(旋转、缩放、透明变化)
    func rotateOutWithCircles(circles:Int, duration:Double){
        
    }
    
    ///掉落
    func dropToPosition(position:CGPoint, duration:Double){
        
    }
    
    ///飘落
    func floatToPosition(position:CGPoint, duration:Double){
        
    }
    
    ///快速移动
    func moveQuicklyToPosition(position:CGPoint, degree:CGFloat, duration:Double){
        
    }
    
    ///移动
    func moveToPosition(position:CGPoint, duration:Double){
        
    }
    
    ///移动出现
    func comeInToPosition(position:CGPoint, duration:Double){
        
    }
    
    /// 移动消失
    func goOutToPosition(position:CGPoint, duration:Double){
        
    }
    
    /// 跳跃
    func jumpToPosition(position:CGPoint, height:CGFloat, duration:Double){
        
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
