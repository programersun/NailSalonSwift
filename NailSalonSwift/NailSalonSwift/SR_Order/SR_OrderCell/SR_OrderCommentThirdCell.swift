//
//  SR_OrderCommentThirdCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderCommentThirdCell: UITableViewCell {

    @IBOutlet weak var starView: UIView!
    
    var starRateView : CWStarRateView?
    
    class func cellID() -> String
    {
        return "SR_OrderCommentThirdCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.starRateView = CWStarRateView(frame: CGRectMake(7, 8, 86, 12), numberOfStars: 5)
        self.starRateView?.userInteractionEnabled = true
        self.starRateView?.allowIncompleteStar = true
        starRateView?.hasAnimation = true
        self.starView.addSubview(starRateView!)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
