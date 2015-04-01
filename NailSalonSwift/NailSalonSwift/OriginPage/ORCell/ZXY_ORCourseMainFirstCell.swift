//
//  ZXY_ORCourseMainCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/31.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORCourseMainFirstCell: UITableViewCell {

    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var headerSubTitleLbl: UILabel!
    @IBOutlet weak var littleBar: UIImageView!
    
    
    @IBOutlet var imgS: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func cellID() -> String
    {
        return "ZXY_ORCourseMainFirstCellID"
    }
}
