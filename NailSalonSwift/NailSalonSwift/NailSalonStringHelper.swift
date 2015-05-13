//
//  NailSalonStringHelper.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/13.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation
extension String
{
    func rangeStringWithTarget(target : String) -> NSMutableAttributedString
    {
        var input = NSString(string: self)
        var tar   = NSString(string: target)
        var range = input.rangeOfString(target)
        var attrInput = NSMutableAttributedString(string: self)
        attrInput.setAttributes([NSForegroundColorAttributeName : UIColor.NailRedColor()], range: range)
        return attrInput
    }
}