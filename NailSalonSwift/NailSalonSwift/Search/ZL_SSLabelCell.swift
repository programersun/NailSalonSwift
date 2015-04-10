//
//  ZL_SSLabelCell.swift
//  NailSalonSwift
//
//  Created by 赵磊 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZL_SSLabelCell: UITableViewCell {
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    class func cellID() -> String
    {
        return "ZL_SSLabelCellID"
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
