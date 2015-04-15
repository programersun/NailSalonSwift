//
//  ICYProfileCell.swift
//  KickYourAss
//
//  Created by eagle on 15/2/9.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ICYProfileCell: UITableViewCell {
    
    @IBOutlet weak var icyMainLabel: UILabel!
    @IBOutlet weak var icyDetailLabel: UILabel!
    
    class var identifier: String {
        return "ICYProfileCellIdentifier"
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
