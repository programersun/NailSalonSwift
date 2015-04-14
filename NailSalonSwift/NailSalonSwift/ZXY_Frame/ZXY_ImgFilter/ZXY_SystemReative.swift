//
//  ZXY_SystemReative.swift
//  GPUImageDemo
//
//  Created by 宇周 on 15/3/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_SystemReative: UIDevice {
    var isIos7 : Bool?
        {
        get{
            var systemVersion = (self.systemVersion as NSString).floatValue
            if(systemVersion >= 7.0 && systemVersion <= 8.0)
            {
                return true
            }
            else
            {
                return false
            }
        }
    }
    var isIos8 : Bool?
        {
        get{
            var systemVersion = (self.systemVersion as NSString).floatValue
            if(systemVersion >= 8.0 && systemVersion <= 9.0)
            {
                return true
            }
            else
            {
                return false
            }
        }
    }

    
}
