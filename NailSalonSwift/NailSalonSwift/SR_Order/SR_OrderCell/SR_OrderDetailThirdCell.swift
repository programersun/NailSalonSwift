//
//  SR_OrderDetailThirdCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/5.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderDetailThirdCell: UITableViewCell {
    
    @IBOutlet weak var orderAblum: UILabel!
    
    class func cellID() -> String
    {
        return "SR_OrderDetailThirdCellID"
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
