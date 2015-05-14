//
//  SR_albumCollectionVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit


class SR_albumCollectionVC: UIViewController {
    @IBOutlet weak var ablumCollection: UICollectionView!
    var layout = CHTCollectionViewWaterfallLayout()
    var delegatela : ZXY_DFPArtistCollectionVCDelegate?
    var ablumPage : Int = 1
    var userID : String?
    var isDownLoad = false
    var dataForShow : NSMutableArray = NSMutableArray()
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        srW.startProgress(self.view)
        ablumCollection.backgroundColor = UIColor.NailBackGrayColor()
        self.changeLayoutType(2)
        
        startDownLoadAlbum()
        ablumCollection.addFooterWithCallback {[weak self] () -> Void in
            self?.ablumPage++
            self?.startDownLoadAlbum()
            ""
            ""
        }
        ablumCollection.addHeaderWithCallback { [weak self]() -> Void in
            self?.ablumPage = 1
            self?.startDownLoadAlbum()
            ""
        }
        // Do any additional setup after loading the view.
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
        ablumCollection.headerEndRefreshing()
        if(isDownLoad)
        {
            return
        }
        isDownLoad = true
        var urlString = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.SR_albumCollection)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id" : self.userID! , "p" : ablumPage], successBlock: { [weak self](returnDic) -> Void in
            var arr = SR_albumCollectionBaseClass(dictionary: returnDic).data
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
            self?.ablumCollection.headerEndRefreshing()
            self?.ablumCollection.reloadData()
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            }) {[weak self] (error) -> Void in
                self?.ablumCollection.footerEndRefreshing()
                self?.ablumCollection.headerEndRefreshing()
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
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

extension SR_albumCollectionVC : UICollectionViewDelegate , UICollectionViewDataSource , CHTCollectionViewDelegateWaterfallLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(SR_myAlbumCell.cellID, forIndexPath: indexPath) as! SR_myAlbumCell
        var currentRow = indexPath.row
        var currentData : SR_albumCollectionData = dataForShow[currentRow] as! SR_albumCollectionData
        var artImage : String?      = ZXY_ALLApi.ZXY_MainAPIImage + currentData.cutPath
        if(artImage != nil)
        {
            cell.artImg.setImageWithURL(NSURL(string: artImage!), placeholderImage: UIImage(named: "imgHolder"))
        }
        cell.artName.text = currentData.dataDescription
        cell.agreeNum.text = currentData.agreeCount
        
        cell.layer.cornerRadius  = 5
        var path = UIBezierPath(rect: cell.bounds)
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false
        cell.layer.shadowOffset  = CGSizeMake(1, 1)
        cell.layer.shadowColor   = UIColor.darkGrayColor().CGColor
        cell.layer.shadowPath    = path.CGPath
        cell.layer.shadowRadius  = 3
        cell.artImg.layer.cornerRadius = 5
        cell.artImg.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataForShow.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        var currentRow = indexPath.row
        
        var currentData : SR_albumCollectionData = dataForShow[currentRow] as! SR_albumCollectionData
        var width       = (currentData.cutWidth as NSString).floatValue
        var height      = (currentData.cutHeight as NSString).floatValue
        
        var radio       = height / width
        
        var screenWidths = self.view.frame.size.width / 2 - 10
        
        var imgRealHeight = CGFloat(radio) * screenWidths
        
        return CGSizeMake(screenWidths, imgRealHeight + 70)
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var story    = UIStoryboard(name: "PublicStory", bundle: nil)
        var vc       = story.instantiateViewControllerWithIdentifier("artDetailID") as! ZXY_DFPArtDetailVC
        var current  = dataForShow[indexPath.row] as! SR_albumCollectionData
        vc.artWorkID = current.albumId ?? ""
        vc.title     = current.dataDescription ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
