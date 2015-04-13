//
//  ZXY_TagLabelView.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/12.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_TagLabelView: UIView {

    private var currentYPosition: CGFloat = 5.0
    private var currentXPosition: CGFloat = 5.0
    private var labelHeight     : CGFloat = 20.0
    var lineWidth       : CGFloat? = UIScreen.mainScreen().bounds.width
    weak var superV : UIView!
    var allTags : String?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setContentView(superV : UIView)
    {
        if(lineWidth == nil)
        {
            lineWidth = superV.frame.width
        }
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lineWidth!, superV.frame.size.height)
        superV.addSubview(self)
        self.setContentTag()
    }
    
    func startLoadTag()
    {
        self.setContentTag()
    }
    
    func getCellHeight() -> CGFloat
    {
        var thisPositionX : CGFloat = 5
        var thisPositionY : CGFloat = 5
        var thisHeight    : CGFloat = 20
        var finalHeight   : CGFloat = 0
        if allTags == nil
        {
            return 40
        }
        
        var tags = allTags?.componentsSeparatedByString(" ")
        if let t = tags
        {
            if(t.count == 0)
            {
                return 40
            }
            for tag in tags!
            {
                var width = self.getWidthWith(stringValue: tag, minWidth: 20, fontSize: UIFont.systemFontOfSize(15), constraintHeight: 20)
                var remainSpaceX  = self.frame.width - thisPositionX - width - 10
                var heightOfLabel = thisHeight
                if remainSpaceX < 0
                {
                    if(width > (self.frame.width - 10 ))
                    {
                        thisPositionX = 5
                        thisPositionY += 20
                        heightOfLabel = self.getHeightWith(textString: tag, minHeight: 20, fontSize: UIFont.systemFontOfSize(15), constraintWidth: self.frame.size.width - 10)
                        thisPositionY += heightOfLabel
                        finalHeight += thisPositionY
                    }
                    else
                    {
                        thisPositionX = 5
                        thisPositionY += 20
                        finalHeight += 20
                    }
                }
                thisPositionX = width + thisPositionX
                if tags?.last == tag
                {
                    finalHeight += heightOfLabel
                }
            }
        }
        return finalHeight

    }
    
    func setContentTag()
    {
        if allTags == nil
        {
            return
        }
        
        var tags = allTags?.componentsSeparatedByString(" ")
        
        if let t = tags
        {
            if(t.count == 0)
            {
                return
            }
            for tag in tags!
            {
                var width = self.getWidthWith(stringValue: tag, minWidth: 20, fontSize: UIFont.systemFontOfSize(15), constraintHeight: 20)
                var remainSpaceX  = lineWidth! - currentXPosition - width - 10
                var heightOfLabel = labelHeight
                println("\(self.frame)")
                if remainSpaceX < 0
                {
                    if(width > (self.frame.width - 10 ))
                    {
                        currentXPosition = 5
                        currentYPosition += 25
                        heightOfLabel = self.getHeightWith(textString: tag, minHeight: 20, fontSize: UIFont.systemFontOfSize(15), constraintWidth: self.frame.size.width - 10)
                        currentYPosition += heightOfLabel
                    }
                    else
                    {
                        currentXPosition = 5
                        currentYPosition += 25
                    }
                }
                var label = UILabel(frame: CGRectMake(currentXPosition, currentYPosition, width, heightOfLabel))
                self.addSubview(label)
                label.numberOfLines = 0
                label.text = tag
                label.backgroundColor = UIColor.NailRedColor()
                label.textColor       = UIColor.whiteColor()
                label.layer.cornerRadius = 5
                label.layer.masksToBounds = true
                label.font = UIFont.systemFontOfSize(15)
                currentXPosition = width + currentXPosition + 5
            }
        }
    }

    func getHeightWith(textString stringValue : String? , minHeight height: CGFloat ,fontSize font: UIFont ,constraintWidth width: CGFloat) -> CGFloat
    {
        var heightSize = stringValue?.boundingRectWithSize(CGSizeMake(width, 2000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:[NSFontAttributeName : font], context: nil).size
        if(heightSize?.height < height)
        {
            return height
        }
        else
        {
            if let heights = heightSize
            {
                return heightSize!.height
            }
            else
            {
                return height
            }
        }
    }
    
    func getWidthWith(#stringValue : String? , minWidth: CGFloat ,fontSize font: UIFont ,constraintHeight height: CGFloat) -> CGFloat
    {
        var widthValue = stringValue?.boundingRectWithSize(CGSizeMake(2000, height), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes:[NSFontAttributeName : font], context: nil).size
        if(widthValue?.width < minWidth)
        {
            return minWidth
        }
        else
        {
            if let heights = widthValue
            {
                return widthValue!.width
            }
            else
            {
                return minWidth
            }
        }
    }

    
}
