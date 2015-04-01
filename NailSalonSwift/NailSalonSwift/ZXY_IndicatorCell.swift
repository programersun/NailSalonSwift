//
//  ZXY_IndicatorCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/31.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_IndicatorCell: UICollectionViewCell {

    @IBOutlet weak var indicatorImg: UIImageView!
    class func cellID() -> String
    {
         return "ZXY_IndicatorCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //indicatorImg.layer.addAnimation(ZXY_AnimationHelper.animationRotation(), forKey: nil)
    }
    /**
    旋转开始，首先判断图片有无该动画
    如果存在旋转动画效果：return 该方法
    如果不存在旋转效果  ：增加该动画效果
    */
    func startAnimation()
    {
        //indicatorImg.layer.removeAllAnimations()
        
        if(indicatorImg.layer.animationForKey("rota") != nil)
        {
            return
        }
        indicatorImg.layer.addAnimation(ZXY_AnimationHelper.animationRotation(), forKey: "rota")
    }

}
