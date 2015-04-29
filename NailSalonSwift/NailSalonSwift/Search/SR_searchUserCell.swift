//
//  SR_searchUserCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_searchUserCell: UITableViewCell {
    
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var userWork: UILabel!
    @IBOutlet weak var userWorkCount: UILabel!
    @IBOutlet weak var userDistance: UILabel!
    @IBOutlet weak var userV: UIImageView!
    @IBOutlet weak var userStar: UIView!
    @IBOutlet weak var isArtistLabel: UILabel!
    @IBOutlet weak var toolBar: UIImageView!
    
    var starRateView : CWStarRateView?
    
    class func cellID() -> String
    {
        return "SR_searchUserCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nickName.textColor = UIColor.NailRedColor()
        userWorkCount.textColor = UIColor.NailRedColor()
        userWork.textColor = UIColor.NailGrayColor()
        userDistance.textColor = UIColor.NailGrayColor()
        self.starRateView = CWStarRateView(frame: CGRectMake(7, 8, 86, 12), numberOfStars: 5)
        self.starRateView?.allowIncompleteStar = true
        starRateView?.hasAnimation = true
        self.userStar.addSubview(starRateView!)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
