//
//  ZXY_DFPADTagCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_DFPADTagCellProtocol : class
{
    func toOrderVC() -> Void
}

class ZXY_DFPADTagCell: UITableViewCell {

    @IBOutlet weak var appointBtn: UIButton!
    @IBOutlet weak var tagLbl : UILabel!
    @IBOutlet weak var priceLbl : UILabel!
    @IBOutlet weak var tagCollection : ZXY_TagLabelView!
    @IBOutlet weak var priceValue    : UILabel!
    var tagString : String?
    
    var isCommonUser : String?
    var artistID : String?
    var userID : String?
    var userInfo : ZXY_UserDetailInfoData!
    private var dataForShow : ZXY_UserDetailInfoUserDetailBase?
    var delegate : ZXY_DFPADTagCellProtocol?
    
    class func cellID() -> String
    {
        return "ZXY_DFPADTagCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //设置预约按钮的显示和隐藏
    func isArtistOrSelf() {
        self.userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if self.userID != nil {
            var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
            if let user = userInfoDic {
                self.dataForShow = ZXY_UserDetailInfoUserDetailBase(dictionary: user)
                userInfo = self.dataForShow?.data
            }
            if userInfo.role == "2" {               //当前用户是美甲师，不能预约
                appointBtn.hidden = true
            }
            if self.artistID == self.userID {       //当前图集的作者是当前用户的图集，不能预约
                appointBtn.hidden = true
            }
            if self.isCommonUser == "1" {           //当前图集的作者是普通用户，不能预约
                appointBtn.hidden = true
            }
        }
        else {
            appointBtn.hidden = true                //未登录，不能预约
        }
    }
    
    func setTagView(tag : String?)
    {
        tagCollection.lineWidth = UIScreen.mainScreen().bounds.width - 71
        tagCollection.setAllTagString(tag ?? "")
        tagCollection.startLoadTag()
    }

    
        //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
        //    {
        //        return CGSizeMake(30, 25)
        //    }

    @IBAction func appointAction(sender: AnyObject) {
        self.delegate?.toOrderVC()
    }
}
