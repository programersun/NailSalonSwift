//
//  ZXY_ImagePickCoCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ImagePickCoCell: UICollectionViewCell {
    var currentImageV : UIImageView! = UIImageView()
    var selectImageV  : UIImageView! = UIImageView(frame: CGRectMake(0, 0, 30, 30))
    override var reuseIdentifier: String { return "zxy_Collection" }
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    override init() {
        super.init()
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        currentImageV.contentMode = UIViewContentMode.ScaleAspectFill
        currentImageV.setTranslatesAutoresizingMaskIntoConstraints(false)
        currentImageV.backgroundColor = UIColor.clearColor()
        selectImageV.backgroundColor  = UIColor.clearColor()
        currentImageV.clipsToBounds = true
        var pathBundle = NSBundle(path: NSBundle.mainBundle().pathForResource("ZXY_ImgPickBundle", ofType: "bundle")!)
        var pathImg    = pathBundle?.pathForResource("zxy_imagePickImg", ofType: "png")
        selectImageV.image = UIImage(contentsOfFile: pathImg!)
        //selectImageV.backgroundColor = UIColor.redColor()
        selectImageV.setTranslatesAutoresizingMaskIntoConstraints(false)
        selectImageV.alpha = 0
        
        self.addSubview(currentImageV)
        self.addSubview(selectImageV)
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentImageV, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: selectImageV, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 5))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: selectImageV, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: -5))
        
        selectImageV.addConstraint(NSLayoutConstraint(item: selectImageV, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30))
        selectImageV.addConstraint(NSLayoutConstraint(item: selectImageV, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 30))
            }
    
    func showSelectImg()
    {
        UIView.animateWithDuration(0.1, animations: { [weak self] () -> Void in
            self?.selectImageV.alpha = 1
            return
        })
    }
    
    func hideSelectImg()
    {
        UIView.animateWithDuration(0.1, animations: { [weak self] () -> Void in
            self?.selectImageV.alpha = 0
            return
        })
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
