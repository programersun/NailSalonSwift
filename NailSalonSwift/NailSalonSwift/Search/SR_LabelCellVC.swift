//
//  SR_LabelCellVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_LabelCellVC: UITableViewCell {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var toolBar: UIImageView!
    @IBOutlet weak var isArtist: UILabel!
    @IBOutlet weak var ablumName: UILabel!
    
    class func cellID() -> String
    {
        return "SR_LabelCellID"
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
