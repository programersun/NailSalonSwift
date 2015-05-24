//
//  AppDelegate.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , BMKGeneralDelegate , EMChatManagerDelegate , IChatManagerDelegate , UIAlertViewDelegate {

    var window: UIWindow?
    var bmkAuthor : BMKMapManager?
    var hasPresent : Bool = false
    var alert = UIAlertView()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var documentPath : NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var pathString      = documentPath[0] as! String
        var realPath        = pathString.stringByAppendingPathComponent("TagTypePList.plist")
        var bundlePlistPath = NSBundle.mainBundle().pathForResource("TagTypePList", ofType: "plist")
        if !NSFileManager.defaultManager().fileExistsAtPath(realPath)
        {
            NSFileManager.defaultManager().copyItemAtPath(bundlePlistPath!, toPath: realPath, error: nil)
        }
        
        
        
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.NailRedColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        self.loadPushSettingPlist()
        
        bmkAuthor = BMKMapManager()
        
        // MARK: 环信注册
        var error = EaseMob.sharedInstance().registerSDKWithAppKey("duostec#meijiabang", apnsCertName: "MJDev")
        EaseMob.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        if(application.respondsToSelector(Selector("registerForRemoteNotifications")))
        {
            application.registerForRemoteNotifications()
            var notiType = UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound
            var settings = UIUserNotificationSettings(forTypes: notiType, categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        else
        {
            
            var notiType = UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
            application.registerForRemoteNotificationTypes(notiType)
            
        }
        
        var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(myUserID == nil)
        {
        }
        else
        {
            EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(myUserID, password: "12345678", completion: { (loginInfo, error) -> Void in
                
                }, onQueue: nil)
        }
        EaseMob.sharedInstance().chatManager.addDelegate(self, delegateQueue: nil)
        
        // MARK: 百度地图授权
        if(( bmkAuthor!.start(ZXY_ConstValue.BDMAPKEY.rawValue, generalDelegate: nil)))
        {
            println("授权成功")
            ZXY_LocationRelative.sharedInstance.startLocateUserPosition()
            ZXY_LocationRelative.sharedInstance.failureBlock = {[weak self](message) -> Void in
                if(self?.hasPresent == true)
                {
                    
                }
                else
                {
                    var alert = UIAlertView(title: "提示", message: "地图定位失败 \n \(message)", delegate: nil, cancelButtonTitle: "取消")
                    alert.show()
                    self?.hasPresent = true
                }
            }
        }
        else
        {
            println("授权失败")
        }
        
        UMSocialData.setAppKey(ZXY_ConstValue.UMAPPKEY.rawValue)
        UMSocialData.openLog(true)
        
        // MARK: 极光推送
        if UIDevice.currentDevice().systemVersion.doubleValue >= 8.0
        {
            APService.registerForRemoteNotificationTypes(
                UIUserNotificationType.Badge.rawValue |
                UIUserNotificationType.Sound.rawValue |
                UIUserNotificationType.Alert.rawValue
                , categories: nil)

        }
        else 
        {
            APService.registerForRemoteNotificationTypes(
                UIRemoteNotificationType.Badge.rawValue |
                UIRemoteNotificationType.Sound.rawValue |
                UIRemoteNotificationType.Alert.rawValue
                , categories: nil)
        }
        APService.setupWithOption(launchOptions)
        var noti: Void = NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("JPushReceiveData:"), name: kJPFNetworkDidReceiveMessageNotification, object: nil)
        
        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if userID != nil
        {
            APService.setAlias(userID, callbackSelector: Selector("JPushAlias:tags:alias:"), object: self)
        }
             
        if(ZXY_UserInfoDetail.sharedInstance.isAppFirstLoad())
        {
            var storyBoard = UIStoryboard(name: "WelcomeStory", bundle: nil)
            var vc         = storyBoard.instantiateInitialViewController() as! SR_WelcomeViewController
            self.window?.rootViewController = vc
        }
        
        
        
        return true
    }
    
    func didLoginFromOtherDevice() {
        alert = UIAlertView(title: "提示", message: "您的账号已在其他设备上登录", delegate: self, cancelButtonTitle: nil , otherButtonTitles: "确定")
        alert.tag = 1
        alert.show()
        ZXY_UserInfoDetail.sharedInstance.logoutUser()
    }
    
    func didReceiveMessage(message: EMMessage!) {
        println("哈哈")
        var la = NSTimeInterval()
        NSNotificationCenter.defaultCenter().postNotificationName("message", object: nil)
        self.pushSetting()
    }
    
    func JPushAlias(code : Int , tags : NSSet , alias : String)
    {
        println(alias)
    }
    
    /// 此处获取极光推送的内容
    func JPushReceiveData(noti : NSNotification)
    {
        if UIApplication.sharedApplication().applicationState == UIApplicationState.Background
        {
            APService.setLocalNotification(NSDate(timeIntervalSinceNow: 100), alertBody: "您收到一条新消息", badge: 1, alertAction: "", identifierKey: "", userInfo: nil, soundName: nil)
        }
        else
        {
            self.pushSetting()
        }
        var notiInfo = noti.userInfo
        if let noty = notiInfo
        {
            var mainNoti: NSString? = noty["content"] as? NSString
            var jsonData: AnyObject? = NSJSONSerialization.JSONObjectWithData(mainNoti!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!, options: NSJSONReadingOptions.MutableLeaves, error: nil)
            var typeData     = jsonData!["type"]
            var typeString : String = ""
            if typeData is String
            {
                typeString = typeData as! String
            }
            else
            {
                var typeInt = typeData as! Int
                typeString = "\(typeInt)"
            }
            if typeString == "4000"
            {
                var dataDic = jsonData!["data"] as! NSDictionary
                var dataNick  = dataDic["nick"] as! NSString
                var dataID    = dataDic["id"] as! NSString
                var headImg   = dataDic["head"] as! NSString
                var time      = dataDic["send_time"] as! NSNumber
                var role      = dataDic["role"] as! NSString
                var toCDDic   = ["atten_avatar" : headImg , "atten_id" : dataID , "atten_name" : dataNick , "atten_role" : role ,"atten_time" : time.stringValue , "atten_isRead" : "No"]
                ZXY_DataProviderHelper.saveOneDic(DBName: "AttensionNoti", saveEntity: toCDDic, predictString: "atten_id = %@", argumentArr: [dataID])
               

            }
            else if typeString == "4004"
            {
                var dataDic = jsonData!["data"] as! NSDictionary
                var dataNick  = dataDic["nick"] as! NSString
                var dataID    = dataDic["id"] as! NSString
                var time      = dataDic["send_time"] as! NSNumber
                var toCDDic   = ["order_nick" : dataNick , "order_id" : dataID , "orderTime" : time.stringValue]
                ZXY_DataProviderHelper.saveOneDic(DBName: "MyOrder", saveEntity: toCDDic, predictString: "order_id = %@", argumentArr: [dataID])
            }
            
        }
        NSNotificationCenter.defaultCenter().postNotificationName("message", object: nil)
        
        
        
    }

    func loadPushSettingPlist() {
        var documentPath : NSArray = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var pathString      = documentPath[0] as! String
        var realPath        = pathString.stringByAppendingPathComponent("pushSetting.plist")
        var bundlePlistPath = NSBundle.mainBundle().pathForResource("pushSetting", ofType: "plist")
        if !NSFileManager.defaultManager().fileExistsAtPath(realPath)
        {
            NSFileManager.defaultManager().copyItemAtPath(bundlePlistPath!, toPath: realPath, error: nil)
        }
    }

    
    func pushSetting()
    {
        var paths     = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var plistPath = paths[0] as! String
        var filename = plistPath.stringByAppendingPathComponent("pushSetting.plist")
        var data     = NSMutableDictionary(contentsOfFile: filename)
        var message   = data!["message"] as! String
        var sound = data!["sound"] as! String
        var shake = data!["shake"] as! String
        if message == "1" {
            if sound == "1" {
                AudioServicesDisposeSystemSoundID(4095)
                AudioServicesPlaySystemSound(1007)
            }
    
            if shake == "1" {
                AudioServicesPlaySystemSound(4095)
            }
            else
            {
                
            }
        }
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillEnterForeground(application)
    }
    
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        println("收到消息")
        EaseMob.sharedInstance().application(application, didReceiveRemoteNotification: userInfo)
        APService.handleRemoteNotification(userInfo)
        //APService.handleRemoteNotification(userInfo)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        println("didReceiveRemoteNotification fetchCompletionHandler \(userInfo)")
       // APService.handleRemoteNotification(userInfo)
        
        APService.handleRemoteNotification(userInfo)
        EaseMob.sharedInstance().application(application, didReceiveRemoteNotification: userInfo)
        completionHandler(UIBackgroundFetchResult.NewData)
    }

    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        APService.handleRemoteNotification(userInfo)
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        println("本地通知")
        EaseMob.sharedInstance().application(application, didReceiveLocalNotification: notification)
        APService.showLocalNotificationAtFront(notification, identifierKey: nil)
    }
    
    
    
        
    func applicationWillResignActive(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillResignActive(application)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        EaseMob.sharedInstance().applicationDidEnterBackground(application)
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        application.applicationIconBadgeNumber = 0
        if(myUserID == nil)
        {
            
            
            
        }
        else
        {
            
        }

        EaseMob.sharedInstance().applicationDidBecomeActive(application)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        EaseMob.sharedInstance().applicationWillTerminate(application)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        EaseMob.sharedInstance().application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        APService.registerDeviceToken(deviceToken)
       // APService.registerDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        EaseMob.sharedInstance().application(application, didFailToRegisterForRemoteNotificationsWithError: error)
        println(error)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
    }
    

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.duostec.NailSalonSwift" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("NailSalonSwift", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("NailSalonSwift.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }
    
    func onGetNetworkState(iError: Int32) {
        println(iError)
    }
    
    func onGetPermissionState(iError: Int32) {
        println(iError)
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1 {
            if buttonIndex == 0 {
                NSNotificationCenter.defaultCenter().postNotificationName("loginOtherDevices", object: nil)
            }
        }
    }
}

extension AppDelegate {
    
}

