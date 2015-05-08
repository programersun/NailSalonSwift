//
//  SR_OrderDetailCommentCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/8.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderDetailCommentCell: UITableViewCell {
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var commentString: UILabel!
    @IBOutlet weak var commentTime: UILabel!
    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var starView: UIView!
    
    var starRateView : CWStarRateView?
    
    class func cellID() -> String
    {
        return "SR_OrderDetailCommentCellID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        headImg.layer.cornerRadius = CGRectGetWidth(headImg.bounds) / 2
        headImg.layer.masksToBounds = true
        self.starRateView = CWStarRateView(frame: CGRectMake(7, 8, 86, 12), numberOfStars: 5)
        self.starRateView?.userInteractionEnabled = true
        self.starRateView?.allowIncompleteStar = true
        self.starRateView?.hasAnimation = true
        self.starView.addSubview(starRateView!)
        self.commentTime.textColor = UIColor.NailGrayColor()
        self.nickName.textColor = UIColor.NailRedColor()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
