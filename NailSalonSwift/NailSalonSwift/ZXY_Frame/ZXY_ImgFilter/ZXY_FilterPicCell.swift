//
//  ZXY_FilterPicCell.swift
//  GPUImageDemo
//
//  Created by 宇周 on 15/2/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_FilterPicCellID = "ZXY_FilterPicCellID"
class ZXY_FilterPicCell: UITableViewCell {
    
    
    var imgView : UIImageView!
    
    
    
     convenience init(frame: CGRect) {
        self.init(frame: frame)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()
        if(imgView == nil)
        {
            imgView = UIImageView()
        }
        imageView?.backgroundColor = UIColor.clearColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        imgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.addSubview(imgView)
        self.addImgCons()
        
    }
    
    convenience init() {
        self.init()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()
        if(imgView == nil)
        {
            imgView = UIImageView()
            imgView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(imgView)
        }
        imageView?.backgroundColor = UIColor.clearColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.addImgCons()

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()
        if(imgView == nil)
        {
            imgView = UIImageView()
            imgView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(imgView)
        }
        imageView?.backgroundColor = UIColor.clearColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addImgCons()
        
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()
        if(imgView == nil)
        {
            imgView = UIImageView()
            imgView.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(imgView)
        }
        imageView?.backgroundColor = UIColor.clearColor()
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        self.addImgCons()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
        
    func addImgCons()
    {
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: imgView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: imgView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: imgView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: imgView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
