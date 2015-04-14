//
//  ZXY_FilterImgType.swift
//  GPUImageDemo
//
//  Created by 宇周 on 15/2/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import Foundation
enum ZXY_FilterImgType : Int
{
    /**
    *  原始图片
    */
    case FilterImgOrigin = 1
    
    /**
    *  对比
    */
    case FilterImgContrast = 2
    
    /**
    *  亮度
    */
    case FilterImgBrightness = 3
    
    /**
    *  饱和度
    */
    case FilterImgSaturation
    
    /**
    *  光晕
    */
    case FilterImgVignette
    
    /**
    *  复古
    */
    case FilterImgMonochrome
    
    /**
    *  灰色
    */
    case FilterImggrayscale
    
    func typeWithInt(typeInt : Int) -> ZXY_FilterImgType
    {
        var currentFilterType = ZXY_FilterImgType.FilterImgOrigin
        switch typeInt
        {
        case 0 :
            currentFilterType = ZXY_FilterImgType.FilterImgOrigin
        case 1 :
            currentFilterType = ZXY_FilterImgType.FilterImgContrast
        case 2 :
            currentFilterType = ZXY_FilterImgType.FilterImgBrightness
        case 3 :
            currentFilterType = ZXY_FilterImgType.FilterImgSaturation
        case 4 :
            currentFilterType = ZXY_FilterImgType.FilterImgVignette
        case 5 :
            currentFilterType = ZXY_FilterImgType.FilterImgMonochrome
        case 6 :
            currentFilterType = ZXY_FilterImgType.FilterImggrayscale
        default:
            currentFilterType = ZXY_FilterImgType.FilterImgOrigin
        }
        return currentFilterType
    }
}