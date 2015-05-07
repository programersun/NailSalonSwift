//
//  SR_OrderCommentFirstCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit



class SR_OrderCommentFirstCell: UITableViewCell {
    
    @IBOutlet weak var commentText: UITextField!
    
    class func cellID() -> String
    {
        return "SR_OrderCommentFirstCellID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//        commentText.
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
