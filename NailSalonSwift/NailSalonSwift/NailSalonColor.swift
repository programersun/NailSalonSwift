//
//  NailSalonColor.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//
import UIKit
import Foundation
extension UIColor
{
    /**
    应用主色系
    
    :returns: 返回主色系 粉红色
    */
    class func NailRedColor() -> UIColor
    {
        return UIColor(red: 252.0/255.0, green: 72.0/255.0, blue: 99/255.0, alpha: 1)
    }

    /**
     应用中所有灰色文字颜色

     :returns: 灰色
     */
    class func NailGrayColor() -> UIColor
    {
        return UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85/255.0, alpha: 1)
    }
    
    /**
    背景灰
    
    :returns: 背景灰
    */
    class func NailBackGrayColor() -> UIColor
    {
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1)
    }
    
    /**
    主蓝色
    
    :returns: 蓝色
    */
    class func NailBlueColor() -> UIColor
    {
        return UIColor(red: 38.0/255.0, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
}