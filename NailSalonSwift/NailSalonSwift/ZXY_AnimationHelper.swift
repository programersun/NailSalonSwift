//
//  ZXY_AnimationHelper.swift
//  WonderForYou
//
//  Created by 宇周 on 15/3/16.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_AnimationHelper: CAAnimation {
    
    typealias ZXY_AnimationHelperComplete = (isFinish  : Bool) -> Void
    
    /**
    循环渐隐效果
    
    :returns: 返回动画
    */
    
    private var completeBlock : ZXY_AnimationHelperComplete?
    class func animationHelperAlpha() -> CABasicAnimation
    {
        var animationAdd = CABasicAnimation(keyPath: "opacity")
        animationAdd.fromValue = 0.5
        animationAdd.toValue   = 1
        animationAdd.duration  = 0.5
        animationAdd.repeatCount = 1e100
        animationAdd.autoreverses = true
        animationAdd.removedOnCompletion = false;
        animationAdd.fillMode = kCAFillModeForwards;
        animationAdd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animationAdd
    }
    
    /**
    透明度过度动画
    
    :param: from 开始值
    :param: to   结束值
    
    :returns: 返回动画效果
    */
    class func animationForAlpha(from: Double , to : Double) -> CABasicAnimation
    {
        var animationAdd = CABasicAnimation(keyPath: "opacity")
        animationAdd.fromValue = from
        animationAdd.toValue   = to
        animationAdd.duration  = 0.5
        animationAdd.repeatCount = 1
        animationAdd.removedOnCompletion = true;
        animationAdd.fillMode = kCAFillModeForwards;
        animationAdd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return animationAdd

    }
    
    func animationForAlpha(from: Double , to : Double , finishBlock : ZXY_AnimationHelperComplete?) -> CABasicAnimation
    {
        var animationAdd = CABasicAnimation(keyPath: "opacity")
        animationAdd.fromValue = from
        animationAdd.toValue   = to
        animationAdd.duration  = 0.5
        animationAdd.repeatCount = 1
        animationAdd.removedOnCompletion = true;
        animationAdd.fillMode = kCAFillModeForwards;
        animationAdd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        if(finishBlock != nil)
        {
            var delayTime = Int64(NSEC_PER_SEC / 2)
            var t = dispatch_time(DISPATCH_TIME_NOW, delayTime)
            dispatch_after(t, dispatch_get_main_queue(), { [weak self]() -> Void in
                finishBlock!(isFinish: true)
                ""
            })
            
        }
        
        return animationAdd
    }

    
    /**
    大小动画
    
    :returns: 返回动画
    */
    class func animationHelperSize() -> CABasicAnimation
    {
        var animationAdd = CABasicAnimation(keyPath: "transform.scale")
        animationAdd.fromValue = 0
        animationAdd.toValue   = 1
        animationAdd.duration  = 0.5
        animationAdd.repeatCount = 1e100
        animationAdd.autoreverses = true
        animationAdd.removedOnCompletion = false;
        animationAdd.fillMode = kCAFillModeForwards;
        animationAdd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animationAdd

    }
    
    /**
    旋转动画
    
    :returns: 返回动画
    */
    class func animationRotation() -> CABasicAnimation
    {
        var rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = M_PI * 2
        rotationAnimation.duration = 1
        rotationAnimation.cumulative  = true
        rotationAnimation.repeatCount = 1e100
        //rotationAnimation.autoreverses = true
        return rotationAnimation
    }
    
    /**
    循环渐隐、大小
    
    :returns: 返回动画
    */
    class func animationGroupForAlphaAndScale() -> CAAnimationGroup
    {
        var group = CAAnimationGroup()
        group.duration = 1
        group.repeatCount = 1e100
        group.autoreverses = true
        group.removedOnCompletion = false;
        group.fillMode = kCAFillModeForwards;
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.animations = [ZXY_AnimationHelper.animationHelperAlpha() , ZXY_AnimationHelper.animationHelperSize()]
        return group
    }
    
    
    override func animationDidStart(anim: CAAnimation!) {
        
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if(flag)
        {
           
        }
    }
}


