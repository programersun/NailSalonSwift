//
//  MyOrder.swift
//  
//
//  Created by 宇周 on 15/5/16.
//
//

import Foundation
import CoreData
@objc(MyOrder)
class MyOrder: NSManagedObject {

    @NSManaged var order_id: String
    @NSManaged var order_nick: String
    @NSManaged var orderTime: String

}
