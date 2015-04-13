//
//  ZXY_DFPADImgContainerCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPADImgContainerCell: UITableViewCell {

    @IBOutlet weak var contentImg : UIImageView!
    @IBOutlet weak var artistAvatar : UIImageView!
    @IBOutlet weak var imgName : UILabel!
    @IBOutlet weak var artistName : UILabel!
    @IBOutlet weak var pageNum : UIPageControl!
    @IBOutlet weak var attensionBtn : UIButton!
    @IBOutlet weak var heartImg : UIImageView!
    @IBOutlet weak var starImg : UIImageView!
    @IBOutlet weak var heartLbl : UILabel!
    @IBOutlet weak var starLbl  : UILabel!
    
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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
