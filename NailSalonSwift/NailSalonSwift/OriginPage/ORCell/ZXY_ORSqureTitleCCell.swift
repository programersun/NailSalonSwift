//
//  ZXY_ORSqureTitleCCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORSqureTitleCCell: UICollectionViewCell {
    class func cellID() -> String
    {
        return "ZXY_ORSqureTitleCCellID"
    }
    
    @IBOutlet weak var scrollV : UIScrollView!
    @IBOutlet weak var subCollectionV : UICollectionView!
    
    
    
}

extension ZXY_ORSqureTitleCCell : UICollectionViewDelegate , UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_ORSqureSubCCell.cellID(), forIndexPath: indexPath) as ZXY_ORSqureSubCCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 10
    }
    
}

