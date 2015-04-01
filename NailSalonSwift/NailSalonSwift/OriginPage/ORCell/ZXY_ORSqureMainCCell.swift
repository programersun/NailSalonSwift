//
//  ZXY_ORSqureMainCCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORSqureMainCCell: UICollectionViewCell {
    
    @IBOutlet weak var artImg    : UIImageView!
    @IBOutlet weak var artistAva : UIImageView!
    @IBOutlet weak var artTitle  : UILabel!
    @IBOutlet weak var artDoLike : UILabel!
    @IBOutlet weak var isArtImg  : UIImageView!
    @IBOutlet weak var isArtName : UILabel!
    @IBOutlet weak var artName   : UILabel!
    
    @IBOutlet weak var layerView: UIView!
    
    class  func cellID() -> String
    {
        return "ZXY_ORSqureMainCCellID"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
        super.drawLayer(layer, inContext: ctx)
        
    }
    
}
