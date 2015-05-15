//
//  ZXY_MyBlockCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/15.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MyBlockCell: UITableViewCell {

    static let cellID = "ZXY_MyBlockCellID"
    @IBOutlet weak var headerImg : UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startLoadData(artistID : String?)
    {
        if artistID == nil
        {
            return
        }
        var stringURL = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADPF_ArtistDetailInfo)
        var myID = ZXY_UserInfoDetail.sharedInstance.getUserID() ?? ""
        
        var parameter = ["user_id" : artistID! , "my_user_id" : myID]
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            var dataForShow = ZXY_ArtistDetailModelBase(dictionary: returnDic)
            var dataUser    = dataForShow.data
            var head : String? = dataUser.headImage
            
            if let he = head
            {
                var headURL = ZXY_NailNetAPI.ZXY_MainAPIImage + he
                if he.hasPrefix("http")
                {
                    headURL = he
                }
                self?.headerImg.setImageWithURL(NSURL(string : headURL))
            }
            self?.nameLbl.text = dataUser.nickName
        }) { [weak self] (error) -> Void in
                ""
                ""
        }
        
    }


}
