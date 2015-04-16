//
//  Extensions.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/15.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation

extension Dictionary {
    /**
    扩展可变字典
    
    :param: content 要扩充的内容
    */
    mutating func extend(content: Dictionary) {
        for (key, value) in content {
            updateValue(value, forKey: key)
        }
    }
}

extension String {
    var integerValue: Int{
        return forceBridge().integerValue
    }
    var doubleValue: Double {
        return forceBridge().doubleValue
    }
    func forceBridge() -> NSString {
        return self
    }
    /**
    将图片的相对路径转换为绝对路径
    
    :returns: 图片的绝对路径
    */
    func toAbsoluteImagePath() -> String {
        return ZXY_ALLApi.ZXY_MainAPIImage + self
    }
    /**
    坑爹的服务器返回的所有null都是字符串“null”
    
    :returns: 如果是字符串“null”，转换成nil。
    */
    func checkNull() -> String? {
        return self == "null" ? nil : self
    }
    
    func stringFromTimeStamp(#format: String) -> String {
        let timeInterval = doubleValue
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
}
