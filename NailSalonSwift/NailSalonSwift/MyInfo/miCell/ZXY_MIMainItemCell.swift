//
//  ZXY_MIMainItemCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MIMainItemCell: UITableViewCell {

    
    @IBOutlet weak var segLineImg: UIImageView!
    @IBOutlet weak var itemImg: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    
    class func cellID() -> String
    {
        return "ZXY_MIMainItemCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var scale = UIScreen.mainScreen().scale
        var segHight = segLineImg.frame.size.height / scale
        segLineImg.frame = CGRectMake(segLineImg.frame.origin.x, segLineImg.frame.origin.y, segLineImg.frame.size.width, segHight)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
