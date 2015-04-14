//
//  ZXY_ImageItem.swift
//  ZXYImageBrowser
//
//  Created by ZXYStart on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ImageItem: NSObject {
    var itemURL : NSURL?
    var itemName : String?
    var itemIndex : Int?
    var itemImage : UIImage?
    
    func setItemURL(itemURL : NSURL )
    {
        self.itemURL = itemURL
        
    }
    
    var isFistShow : Bool? = false
    
    func getItemURL() -> NSURL?
    {
        return self.itemURL
    }
    
       
    init(itemName : String?)
    {
        super.init()
        self.itemName = itemName
    }
    
    init(itemURL : NSURL?) {
        super.init()
        self.itemURL = itemURL
    }
}
