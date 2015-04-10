//
//  ZXY_UserInfoDetail.swift
//  DLTourProjection
//
//  Created by 宇周 on 14/12/3.
//  Copyright (c) 2014年 宇周. All rights reserved.
//

import Foundation
import UIKit
let USERIDKEY:String        = "UserInfoDetail_UserId"
let USERPASSKEY:String      = "UserInfoDetail_UserPass"
let APPFIRSTLOADKEY:String  = "UserInfoDetail_Load"
let USERLOCATIONX           = "USERLOCATIONX"
let USERLOCATIONY           = "USERLOCATIONY"
let USERCITYNAME            = "USERLOCATIONNAME"
let USERDETAILINFO          = "UserInfoDetail_UserDetail"
let _ZXY_UserInfoDetailInstance = ZXY_UserInfoDetail()
class ZXY_UserInfoDetail {
    class var sharedInstance:ZXY_UserInfoDetail
    {
        return _ZXY_UserInfoDetailInstance
    }
    
    func saveUserID(userID:String)
    {
        NSUserDefaults.standardUserDefaults().setValue(userID, forKey: USERIDKEY)
    }
    
    func saveUserPass(userPass:String)
    {
        NSUserDefaults.standardUserDefaults().setValue(userPass, forKey: USERPASSKEY)
    }
    
    func isUserLogin()->Bool
    {
        var userID:String? = NSUserDefaults.standardUserDefaults().valueForKey(USERIDKEY) as? String
        if(userID == nil)
        {
            return false
        }
        return true
    }
    
    func getUserID() -> String?
    {
        var userID:String? = NSUserDefaults.standardUserDefaults().valueForKey(USERIDKEY) as? String
        return userID?
    }
    
    func isAppFirstLoad() -> Bool
    {
        var appKey:String? = NSUserDefaults.standardUserDefaults().valueForKey(APPFIRSTLOADKEY) as? String
        if(appKey == nil)
        {
            //NSUserDefaults.standardUserDefaults().setValue("already install", forKey: APPFIRSTLOADKEY)
            return true
        }
        else
        {
            return false
        }
    }
    
    func startFirstSuccess() -> Void
    {
        var appKey:String? = NSUserDefaults.standardUserDefaults().valueForKey(APPFIRSTLOADKEY) as? String
        NSUserDefaults.standardUserDefaults().setValue("already install", forKey: APPFIRSTLOADKEY)
    }
    
    func getUserPass() -> String
    {
        var userPass:String? = NSUserDefaults.standardUserDefaults().valueForKey(USERPASSKEY) as? String
        return userPass!
    }
    
    func setUserCoordinate(latitude : Double! , longitude : Double!)
    {
        NSUserDefaults.standardUserDefaults().setValue(latitude, forKey: USERLOCATIONX)
        NSUserDefaults.standardUserDefaults().setValue(longitude, forKey: USERLOCATIONY)
    }
    
    func getUserCoordinate() -> Dictionary<String , Double?>?
    {
        
        var latitude : Double? = NSUserDefaults.standardUserDefaults().valueForKey(USERLOCATIONX) as? Double
        var longitude : Double? = NSUserDefaults.standardUserDefaults().valueForKey(USERLOCATIONY) as? Double
        
        return ["latitude": latitude ,"longitude": longitude]
    }
    
    func setUserCityName(name : String?)
    {
        NSUserDefaults.standardUserDefaults().setValue(name, forKey: USERCITYNAME)
    }
    
    func getUserCityName() -> String?
    {
        var x : String? = NSUserDefaults.standardUserDefaults().valueForKey(USERCITYNAME) as? String
        return x
    }
    
    func saveUserDetailInfo(userInfo: Dictionary<String ,AnyObject>) -> Void
    {
        var data : NSData = NSKeyedArchiver.archivedDataWithRootObject(userInfo)
        NSUserDefaults.standardUserDefaults().setValue(data, forKey: USERDETAILINFO)
    }
    
    func getUserDetailInfo() -> Dictionary<String ,AnyObject>?
    {
        var parameter : NSData? = NSUserDefaults.standardUserDefaults().valueForKey(USERDETAILINFO) as? NSData
        if(parameter == nil)
        {
            return nil
        }
        var dictionary : Dictionary<String ,AnyObject>? = NSKeyedUnarchiver.unarchiveObjectWithData(parameter!) as Dictionary<String ,AnyObject>?
        return dictionary
    }
}