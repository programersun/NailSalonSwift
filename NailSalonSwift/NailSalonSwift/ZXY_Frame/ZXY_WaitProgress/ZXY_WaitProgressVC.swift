//
//  ZXY_WaitProgressVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_WaitProgressVC: UIView {
    private  var circleV : UIView!
    private  var circleImg : UIImageView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    func startProgress(superV : UIView)
    {
        self.frame = superV.bounds
        self.layer.opacity = 0.8
        self.layer.allowsGroupOpacity = false
        self.layer.backgroundColor = UIColor.grayColor().CGColor
        superV.addSubview(self)
        if self.layer.animationForKey("alpha") == nil
        {
            self.layer.addAnimation(ZXY_AnimationHelper.animationForAlpha(0, to: 0.8), forKey: "alpha")
        }
        if let circle = circleV
        {
            self.addSubview(circle)
            
        }
        else
        {
            self.rotationView()
            self.addSubview(circleV)
        }
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: circleV, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: circleV, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 50))
        circleV.addConstraint(NSLayoutConstraint(item: circleV, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100))
        circleV.addConstraint(NSLayoutConstraint(item: circleV, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 80))
        self.startAnimation()
    }
    
    func hideProgress(superV : UIView)
    {
        var finishAni = ZXY_AnimationHelper()
        self.layer.opacity = 0
        self.layer.addAnimation(finishAni.animationForAlpha(0.8, to: 0, finishBlock: { [weak self](isFinish) -> Void in
            if let he = self{
                self!.removeFromSuperview()
            }
        }), forKey: "alphaN")
        
        
    }
    
    private func rotationView()
    {
        circleV = UIView(frame: CGRectMake(0, 0, 100, 80))
        circleV.backgroundColor = UIColor.whiteColor()
        circleV.layer.cornerRadius = 5
        circleV.layer.borderWidth  = 1
        circleV.layer.borderColor  = UIColor.whiteColor().CGColor
        circleImg = UIImageView(image: UIImage(named: "indicator"))
        circleV.addSubview(circleImg)
        circleV.setTranslatesAutoresizingMaskIntoConstraints(false)
        circleImg.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        circleV.addConstraint(NSLayoutConstraint(item: circleV, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: circleImg, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        circleV.addConstraint(NSLayoutConstraint(item: circleV, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: circleImg, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        circleImg.addConstraint(NSLayoutConstraint(item: circleImg, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40))
        
        circleImg.addConstraint(NSLayoutConstraint(item: circleImg, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 40))
        
    }
    
    private func startAnimation()
    {
        if(circleImg.layer.animationForKey("rota") != nil)
        {
            return
        }
        circleImg.layer.addAnimation(ZXY_AnimationHelper.animationRotation(), forKey: "haha")
    }

}
