//
//  ZXY_ImagePickerCollectionVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_ImagePickerCollectionVCDelegate : class
{
    func selectFinish(allPickImgURL :[ALAsset])
}

class ZXY_ImagePickerCollectionVC: UIViewController {
    struct Static {
        static var onceToken : dispatch_once_t = 0
    }
    
    var isFirst : Bool = true
    var currentCollection : UICollectionView = UICollectionView(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: UICollectionViewFlowLayout())
    var assetGroup : ALAssetsGroup!
    var assetsArr  : [ALAsset] = []
    var maxNumOfSelect : Int   = 1
    var assetForSelect : [ALAsset] = []
    var delegate : ZXY_ImagePickerCollectionVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCollection.delegate   = self
        currentCollection.dataSource = self
        currentCollection.backgroundColor = UIColor.whiteColor()
        //currentCollection.setCollectionViewLayout(WaterfallLayout(), animated: false)
        self.view.addSubview(currentCollection)
        currentCollection.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentCollection, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("finishPick"))
        var group : dispatch_group_t = dispatch_group_create()
        var queue : dispatch_queue_t = dispatch_queue_create("com.dustec.MeijiaOc", DISPATCH_QUEUE_SERIAL)
//        dispatch_group_async(group, queue) {[weak self] () -> Void in
//            self?.toBackThread()
//            return
//        }
//        
//        dispatch_group_notify(group, dispatch_get_main_queue()) {[weak self] () -> Void in
//            self?.currentCollection.reloadData()
//            return
//        }
        // Do any additional setup after loading the view.
    }

    func finishPick()
    {
        self.delegate?.selectFinish(assetForSelect)
    }
    
    func setMaxNumOfSelect(maxNum : Int)
    {
        self.maxNumOfSelect = maxNum
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAssetsArr(assetsArr : ALAssetsGroup)
    {
        self.assetGroup = assetsArr
        toBackThread()
    }

    func toBackThread()
    {
        var assetEnumBlock : ALAssetsGroupEnumerationResultsBlock = {[weak self] (asset, index, stop) -> Void in
            if(asset != nil)
            {
                self?.assetsArr.append(asset)
            }
        }
        var filter : ALAssetsFilter = ALAssetsFilter.allPhotos()
        assetGroup.enumerateAssetsUsingBlock(assetEnumBlock)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZXY_ImagePickerCollectionVC: UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var imageHe      = UIScreen.mainScreen().bounds
        var width        = (imageHe.width - 40)/4
        return CGSizeMake(width , width)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(isFirst)
        {
            collectionView.registerClass(ZXY_ImagePickCoCell.self, forCellWithReuseIdentifier: "zxy_Collection")
        }
        var cell : ZXY_ImagePickCoCell? = collectionView.dequeueReusableCellWithReuseIdentifier("zxy_Collection", forIndexPath: indexPath) as? ZXY_ImagePickCoCell
        if(cell == nil)
        {
            cell = ZXY_ImagePickCoCell()
            
        }
        cell?.hideSelectImg()
        var currentAsset = self.assetsArr[indexPath.row]
        var cgImage      = currentAsset.thumbnail().takeUnretainedValue()
        var currentImg   = UIImage(CGImage: cgImage)
        cell?.currentImageV.image = currentImg
        if(contains(assetForSelect, currentAsset))
        {
            cell?.showSelectImg()
        }
        else
        {
            cell?.hideSelectImg()
        }
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var currentAsset = self.assetsArr[indexPath.row]
        if(contains(assetForSelect, currentAsset))
        {
            for(index, value) in enumerate(assetForSelect)
            {
                if(value == currentAsset)
                {
                    assetForSelect.removeAtIndex(index)
                }
            }
            currentCollection.reloadItemsAtIndexPaths([indexPath])
            //currentCollection.reloadData()
            if(assetForSelect.count == 0)
            {
                self.navigationItem.rightBarButtonItem?.enabled = false
            }
            else
            {
                self.navigationItem.rightBarButtonItem?.enabled = true
            }
            return
        }

        if(assetForSelect.count < maxNumOfSelect)
        {
            
            assetForSelect.append(currentAsset)
            if(assetForSelect.count == 0)
            {
                self.navigationItem.rightBarButtonItem?.enabled = false
            }
            else
            {
                self.navigationItem.rightBarButtonItem?.enabled = true
            }

            currentCollection.reloadItemsAtIndexPaths([indexPath])
            //currentCollection.reloadData()
        }
        else
        {
            var alert  = UIAlertView(title: "提示", message: "最多可以选择 \(maxNumOfSelect) 张图片", delegate: nil, cancelButtonTitle: "确定")
            alert.show()
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assetsArr.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
}
