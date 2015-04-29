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
    private var fontSize : CGFloat = 15
    var defaultHeight : CGFloat = 43
    var lineWidth       : CGFloat? = UIScreen.mainScreen().bounds.width
    weak var superV : UIView!
    var allTags : String?
    private var allTagArr : [String]? = []
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    func setAllTagString(tags : String)
    {
    
        allTagArr = tags.componentsSeparatedByString(" ")
    }
    
    func setAllTagArr(tagArr : [String])
    {
        allTagArr = tagArr
    }
    
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
        if allTagArr == nil
        {
            return defaultHeight
        }
        
        
        
        if let t = allTagArr
        {
            var isAddHeight = false
            if(t.count == 0)
            {
                return defaultHeight
            }
            for tag in allTagArr!
            {
                var width = self.getWidthWith(stringValue: tag, minWidth: 20, fontSize: UIFont.systemFontOfSize(fontSize), constraintHeight: 20)
                var remainSpaceX  = lineWidth! - thisPositionX - width - 10
                var heightOfLabel = thisHeight
                if remainSpaceX < 0
                {
                    if(width >= (self.frame.width - 10 ))
                    {
                        
                        if(thisPositionX != 5)
                        {
                            thisPositionY += 25
                        }
                        thisPositionX = 5
                        heightOfLabel = self.getHeightWith(textString: tag, minHeight: 20, fontSize: UIFont.systemFontOfSize(fontSize), constraintWidth: lineWidth! - 10)
                        width = lineWidth! - 10
                        isAddHeight = true
                        
                    }
                    else
                    {
                        if(thisPositionX != 5)
                        {
                            thisPositionY += 25
                        }
                        thisPositionX = 5
                        
                    }
                }
                if(isAddHeight)
                {
                    thisPositionY = heightOfLabel + thisPositionY + 5
                    isAddHeight = false
                    thisPositionX = 5
                    if allTagArr?.last == tag
                    {
                        return thisPositionY
                    }
                }
                else
                {
                    thisPositionX = width + thisPositionX + 10
                }
                if allTagArr?.last == tag
                {
                    thisPositionY = thisPositionY + 25 + heightOfLabel
                }

            }
        }
        return thisPositionY

    }
    
    func setContentTag()
    {
        if allTagArr == nil || allTagArr?.count == 0
        {
            return
        }
        
        //var tags = allTags?.componentsSeparatedByString(" ")
        
        if let t = allTagArr
        {
            var isAddHeight = false
            if(t.count == 0)
            {
                return
            }
            for tag in allTagArr!
            {
                if tag.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: " ")) == ""
                {
                    continue
                }
                var width = self.getWidthWith(stringValue: tag, minWidth: 20, fontSize: UIFont.systemFontOfSize(fontSize), constraintHeight: 20)
                var remainSpaceX  = lineWidth! - currentXPosition - width - 10
                var heightOfLabel = labelHeight
                if remainSpaceX < 0
                {
                    if(width > (self.frame.width - 10 ))
                    {
                        
                        if(currentXPosition != 5)
                        {
                            currentXPosition = 5
                            currentYPosition += 25
                        }
                        heightOfLabel = self.getHeightWith(textString: tag, minHeight: 20, fontSize: UIFont.systemFontOfSize(fontSize), constraintWidth: lineWidth! - 10)
                        width = lineWidth! - 10
                        isAddHeight = true
                        
                    }
                    else
                    {
                        if(currentXPosition != 5)
                        {
                            currentYPosition += 25
                        }
                        currentXPosition = 5
                        
                    }
                }
                var label = UILabel(frame: CGRectMake(currentXPosition, currentYPosition, width + 3, heightOfLabel))
                self.addSubview(label)
                label.text = tag
                label.numberOfLines = 0
                label.backgroundColor = UIColor.NailRedColor()
                label.textColor       = UIColor.whiteColor()
                label.layer.cornerRadius = 5
                label.layer.borderColor = UIColor.NailRedColor().CGColor
                label.layer.borderWidth = 1
                label.layer.masksToBounds = true
                label.font = UIFont.systemFontOfSize(15)
                label.textAlignment = NSTextAlignment.Center
                if(isAddHeight)
                {
                    label.textAlignment = NSTextAlignment.Left
                    currentYPosition = heightOfLabel + currentYPosition + 5
                    isAddHeight = false
                    currentXPosition = 5
                }
                else
                {
                    currentXPosition = width + currentXPosition + 10
                }
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
