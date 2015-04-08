//
//  SR_Animation.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/7.
//  Copyright (c) 2015年 瑞孙. All rights reserved.
//

import UIKit

class SR_Animation: CAAnimation {
    
    typealias SR_AnimationComplete = (isFinish  : Bool) -> Void
    private var completeBlock : SR_AnimationComplete?
    
    class func animationDown() -> CABasicAnimation
    {
        var animationAdd = CABasicAnimation(keyPath: "transform.scale")
        animationAdd.fromValue = 0
        animationAdd.toValue   = 1
        animationAdd.duration  = 0.5
        animationAdd.removedOnCompletion = false
        animationAdd.fillMode = kCAFillModeForwards
        animationAdd.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return animationAdd
    }
    
    func animationUp(finishBlock : SR_AnimationComplete?) -> CABasicAnimation
    {
        var animationAdd = CABasicAnimation(keyPath: "transform.scale")
        animationAdd.fromValue = 1
        animationAdd.toValue   = 0
        animationAdd.duration  = 0.5
        animationAdd.removedOnCompletion = false
        animationAdd.fillMode = kCAFillModeForwards
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
    
    func animationForAlpha(from: Double , to : Double , finishBlock : SR_AnimationComplete?) -> CABasicAnimation
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

    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
    
    }
    override func animationDidStart(anim: CAAnimation!) {
        
    }
}