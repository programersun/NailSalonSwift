//
//  SR_ARTableViewCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_ARTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistView: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistWork: UILabel!
    @IBOutlet weak var artistWorkCount: UILabel!
    @IBOutlet weak var artistDistance: UILabel!
    @IBOutlet weak var artistV: UIImageView!
    @IBOutlet weak var artistStar: UIView!
    
    var starRateView : CWStarRateView?
    
    class var identifier: String {
        return "ARTableViewCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        artistName.textColor = UIColor.NailRedColor()
        artistWorkCount.textColor = UIColor.NailRedColor()
        artistWork.textColor = UIColor.NailGrayColor()
        artistDistance.textColor = UIColor.NailGrayColor()
        self.starRateView = CWStarRateView(frame: CGRectMake(7, 8, 86, 12), numberOfStars: 5)
        self.starRateView?.allowIncompleteStar = true
        starRateView?.hasAnimation = true
        self.artistStar.addSubview(starRateView!)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
