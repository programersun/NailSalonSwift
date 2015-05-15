//
//  SR_ChangeAddressCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/15.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_ChangeAddressCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailAddressLabel: UILabel!
    
    
    class func cellID() -> String
    {
        return "SR_ChangeAddressCellID"
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
