//
//  ZXY_ErrorMessageHandle.swift
//  KickYourAss
//
//  Created by 宇周 on 15/3/12.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_ErrorMessageHandle: NSObject {
    class func messageForErrorCode(errorCode : Double) -> String
    {
        var filePath      = NSBundle.mainBundle().pathForResource("ErrorMessage", ofType: "plist")
        var errorFileDic  = NSDictionary(contentsOfFile: filePath!)
        var errorCodeString = "\(Int(errorCode))"
        var errorMessage : String?  = errorFileDic![errorCodeString] as? String
        return errorMessage ?? "错误状态码：errorCode is \(errorCode)"
    }
    
    class func resultCodeIsSuccess(errorCode: String) -> Bool
    {
        if(errorCode == "1000")
        {
            return true
        }
        else
        {
            return false
        }
    }
}
