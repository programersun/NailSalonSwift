//
//  SettingCell.swift
//  KickYourAss
//
//  Created by sun on 15/4/21.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var setCellText: UILabel!
    
    class var identifier: String {
        return "SettingCellIdentifier"
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
