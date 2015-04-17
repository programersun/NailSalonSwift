//
//  ZXY_ChangeUserSexCell.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/11.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

let ZXY_ChangeUserSexCellID = "ZXY_ChangeUserSexCellID"

typealias ZXY_ChangeUserSexCellBlock = (flag: Int) -> Void
class ZXY_ChangeUserSexCell: UITableViewCell {

    @IBOutlet weak var girlBtn: UIButton!
    @IBOutlet weak var boyBtn: UIButton!
    @IBOutlet weak var girlFlag: UIImageView!
    @IBOutlet weak var boyFlag: UIImageView!
    var userSelectBoyOrGirlBlock : ZXY_ChangeUserSexCellBlock!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectGirl(sender: AnyObject) {
        self.userSelectBoyOrGirlBlock(flag: 2)
        boyBtn.setImage(UIImage(named: "littleBoy_gray"), forState: UIControlState.Normal)
        girlBtn.setImage(UIImage(named: "littleGirl_red"), forState: UIControlState.Normal)
        
    }
    
    
    @IBAction func selectBoy(sender: AnyObject) {
        self.userSelectBoyOrGirlBlock(flag: 1)
        boyBtn.setImage(UIImage(named: "littleBoy_blue"), forState: UIControlState.Normal)
        girlBtn.setImage(UIImage(named: "littleGirl_gray"), forState: UIControlState.Normal)
    }
}
