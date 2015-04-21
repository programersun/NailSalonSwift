//
//  ICYProfileAvatarCell.swift
//  KickYourAss
//
//  Created by sun on 15/4/17.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ICYProfileAvatarCell: UITableViewCell {
    

    @IBOutlet weak var icyMainLabel: UILabel!
    class var identifier: String {
        return "ICYProfileAvatarCellIdentifier"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // 头像
    @IBOutlet weak var icyImageView: UIImageView!
    var imagePath: String? {
        didSet {
            if let path = imagePath {
                icyImageView.setImageWithURL(NSURL(string: path), placeholderImage: UIImage(named:"avatarPlaceholder"))
            } else {
                icyImageView.image = UIImage(named:"avatarPlaceholder")
            }
        }
    }
}
