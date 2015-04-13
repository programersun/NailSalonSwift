//
//  ZXY_DFPADCommentCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPADCommentCell: UITableViewCell {

    @IBOutlet weak var criticImg : UIImageView!
    @IBOutlet weak var criticName : UILabel!
    @IBOutlet weak var commentLbl : UILabel!
    @IBOutlet weak var timeLbl    : UILabel!
    
    class func cellID() -> String
    {
        return "ZXY_DFPADCommentCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        criticImg.layer.cornerRadius = 22
        criticImg.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
