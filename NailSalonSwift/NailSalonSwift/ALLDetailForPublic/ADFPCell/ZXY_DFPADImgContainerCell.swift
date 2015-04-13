//
//  ZXY_DFPADImgContainerCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPADImgContainerCell: UITableViewCell {

    @IBOutlet weak var contentImg : UIImageView!
    @IBOutlet weak var artistAvatar : UIImageView!
    @IBOutlet weak var imgName : UILabel!
    @IBOutlet weak var artistName : UILabel!
    @IBOutlet weak var pageNum : UIPageControl!
    @IBOutlet weak var attensionBtn : UIButton!
    @IBOutlet weak var heartImg : UIImageView!
    @IBOutlet weak var starImg : UIImageView!
    @IBOutlet weak var heartLbl : UILabel!
    @IBOutlet weak var starLbl  : UILabel!
    
    class func cellID() -> String
    {
        return "ZXY_DFPADImgContainerCellID"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        attensionBtn.layer.masksToBounds = true
        attensionBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
        attensionBtn.layer.cornerRadius  = 4
        attensionBtn.layer.borderWidth   = 1
        attensionBtn.layer.borderColor   = UIColor.NailRedColor().CGColor
        
        artistAvatar.layer.cornerRadius  = 22
        artistAvatar.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func isCollectionFunc(isCollection : Double)
    {
        if isCollection == 1
        {
            self.starImg.image = UIImage(named: "star")
        }
        else
        {
            self.starImg.image = UIImage(named: "starEmpty")
        }
    }
    
    func isAgreeFunc(isAgree : Double)
    {
        if isAgree     == 1
        {
            self.heartImg.image = UIImage(named: "heart")
        }
        else
        {
            self.heartImg.image = UIImage(named: "heartEmpty")
        }
    }
    
    func isAttensionFunc(isAtten : Double)
    {
        if isAtten == 1
        {
            self.attensionBtn.setTitleColor(UIColor.NailGrayColor(), forState: UIControlState.Normal)
            self.attensionBtn.setTitle("已关注", forState: UIControlState.Normal)
            self.attensionBtn.layer.borderColor = UIColor.NailGrayColor().CGColor
        }
        else
        {
            self.attensionBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
            self.attensionBtn.setTitle("关 注", forState: UIControlState.Normal)
            self.attensionBtn.layer.borderColor = UIColor.NailRedColor().CGColor
        }
    }

}
