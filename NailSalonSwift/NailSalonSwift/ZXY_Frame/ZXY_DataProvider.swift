//
//  ZXY_DataProvider.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/16.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit
import CoreData
@objc class ZXY_DataProvider: NSObject {
    func saveArt(name : String , artID : String , artImg : String)
    {
        var delegate   = UIApplication.sharedApplication().delegate as! AppDelegate
        var context    = delegate.managedObjectContext!
        var currentArt : ArtistList!
        if(self.isThereExist(artID))
        {
            currentArt = fetchArt(artID)
        }
        else
        {
            currentArt = NSEntityDescription.insertNewObjectForEntityForName("ArtistList", inManagedObjectContext: context) as! ArtistList
        }
        currentArt.artistID = artID
        currentArt.artistName = name
        currentArt.artistImg  = artImg

        var hello = context.save(nil)
    }
    
    func isThereExist(artID : String) -> Bool
    {
        var delegate   = UIApplication.sharedApplication().delegate as! AppDelegate
        var context    = delegate.managedObjectContext!
        var entityDis  = NSEntityDescription.entityForName("ArtistList", inManagedObjectContext: context)
        var fetch      = NSFetchRequest()
        var predict    = NSPredicate(format: "artistID == %@", artID)
        fetch.entity   = entityDis
        fetch.predicate = predict
        var arr = context.executeFetchRequest(fetch, error: nil) as! [ArtistList]?
        if(arr != nil)
        {
            if(arr!.count > 0)
            {
                return true
            }
            else
            {
                return false
            }
        }
        else
        {
            return false
        }
    }
    
    func fetchArt(artID : String) -> ArtistList?
    {
        var delegate   = UIApplication.sharedApplication().delegate as! AppDelegate
        var context    = delegate.managedObjectContext!
        var entityDis  = NSEntityDescription.entityForName("ArtistList", inManagedObjectContext: context)
        var fetch      = NSFetchRequest()
        var predict    = NSPredicate(format: "artistID == %@", artID)
        fetch.predicate = predict
        fetch.entity   = entityDis
        var arr = context.executeFetchRequest(fetch, error: nil) as! [ArtistList]?
        if(arr != nil)
        {
            if(arr?.count > 0)
            {
                return arr![0]
            }
            else
            {
                return nil
            }
        }
        else
        {
            return nil
        }
    }
    
    func deleteAll()
    {
        var delegate   = UIApplication.sharedApplication().delegate as! AppDelegate
        var context    = delegate.managedObjectContext!
        var entityDis  = NSEntityDescription.entityForName("ArtistList", inManagedObjectContext: context)
        var fetch      = NSFetchRequest()
        fetch.entity   = entityDis
        var arr        = context.executeFetchRequest(fetch, error: nil) as! [ArtistList]?
        if(arr == nil)
        {
            return
        }
        for (index , value) in enumerate(arr!)
        {
            context.deleteObject(value)
        }

    }
    
    func fetchAll() -> [ArtistList]?
    {
        var delegate   = UIApplication.sharedApplication().delegate as! AppDelegate
        var context    = delegate.managedObjectContext!
        var entityDis  = NSEntityDescription.entityForName("ArtistList", inManagedObjectContext: context)
        var fetch      = NSFetchRequest()
        fetch.entity   = entityDis
        var arr        = context.executeFetchRequest(fetch, error: nil) as! [ArtistList]?
        return arr
    }
}
