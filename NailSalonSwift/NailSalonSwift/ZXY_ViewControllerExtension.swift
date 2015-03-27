//
//  ZXY_ViewControllerExtension.swift
//  ZXYPrettysHealth
//
//  Created by 宇周 on 14/12/12.
//  Copyright (c) 2014年 宇周. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController
{
    /**
    设置导航栏背景图片
    
    :param: imageName 图片名称
    */
    func setNaviBarTitleImage(imageName:String)->Void
    {
        var currentTitleImage:UIImage! = UIImage(named: imageName)
        
        self.navigationController?.navigationBar.setBackgroundImage(currentTitleImage, forBarMetrics: UIBarMetrics.Default)
    }
    
    /**
    设置导航栏左侧按钮的图片
    
    :param: imageName 图片名称
    */
    func setNaviBarLeftImage(imageName:String)->Void
    {
        var currentLeftImage:UIImage!          = UIImage(named: imageName)
        //生成导航栏左侧按钮
        var leftBtn         :UIButton          = UIButton(frame: CGRectMake(0, 0, 50, 30))
        leftBtn.addTarget(self, action: "leftNaviButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        leftBtn.setImage(currentLeftImage, forState: UIControlState.Normal)
        //需要展位按钮
        var leftSpace       :UIBarButtonItem   = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        leftSpace.width                        = -15
        //使用自定义button代替左侧按钮
        var leftItem        :UIBarButtonItem   = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItems = [leftSpace,leftItem]
    }
    
    /**
    设置导航栏右侧按钮的图片
    
    :param: imageName 图片名称
    */
    func setNaviBarRightImage(imageName:String)->Void
    {
        var currentRightImage:UIImage!         = UIImage(named: imageName)
        var rightBtn         :UIButton         = UIButton(frame: CGRectMake(0, 0, 50, 30))
        rightBtn.addTarget(self, action: "rightNaviButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        rightBtn.setImage(currentRightImage, forState: UIControlState.Normal)
        var rightSpace       :UIBarButtonItem  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        rightSpace.width                       = -15
        var rightItem        :UIBarButtonItem  = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItems = [rightSpace,rightItem]
    }
    
    /**
    左侧按钮的事件
    */
    func leftNaviButtonAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    /**
    右侧按钮点击事件
    */
    func rightNaviButtonAction()
    {
        
    }
    
    /**
    判断一个字符串是不是整形
    
    :param: input 用户输入的字符串
    
    :returns: 如果用户输入的时字符串返回true
    */
    func checkStringISNum(input : String) -> Bool
    {
        var isNum       : Bool   = true
        var modelString : String = "0123456789"
        var character   : NSCharacterSet = NSCharacterSet(charactersInString: modelString)
        var currentIndex : Int   = 0
        while currentIndex < countElements(input)
        {
            let indexFrom = advance(input.startIndex, currentIndex)
            let indexTo   = advance(input.startIndex, currentIndex+1)
            var range     = Range<String.Index>(start: indexFrom, end: indexTo)
            var subString = input.substringWithRange(range)
            var setRange : Range? = subString.rangeOfCharacterFromSet(character, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: subString.startIndex, end: subString.endIndex))
            if let ranges = setRange
            {
                if(setRange!.isEmpty)
                {
                    isNum = false
                    break
                }
                else
                {
                    currentIndex++
                }
            }
            else
            {
                isNum = false
                break
            }
        }
        return isNum
    }
    
    func showAlertEasy(messageTitle : String , messageContent : String)
    {
        var alert : UIAlertView = UIAlertView(title: messageTitle, message: messageContent, delegate: nil, cancelButtonTitle: "取消")
        alert.show()
    }
    
    func getCellHeightWith(textString stringValue : String? , minHeight height: CGFloat ,fontSize font: UIFont ,constraintWidth width: CGFloat) -> CGFloat
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
    
    func startCheckNetConnect(whenBegain canConnect:(() -> Void)? , whenClosed canNotConnect:(() -> Void)?)
    {
        var netCheck = ZXY_NetHelperOperate.sharedInstance
        netCheck.judgeNetCanConnect { (status) -> Void in
            if(status == AFNetworkReachabilityStatus.NotReachable)
            {
                self.showAlertEasy("提示", messageContent: "没有网络连接")
                if(canNotConnect != nil)
                {
                    canNotConnect!()
                }
            }
            else
            {
                if(canConnect != nil)
                {
                    canConnect!()
                }
            }
        }
    }
    
    func timeStampToDateString(timeStamp : String) -> String
    {
        var interVal : NSTimeInterval = (timeStamp as NSString).doubleValue
        var dates = NSDate(timeIntervalSince1970: interVal)
        var formatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        var dateString = formatter.stringFromDate(dates)
        return dateString
    }
    
    func layerCustomerViewCorner(customerV : UIView , cornerValue: CGFloat) -> Void
    {
        
        customerV.layer.cornerRadius  = cornerValue
        customerV.layer.masksToBounds = true
    }
    
    func layerCustomerVCornerBold(customerV : UIView , cornerValue: CGFloat , borderWidth: CGFloat , borderColor: UIColor)
    {
        customerV.layer.cornerRadius  = cornerValue
        customerV.layer.masksToBounds = true
        
        customerV.layer.borderWidth = borderWidth
        customerV.layer.borderColor = borderColor.CGColor
    }
    
    func AlssetToUIImage(currentSet :  ALAsset) -> UIImage
    {
        var alPresent = currentSet.defaultRepresentation()
        var cgIMG  : CGImageRef   =  alPresent.fullResolutionImage().takeUnretainedValue() as CGImageRef
        var ori  : ALAssetOrientation? = alPresent.orientation()
        var imgOri : UIImageOrientation = UIImageOrientation.Up
        if(ori != nil)
        {
            switch ori!
            {
            case ALAssetOrientation.Down :
                imgOri = UIImageOrientation.Down
            case ALAssetOrientation.Left :
                imgOri = UIImageOrientation.Left
            case ALAssetOrientation.Right :
                imgOri = UIImageOrientation.Right
            case ALAssetOrientation.DownMirrored :
                imgOri = UIImageOrientation.DownMirrored
            case ALAssetOrientation.LeftMirrored :
                imgOri = UIImageOrientation.LeftMirrored
            case ALAssetOrientation.RightMirrored :
                imgOri = UIImageOrientation.RightMirrored
            case ALAssetOrientation.UpMirrored :
                imgOri = UIImageOrientation.UpMirrored
            default:
                imgOri = UIImageOrientation.Up
            }
        }
        var uiImg = UIImage(CGImage: cgIMG, scale: 1, orientation: imgOri)
        return uiImg!
    }

}
