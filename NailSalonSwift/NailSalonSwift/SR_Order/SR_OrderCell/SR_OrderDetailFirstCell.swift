//
//  SR_OrderDetailFirstCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/5.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_OrderDetailFirstCellProtocol : class
{
    func clickHeadImg()
    func clickMessage()
    func clickTel()
}

class SR_OrderDetailFirstCell: UITableViewCell {

    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var telBtn: UIButton!
    @IBOutlet weak var chatBtnWidth: NSLayoutConstraint!
    
    
    weak var delegate : SR_OrderDetailFirstCellProtocol?
    
    class func cellID() -> String
    {
        return "SR_OrderDetailFirstCellID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        headImg.layer.cornerRadius = CGRectGetWidth(headImg.bounds) / 2
        headImg.layer.masksToBounds = true
        headImg.layer.borderColor  = UIColor.NailRedColor().CGColor
        headImg.layer.borderWidth  = 1
        var tapDetailHead = UITapGestureRecognizer(target: self, action: "detialHeadImgClick")
        headImg.addGestureRecognizer(tapDetailHead)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func detialHeadImgClick(){
        if let de = delegate
        {
            de.clickHeadImg()
        }
    }
    
    @IBAction func messageBtnClick(sender: AnyObject) {
        if let de = delegate
        {
            de.clickMessage()
        }
    }
    
    @IBAction func telBtnClick(sender: AnyObject) {
        if let de = delegate
        {
            de.clickTel()
        }
    }

}
