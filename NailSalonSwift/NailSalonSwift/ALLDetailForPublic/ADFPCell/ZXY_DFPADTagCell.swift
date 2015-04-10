//
//  ZXY_DFPADTagCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPADTagCell: UITableViewCell {

    @IBOutlet weak var tagLbl : UILabel!
    @IBOutlet weak var priceLbl : UILabel!
    @IBOutlet weak var tagCollection : UICollectionView!
    @IBOutlet weak var priceValue    : UILabel!
    
    class func cellID() -> String
    {
        return "ZXY_DFPADTagCellID"
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
