//
//  ZXY_DFPArtistTableCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtistTableCell: UITableViewCell {

    @IBOutlet weak var criticAvatar: UIImageView!
    
    @IBOutlet weak var commentLbl: UILabel!
    
    @IBOutlet weak var criticName: UILabel!
    
    @IBOutlet weak var addTime: UILabel!
    
    @IBOutlet weak var artImg: UIImageView!
    
    
    class var cellID : String
    {
        return "ZXY_DFPArtistTableCellID"
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
