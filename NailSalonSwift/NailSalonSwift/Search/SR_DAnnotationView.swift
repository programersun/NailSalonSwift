//
//  SR_DAnnotationView.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit
class SR_DAnnotationView : BMKAnnotationView {
    
    private let arrowHeight : CGFloat = 10
    var titleImg : UIImageView = UIImageView(frame: CGRectMake(0, 4, 58 ,58 ))
    private var backImg : UIImageView!
    var userID : String?
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.drawCircleArrow()
        //        self.layer.shadowColor = UIColor.grayColor().CGColor
        //        self.layer.shadowOpacity = 1.0;
        //        self.layer.shadowOffset = CGSizeMake(0, 0);
        titleImg.layer.cornerRadius = 30
        titleImg.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRectMake(0, 0, 74  , 80)
        self.backImg = UIImageView(frame: CGRectMake(0, 0, 74, 80))
        backImg.image = UIImage(named: "bubbleMap")
        self.addSubview(backImg)
        self.addSubview(titleImg)
        titleImg.center = CGPointMake(backImg.center.x, titleImg.center.y)
        //titleImg.backgroundColor = UIColor.blueColor()
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
        self.canShowCallout = false
    }
    
    
    func drawCircleArrow() -> Void
    {
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
