//
//  SR_CourseDetailListCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_CourseDetailListCell: UITableViewCell {

    
    @IBOutlet weak var courseImgView: UIImageView!
    @IBOutlet weak var courseIntroductionLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var coursePraiseNum: UILabel!
    @IBOutlet weak var courseCollectionNum: UILabel!
    
    
//    Praise
//    Collection
    class var identifier: String {
        return "SR_CourseDetailListCellIdentifier"
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
