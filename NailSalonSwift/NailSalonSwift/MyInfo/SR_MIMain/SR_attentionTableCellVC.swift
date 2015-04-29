//
//  SR_attentionTableCellVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/25.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_attentionTableCellVC: UITableViewCell {
    @IBOutlet weak var headImgView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userWork: UILabel!
    @IBOutlet weak var userWorkCount: UILabel!
    @IBOutlet weak var userStar: UIView!
    @IBOutlet weak var toolView: UIImageView!
    @IBOutlet weak var isArtist: UILabel!
    
    var starRateView : CWStarRateView?
    
    class  var cellId : String
    {
        return "SR_attentionTableCellVCID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        userName.textColor = UIColor.NailRedColor()
        userWorkCount.textColor = UIColor.NailRedColor()
        userWork.textColor = UIColor.NailGrayColor()
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
