//
//  ZXY_SheetViewCell.swift
//  ZXYPrettysHealth
//
//  Created by 宇周 on 15/1/16.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol SheetViewCellDelegate : class
{
    func clickButtonWithIndex(index : Int) -> Void
}

let ZXY_SheetViewCellID = "ZXY_SheetViewCellID"
class ZXY_SheetViewCell: UITableViewCell {
    private var btnString : String!
    private var btnBack   : UIColor = UIColor.whiteColor()
    private var txtColor  : UIColor = UIColor.blackColor()
    private var txtBtn    : UIButton?
    private var currentIndex : Int?
    weak    var delegate : SheetViewCellDelegate?
    func setBtnString(btnString: String!)
    {
        self.btnString = btnString
    }
    
    func setBackColor(btnColor: UIColor)
    {
        self.btnBack = btnColor
    }
    
    func setTxTColor(txtColor: UIColor)
    {
        self.txtColor = txtColor
    }
    
    func setCurrentIndex(index : Int)
    {
        self.currentIndex = index
    }
    
    func drawCurrentRect() -> Void
    {
        if let isNil = txtBtn
        {
            
        }
        else
        {
            txtBtn = UIButton(frame: CGRectMake(15, 5, self.frame.size.width-30, self.frame.size.height-10))
            //txtBtn?.frame =
            txtBtn?.setTitle(btnString, forState: UIControlState.Normal)
            txtBtn?.setTitleColor(txtColor, forState: UIControlState.Normal)
            txtBtn?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
            txtBtn?.backgroundColor = self.btnBack
            txtBtn?.layer.cornerRadius = 5
            txtBtn?.layer.masksToBounds = true
            txtBtn?.layer.borderWidth   = 1/(UIScreen.mainScreen().scale)
            txtBtn?.addTarget(self, action: Selector("clickBtn"), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(txtBtn!)
            
        }
        
    }
    
    func clickBtn() -> Void
    {
        if(self.delegate != nil)
        {
            self.delegate?.clickButtonWithIndex(self.currentIndex!)
        }
    }
    
    override func drawRect(rect: CGRect) {
        self.selectionStyle = UITableViewCellSelectionStyle.None
        super.drawRect(CGRectMake(0, 0, self.window!.bounds.width, 50))
        //self.backgroundColor = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1)
        self.drawCurrentRect()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
        super.drawLayer(layer, inContext: ctx)
    }
}
