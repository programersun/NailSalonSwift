//
//  ZXY_MIMainVCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_MIMainVCellProtocol : class
{
    func loginBtnClick() -> Void
    func headImgTouch() -> Void
    func backImgTouch() -> Void
}

class ZXY_MIMainVCell: UITableViewCell {

    @IBOutlet weak var isArtistLbl: UILabel!
    @IBOutlet weak var isArtistImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var backImg: UIImageView!
    
    @IBOutlet weak var isLogin: UILabel!
    
    @IBOutlet weak var userAvatar: UIImageView!
    
    weak var delegate : ZXY_MIMainVCellProtocol?
    var heahTap : UITapGestureRecognizer?
    
    
    class func cellID() -> String
    {
        return "ZXY_MIMainVCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isLogin.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)
        self.isLogin.layer.cornerRadius = 5
        self.isLogin.layer.borderColor  = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5).CGColor
        self.isLogin.layer.borderWidth  = 1
        self.isLogin.layer.masksToBounds = true
        var tap = UITapGestureRecognizer(target: self, action: Selector("userTapLoginOrRegist"))
        isLogin.addGestureRecognizer(tap)
        
        var tapAvatar = UITapGestureRecognizer(target: self, action: "tapAvatarImage")
        userAvatar.addGestureRecognizer(tapAvatar)
        userAvatar.layer.cornerRadius = CGRectGetWidth(userAvatar.bounds) / 2
        userAvatar.layer.masksToBounds  = true
        
        var tapBackImgClick = UITapGestureRecognizer(target: self, action: Selector("backImgClick"))
        backImg.addGestureRecognizer(tapBackImgClick)
        // Initialization code
    }

    func userLoginMethod() -> Void
    {
        self.nameLbl.hidden = false
        self.isArtistImg.hidden = false
        self.isArtistLbl.hidden = false
        self.userAvatar.hidden  = false
        isLogin.hidden = true
    }
    
    func userNotLoginMethod() -> Void
    {
        self.nameLbl.hidden = true
        self.isArtistImg.hidden = true
        self.isArtistLbl.hidden = true
        self.userAvatar.hidden  = true
        isLogin.hidden = false
        
    }
    
    func userTapLoginOrRegist()
    {
        if let p = delegate
        {
            p.loginBtnClick()
        }
    }
    
    func tapAvatarImage()
    {
        if let p = delegate
        {
            p.headImgTouch()
        }
    }
    
    func backImgClick() {
        if let p = delegate
        {
            p.backImgTouch()
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
