//
//  ZXY_DataProviderHelper.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import CoreData
class ZXY_DataProviderHelper: NSObject {
    
    /// 单例模式
    class var sharedInstance: ZXY_DataProviderHelper
        {
        get {
            struct SingleClass
            {
                static var instance : ZXY_DataProviderHelper? = nil
            }
            if SingleClass.instance == nil
            {
                SingleClass.instance = ZXY_DataProviderHelper()
            }
            return SingleClass.instance!
        }
    }
    
    private class func getDelegate() -> AppDelegate
    {
        var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate
    }
    // MARK: - 关于数据库操作方法save
    
    /**
    将一组字典保存到数据库中
    
    :param: name       数据库名称
    :param: saveEntity 字典 对应数据库中的字段，the type of value should be the same with the sqlite
    
    :returns: the result of process success will be true or will get false
    */
    class func saveAllWithDic(DBName name : String , saveEntity: Dictionary<String , AnyObject?>) -> Bool
    {
        var delegate = ZXY_DataProviderHelper.getDelegate()
        var context  = delegate.managedObjectContext
        var modelObject : NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName(name, inManagedObjectContext: context!) as! NSManagedObject
        for (key , value) in saveEntity
        {
            modelObject.setValue(value, forKey: key)
        }
        
        var result = context?.save(nil)
        return result ?? false
    }
    
    /**
    将一组数组<字典<String , 任意类型>>，类型需要与数据库中的类型保持一致，key对应sqlite 关键字
    
    :param: models 存储字典的数组
    
    :returns: 保存成功返回true
    */
    class func saveAllWithArray(DBName name: String ,models : [Dictionary<String, AnyObject?>]) -> Bool
    {
        var delegate = ZXY_DataProviderHelper.getDelegate()
        var context  = delegate.managedObjectContext
        var result   = true
        for item in models
        {
            var subResult = ZXY_DataProviderHelper.saveAllWithDic(DBName: name, saveEntity: item)
            if !subResult
            {
                result = false
            }
        }
        return result
    }
    
    // MARK: 读取数据库
    class func readAllFromDB(DNName name: String) -> [AnyObject]
    {
        var delegate = ZXY_DataProviderHelper.getDelegate()
        var context  = delegate.managedObjectContext
        var entity   = NSEntityDescription.entityForName(name, inManagedObjectContext: context!)
        var fetch    = NSFetchRequest()
        fetch.entity = entity
        var error : NSError? = nil
        var resultArr = context?.executeFetchRequest(fetch, error: &error)
        return resultArr ?? []
    }
    
    class func readFromDBWithPredict(DBName name: String ,predictString : String , argumentArr : [AnyObject]?) -> [AnyObject]
    {
        var delegate = ZXY_DataProviderHelper.getDelegate()
        var context  = delegate.managedObjectContext
        var entity   = NSEntityDescription.entityForName(name, inManagedObjectContext: context!)
        var fetch    = NSFetchRequest()
        fetch.entity = entity
        fetch.predicate = NSPredicate(format: predictString, argumentArray: argumentArr)
        var error : NSError? = nil
        var resultArr = context?.executeFetchRequest(fetch, error: &error)
        return resultArr ?? []
    }
    
    // MARK: 将数据库中的数据删除
    class func deleteAll(DBName name: String) -> Bool
    {
        var delegate = ZXY_DataProviderHelper.getDelegate()
        var context  = delegate.managedObjectContext
        var arr : [NSManagedObject]      = ZXY_DataProviderHelper.readAllFromDB(DNName: name) as! [NSManagedObject]
        for object  in arr
        {
            context?.deleteObject(object)
        }
        return context?.save(nil) ?? false
    }
}
