//
//  ZXY_DFPArtistCollectCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtistCollectCell: UICollectionViewCell {
    class var cellID : String
    {
        return "ZXY_DFPArtistCollectCellID"
    }
    
    @IBOutlet weak var artImg: UIImageView!
    
    @IBOutlet weak var artName: UILabel!
    
    @IBOutlet weak var agreeNum: UILabel!
    @IBOutlet weak var layerView: UIView!
}
