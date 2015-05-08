//
//  SR_OrderCommentThirdCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_OrderCommentThirdCellProtocol : class
{
    func scoreChange(score : CGFloat)
}

class SR_OrderCommentThirdCell: UITableViewCell {

    @IBOutlet weak var starView: UIView!
    
    var starRateView : CWStarRateView?
    weak var delegate : SR_OrderCommentThirdCellProtocol?
    
    class func cellID() -> String
    {
        return "SR_OrderCommentThirdCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.starRateView = CWStarRateView(frame: CGRectMake(7, 8, 86, 12), numberOfStars: 5)
        self.starRateView?.userInteractionEnabled = true
        self.starRateView?.allowIncompleteStar = true
        self.starRateView?.delegate = self
        starRateView?.hasAnimation = true
        self.starView.addSubview(starRateView!)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension SR_OrderCommentThirdCell : CWStarRateViewDelegate {
    
    func starRateView(starRateView: CWStarRateView!, scroePercentDidChange newScorePercent: CGFloat) {
        var score = starRateView.scorePercent
        if let de = delegate {
            de.scoreChange(score * 5)
        }
    }
}
