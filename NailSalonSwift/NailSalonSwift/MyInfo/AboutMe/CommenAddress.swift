//
//  CommenAddress.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/15.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation
import CoreData
@objc(CommenAddress)
class CommenAddress: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var address: String
    @NSManaged var uid: String
    @NSManaged var city: String
    @NSManaged var phone: String
    @NSManaged var postcode: String
    @NSManaged var epoitype: Int
}

