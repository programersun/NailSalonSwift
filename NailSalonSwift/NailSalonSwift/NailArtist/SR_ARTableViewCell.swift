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
    @IBOutlet var artistStar: [UIImageView]!
    @IBOutlet weak var artistV: UIImageView!
    
    class var identifier: String {
        return "ARTableViewCellIdentifier"
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
