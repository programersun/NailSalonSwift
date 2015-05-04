//
//  ZXY_SelectTagCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_SelectTagCellDelegate : class
{
    func selectTagA(tagName : String)
}


class ZXY_SelectTagCell: UITableViewCell {

    weak var delegate : ZXY_SelectTagCellDelegate?
    class var cellID : String
        {
        return "ZXY_SelectTagCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var selectBtn : UIButton!

    @IBAction func selectTagAction(sender: AnyObject) {
        if let de = self.delegate
        {
            de.selectTagA(titleLbl.text!)
        }
    }
}
