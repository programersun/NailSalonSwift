//
//  ZXY_SendMessageAddInfoCoCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_SendMessageAddInfoCoCellProtocol
{
    func clickCurrentTagLbl()
}


class ZXY_SendMessageAddInfoCoCell: UICollectionViewCell {
    class var cellID : String {
        return "ZXY_SendMessageAddInfoCoCellID"
    }
    
    @IBOutlet weak var priceText: UITextField!
    
    @IBOutlet weak var currentTagLbl: ZXY_TagLabelView!
    
}
