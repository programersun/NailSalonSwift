//
//  AttensionNoti.swift
//  
//
//  Created by 宇周 on 15/5/9.
//
//

import Foundation
import CoreData
@objc(AttensionNoti)
class AttensionNoti: NSManagedObject {

    @NSManaged var atten_id: String
    @NSManaged var atten_role: String
    @NSManaged var atten_name: String
    @NSManaged var atten_avatar: String
    @NSManaged var atten_time: String

}
