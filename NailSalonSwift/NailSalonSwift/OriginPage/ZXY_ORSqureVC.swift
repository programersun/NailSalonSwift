//
//  ZXY_ORSqureVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORSqureVC: UIViewController {

    @IBOutlet weak var mainCollectionV: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ZXY_ORSqureVC : UICollectionViewDataSource , UICollectionViewDelegate, WaterfallLayoutDelegate
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.section
        {
        case 0:
            
             var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_ORSqureTitleCCell.cellID(), forIndexPath: indexPath) as ZXY_ORSqureTitleCCell
             return cell
            
        case 1:
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_ORSqureMainCCell.cellID(), forIndexPath: indexPath) as ZXY_ORSqureMainCCell
            return cell
        default:
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_ORSqureMainCCell.cellID(), forIndexPath: indexPath) as ZXY_ORSqureMainCCell
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
            return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else
        {
            return 5
        }
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        
        var screenSize = UIScreen.mainScreen().bounds
        switch indexPath.section
        {
        case 0:
            return CGSize(width: screenSize.width, height: 264)
        case 1:
            return CGSize(width: screenSize.width / 2.0 - 15, height: 40)
        default:
            return CGSize(width: screenSize.width / 2.0 - 15, height: 40)
        }
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if(section == 0)
        {
            return UIEdgeInsetsZero
        }
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}


