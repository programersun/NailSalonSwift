
//
//  SR_myAlbumVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/26.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_myAlbumVC: UIViewController {

    @IBOutlet weak var ablumCollection: UICollectionView!
    
    @IBOutlet weak var topBarView: UIView!
    var layout = CHTCollectionViewWaterfallLayout()
    var ablumPage : Int = 1
    var userID : String?
    var isDownLoad = false
    private var dataForShow : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBarView.backgroundColor = UIColor.NailRedColor()
        self.navigationController?.navigationBar.hidden = true
        ablumCollection.backgroundColor = UIColor.NailBackGrayColor()
        self.changeLayoutType(2)
        startDownLoadAlbum()
        ablumCollection.addFooterWithCallback {[weak self] () -> Void in
            self?.startDownLoadAlbum()
            ""
            ""
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func changeLayoutType(columnNum : Int)
    {
        layout.headerHeight = 0
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumColumnSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.columnCount = columnNum
        ablumCollection.setCollectionViewLayout(layout, animated: false)
    }
    
    func startDownLoadAlbum()
    {
        ablumCollection.footerEndRefreshing()
        if(isDownLoad)
        {
            return
        }
        isDownLoad = true
        var urlString = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADPF_ArtistArts)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id" : self.userID! , "p" : ablumPage], successBlock: { [weak self](returnDic) -> Void in
            var arr = ZXY_UserAlbumListBase(dictionary: returnDic).data
            if(self?.ablumPage == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.ablumCollection.footerEndRefreshing()
            self?.ablumCollection.reloadData()
            }) {[weak self] (error) -> Void in
                ""
                self?.ablumCollection.footerEndRefreshing()
                ""
        }
        
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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

extension SR_myAlbumVC : UICollectionViewDelegate , UICollectionViewDataSource , CHTCollectionViewDelegateWaterfallLayout
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return dataForShow.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(SR_myAlbumCell.cellID, forIndexPath: indexPath) as SR_myAlbumCell
        var currentRow = indexPath.row
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as ZXY_UserAlbumListData
        var artImage : String?      = ZXY_ALLApi.ZXY_MainAPIImage + currentData.cutPath
        if(artImage != nil)
        {
            cell.artImg.setImageWithURL(NSURL(string: artImage!), placeholderImage: UIImage(named: "imgHolder"))
        }
        cell.artName.text = currentData.dataDescription
        cell.agreeNum.text = currentData.agreeCount
        // Configure the cell
        
        return cell
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
    
}
