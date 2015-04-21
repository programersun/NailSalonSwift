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
    var currentPage : Int = 1
    var userID : String?
    var isDownLoad = false
    private var dataForShow : NSMutableArray = NSMutableArray()
    class func vcID() -> String
    {
        return "ZXY_DFPArtistCollectionVCID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeLayoutType(2)
        startDownLoadAlbum()
        currentCollection.addFooterWithCallback {[weak self] () -> Void in
            self?.startDownLoadAlbum()
            ""
        }
        // Do any additional setup after loading the view.
    }
    
    private func changeLayoutType(columnNum : Int)
    {
        layout.headerHeight = 179
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.columnCount = columnNum
        currentCollection.setCollectionViewLayout(layout, animated: false)
    }

    func startLoadData()
    {
        var stringURL = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADPF_ArtistArts)
    }

    func startDownLoadAlbum()
    {
        currentCollection.footerEndRefreshing()
        if userID == nil
        {
            return
        }
        if(isDownLoad)
        {
            return
        }
        isDownLoad = true
        var urlString = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADPF_ArtistArts)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id" : self.userID! , "p" : currentPage], successBlock: { [weak self](returnDic) -> Void in
            var arr = ZXY_UserAlbumListBase(dictionary: returnDic).data
            if(self?.currentPage == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.currentCollection.footerEndRefreshing()
            self?.currentCollection.reloadData()
            }) {[weak self] (error) -> Void in
                ""
                self?.currentCollection.footerEndRefreshing()
                ""
        }
        
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
        var currentRow = indexPath.row
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as ZXY_UserAlbumListData
        var artImage : String?      = ZXY_ALLApi.ZXY_MainAPIImage + currentData.cutPath
        if(artImage != nil)
        {
            cell.artImg.setImageWithURL(NSURL(string: artImage!), placeholderImage: UIImage(named: "imgHolder"))
        }
        cell.artName.text = currentData.dataDescription
        cell.agreeNum.text = currentData.agreeCount
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForShow.count
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
        var currentRow = indexPath.row
        
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as ZXY_UserAlbumListData
        var width       = (currentData.cutWidth as NSString).floatValue
        var height      = (currentData.cutHeight as NSString).floatValue
        
        var radio       = height / width
        
        var screenWidths = self.view.frame.size.width / 2 - 10
        
        var imgRealHeight = CGFloat(radio) * screenWidths
        
        return CGSizeMake(screenWidths, imgRealHeight + 70)

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let de = delegatela
        {
            de.collectionDidScroll(scrollView.contentOffset)
        }
    }
}
