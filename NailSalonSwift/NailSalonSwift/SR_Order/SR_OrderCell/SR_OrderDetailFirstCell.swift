//
//  SR_OrderDetailFirstCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/5.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderDetailFirstCell: UITableViewCell {
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    
    class func cellID() -> String
    {
        return "SR_OrderDetailFirstCellID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func messageBtnClick(sender: AnyObject) {
        
    }
    
    @IBAction func telBtnClick(sender: AnyObject) {
    }

}
