//
//  ZXY_DFPArtistCollectionVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_DFPArtistCollectionVCDelegate : class
{
    func collectionDidScroll(contentOffSet : CGPoint)
}

class ZXY_DFPArtistCollectionVC: UIViewController {

    @IBOutlet weak var currentCollection: UICollectionView!
    var layout = CHTCollectionViewWaterfallLayout()
    var delegatela : ZXY_DFPArtistCollectionVCDelegate?
    class func vcID() -> String
    {
        return "ZXY_DFPArtistCollectionVCID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLayoutType(2)
        // Do any additional setup after loading the view.
    }
    
    private func changeLayoutType(columnNum : Int)
    {
        layout.headerHeight = 211
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.columnCount = columnNum
        currentCollection.setCollectionViewLayout(layout, animated: false)
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

extension ZXY_DFPArtistCollectionVC : UICollectionViewDelegate , UICollectionViewDataSource , CHTCollectionViewDelegateWaterfallLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_DFPArtistCollectCell.cellID, forIndexPath: indexPath) as ZXY_DFPArtistCollectCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var nib = UINib(nibName: "ZXY_DFPArtistTitleView", bundle: nil)
        collectionView.registerNib(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: ZXY_DFPArtistTitleView.cellID())
        var titleView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ZXY_DFPArtistTitleView.cellID(), forIndexPath: indexPath) as ZXY_DFPArtistTitleView
        return titleView
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSizeMake((UIScreen.mainScreen().bounds.width - 15) / 2, 250)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let de = delegatela
        {
            de.collectionDidScroll(scrollView.contentOffset)
        }
    }
}
