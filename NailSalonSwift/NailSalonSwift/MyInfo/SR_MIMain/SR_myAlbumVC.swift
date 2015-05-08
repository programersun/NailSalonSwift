
//
//  SR_myAlbumVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/26.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_myAlbumVCProtocol : class {
    func backToOrder(ablumDesc : String , ablumId : String?) -> Void
}

class SR_myAlbumVC: UIViewController {

    @IBOutlet weak var ablumCollection: UICollectionView!
    
    
    var layout = CHTCollectionViewWaterfallLayout()
    var ablumPage : Int = 1
    var userID : String?
    var artistID : String?
    var isDownLoad = false
    private var dataForShow : NSMutableArray = NSMutableArray()
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    var delegate : SR_myAlbumVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ablumCollection.backgroundColor = UIColor.NailBackGrayColor()
        self.changeLayoutType(2)
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
    override func viewWillAppear(animated: Bool) {
        srW.startProgress(self.view)
        self.startDownLoadAlbum()
        
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
        ablumCollection.headerEndRefreshing()
        var urlString = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADPF_ArtistArts)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id" : self.artistID! , "p" : ablumPage], successBlock: { [weak self](returnDic) -> Void in
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
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(SR_myAlbumCell.cellID, forIndexPath: indexPath) as! SR_myAlbumCell
        var currentRow = indexPath.row
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as! ZXY_UserAlbumListData
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
        
        var currentData : ZXY_UserAlbumListData = dataForShow[currentRow] as! ZXY_UserAlbumListData
        var width       = (currentData.cutWidth as NSString).floatValue
        var height      = (currentData.cutHeight as NSString).floatValue
        
        var radio       = height / width
        
        var screenWidths = self.view.frame.size.width / 2 - 10
        
        var imgRealHeight = CGFloat(radio) * screenWidths
        
        return CGSizeMake(screenWidths, imgRealHeight + 70)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var current = dataForShow[indexPath.row] as! ZXY_UserAlbumListData
        
        //userID == artistID 跳转到我的图集详细页面
        //userID != artistID 跳转回订单页面
        if self.userID == self.artistID {
            var story = UIStoryboard(name: "PublicStory", bundle: nil)
            var vc    = story.instantiateViewControllerWithIdentifier("artDetailID") as! ZXY_DFPArtDetailVC
            vc.artWorkID = current.albumId ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            self.delegate?.backToOrder(current.dataDescription , ablumId: current.albumId)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
