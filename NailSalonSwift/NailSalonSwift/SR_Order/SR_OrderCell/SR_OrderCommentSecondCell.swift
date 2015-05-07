//
//  SR_OrderCommentSecondCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_OrderCommentSecondCellProtocol : class
{
    func clickImg()
}

class SR_OrderCommentSecondCell: UITableViewCell {

    @IBOutlet weak var showImgView: UIImageView!
    var delegate : SR_OrderCommentSecondCellProtocol?
    class func cellID() -> String
    {
        return "SR_OrderCommentSecondCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var tapImg = UITapGestureRecognizer(target: self, action: "imgClick")
        showImgView.addGestureRecognizer(tapImg)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imgClick() {
        if let de = delegate
        {
            de.clickImg()
        }
    }
}
