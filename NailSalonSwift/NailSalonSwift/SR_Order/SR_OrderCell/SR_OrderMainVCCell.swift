//
//  SR_OrderMainVCCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/30.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderMainVCCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var insertLabel: UILabel!
    
    class func cellID() -> String
    {
        return "SR_OrderMainVCCellID"
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
