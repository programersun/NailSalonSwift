//
//  ZXY_UserInfoModel.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation
import CoreData
@objc(ZXY_UserInfoModel)
class ZXY_UserInfoModel: NSManagedObject {

    @NSManaged var user_id: String
    @NSManaged var nick_name: String
    @NSManaged var role: String

}
