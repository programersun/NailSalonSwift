//
//  ZXY_ORSqureTitleView.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORSqureTitleView: UICollectionReusableView {

    @IBOutlet weak var subCollectionV: UICollectionView!
    
    @IBOutlet weak var scrollVL: ZXYScrollView!
    
    var offerDataList : [ZXYOfferRecommendAlbum]?
    
    class func cellID() -> String
    {
        return "ZXY_ORSqureTitleViewID"
    }

    class func cellKind() -> String
    {
        return "ZXY_ORSqureTitleViewKind"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subCollectionV.delegate = self
        subCollectionV.dataSource = self
        var nib = UINib(nibName: "ZXY_ORSqureTitleCell", bundle: nil)
        subCollectionV.registerNib(nib, forCellWithReuseIdentifier: ZXY_ORSqureTitleCell.cellID())
        scrollVL.frame = CGRectMake(scrollVL.frame.origin.x, scrollVL.frame.origin.y, UIScreen.mainScreen().bounds.width, 145)
        scrollVL.delegate   = self
        scrollVL.dataSource = self
        
        // Initialization code
    }
    
    
        
}
extension ZXY_ORSqureTitleView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var current = offerDataList![indexPath.row]
        var cell : ZXY_ORSqureTitleCell? = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_ORSqureTitleCell.cellID(), forIndexPath: indexPath) as? ZXY_ORSqureTitleCell
        
        if(cell == nil)
        {
            
            var bundle = NSBundle.mainBundle().loadNibNamed("ZXY_ORSqureTitleCell", owner: self, options: nil)
            for var i = 0 ;i < bundle.count ; i++
            {
                var current: AnyObject = bundle[i]
                if(current.isKindOfClass(ZXY_ORSqureTitleCell.self))
                {
                    cell = current as? ZXY_ORSqureTitleCell
                }
            }
        }
        var url = current.image?.cutPath?
        if let haha = url
        {
            var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + haha
            cell?.titleImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "headerHolder"))
        }
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var screenSize = UIScreen.mainScreen().bounds
        var itemWidth  = (screenSize.width - 45) / 4
        if itemWidth > 83
        {
            itemWidth = 83
        }
        return CGSizeMake(itemWidth, itemWidth)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(offerDataList == nil)
        {
            return 0
        }
        else
        {
            return offerDataList!.count
        }
    }
    
}

extension ZXY_ORSqureTitleView : ZXYScrollDataSource , ZXYScrollDelegate
{
    func numberOfPages() -> Int {
        return 3
    }
    
    func viewAtIndexPage(index: Int) -> UIView! {
        var imgV = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 145))
        println("\(imgV)")
        if(index == 0)
        {
            imgV.image = UIImage(named: "sample2")
        }
        else if(index == 1)
        {
            imgV.image = UIImage(named: "sample1")
        }
        else
        {
            imgV.image = UIImage(named: "sample3")
        }
        return imgV
    }
    
    func shouldClickAtIndex(index: Int) -> Bool {
        return false
    }
    
    func shouldTurnAutoWithTime() -> Bool {
        return true
    }
    
    func turnTimeInterVal() -> NSTimeInterval {
        return 3
    }
    
    func afterClickAtIndex(index: Int) {
        
    }
}
