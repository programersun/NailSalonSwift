//
//  ZL_SSMainCell.swift
//  NailSalonSwift
//
//  Created by 赵磊 on 15/4/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZL_SSMainCell: UITableViewCell {

    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var segLine: UIImageView!
    class func cellID() -> String
    {
        return "ZL_SSMainCellID"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
