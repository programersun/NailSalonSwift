//
//  ZXY_AnimationHelper.swift
//  WonderForYou
//
//  Created by 宇周 on 15/3/16.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_AnimationHelper: CAAnimation {
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
}
