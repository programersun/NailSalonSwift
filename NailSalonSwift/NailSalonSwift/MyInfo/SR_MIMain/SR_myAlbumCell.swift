//
//  SR_myAlbumCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/26.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_myAlbumCell: UICollectionViewCell {
    class var cellID : String
    {
        return "SR_myAlbumCellID"
    }
    @IBOutlet weak var artImg: UIImageView!
    
    @IBOutlet weak var artName: UILabel!
    
    @IBOutlet weak var agreeNum: UILabel!
}
