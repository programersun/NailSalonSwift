//
//  ZXY_DFPADImgContainerCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_DFPADImgContainerCellProtocol : class
{
    func userClickAttensionImg()
    func userClickCollectionImg()
    func userClickAgreeImg()
    
    func clickImageAtIndexPath(indexPath : NSIndexPath)
}

class ZXY_DFPADImgContainerCell: UITableViewCell {

    
    @IBOutlet weak var artistAvatar : UIImageView!
    @IBOutlet weak var imgName : UILabel!
    @IBOutlet weak var artistName : UILabel!
    @IBOutlet weak var pageNum : UIPageControl!
    @IBOutlet weak var attensionBtn : UIButton!
    @IBOutlet weak var heartImg : UIImageView!
    @IBOutlet weak var starImg : UIImageView!
    @IBOutlet weak var heartLbl : UILabel!
    @IBOutlet weak var starLbl  : UILabel!
    @IBOutlet weak var imgCollection : UICollectionView!
    var delegate : ZXY_DFPADImgContainerCellProtocol?
    var imgS     : [AnyObject]? = []
    class func cellID() -> String
    {
        return "ZXY_DFPADImgContainerCellID"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        attensionBtn.layer.masksToBounds = true
        attensionBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
        attensionBtn.layer.cornerRadius  = 4
        attensionBtn.layer.borderWidth   = 1
        attensionBtn.layer.borderColor   = UIColor.NailRedColor().CGColor
        artistAvatar.layer.cornerRadius  = 22
        artistAvatar.layer.masksToBounds = true
        var tapCollection = UITapGestureRecognizer(target: self, action: Selector("collectionImgAction:"))
        var tapAgree      = UITapGestureRecognizer(target: self, action: Selector("agreeImgAction:"))
        self.heartImg.addGestureRecognizer(tapAgree)
        self.starImg.addGestureRecognizer(tapCollection)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isCollectionFunc(isCollection : Double)
    {
        if isCollection == 1
        {
            self.starImg.image = UIImage(named: "star")
        }
        else
        {
            self.starImg.image = UIImage(named: "starEmpty")
        }
    }
    
    func isAgreeFunc(isAgree : Double)
    {
        if isAgree     == 1
        {
            self.heartImg.image = UIImage(named: "heart")
        }
        else
        {
            self.heartImg.image = UIImage(named: "heartEmpty")
        }
    }
    
    func isAttensionFunc(isAtten : Double)
    {
        if isAtten == 1
        {
            self.attensionBtn.setTitleColor(UIColor.NailGrayColor(), forState: UIControlState.Normal)
            self.attensionBtn.setTitle("已关注", forState: UIControlState.Normal)
            self.attensionBtn.layer.borderColor = UIColor.NailGrayColor().CGColor
        }
        else
        {
            self.attensionBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
            self.attensionBtn.setTitle("关 注", forState: UIControlState.Normal)
            self.attensionBtn.layer.borderColor = UIColor.NailRedColor().CGColor
        }
    }

    @IBAction func attensionAction(sender: AnyObject) {
        if let de = delegate
        {
            de.userClickAttensionImg()
        }
    }
    
    func agreeImgAction(tap : UITapGestureRecognizer)
    {
        if let de = delegate
        {
            de.userClickAgreeImg()
        }
    }
    
    func collectionImgAction(tap : UITapGestureRecognizer)
    {
        if let de = delegate
        {
            de.userClickCollectionImg()
        }
    }
}

extension ZXY_DFPADImgContainerCell : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var imgData = imgS![indexPath.row] as ZXY_AlbumDetailImages
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectImgID", forIndexPath: indexPath) as UICollectionViewCell
        var img : UIImageView  = cell.viewWithTag(11111) as UIImageView
        var imgURLString : String? =  imgData.imagePath
        if let stringURL = imgURLString
        {
            var imgURL : String? = ZXY_NailNetAPI.ZXY_MainAPIImage + imgData.imagePath

            img.setImageWithURL(NSURL(string: imgURL!))
        }
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = imgS
        {
            return images.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width, 266)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let de = delegate
        {
            de.clickImageAtIndexPath(indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var contentOffX = scrollView.contentOffset.x
        var currentPage = contentOffX / UIScreen.mainScreen().bounds.width
        self.pageNum.currentPage = Int(currentPage)
    }
    
}


