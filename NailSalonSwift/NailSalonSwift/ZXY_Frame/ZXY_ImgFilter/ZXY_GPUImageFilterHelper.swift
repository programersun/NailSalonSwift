//
//  ZXY_GPUImageFilterHelper.swift
//  GPUImageDemo
//
//  Created by 宇周 on 15/2/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_GPUImageFilterHelper: NSObject {
    override init() {
        
    }
    
    class var sharedInstance: ZXY_GPUImageFilterHelper {
        struct Singleton {
            static let instance = ZXY_GPUImageFilterHelper()
        }
        return Singleton.instance
    }
    
    func filterImageWithFilterType(type : ZXY_FilterImgType , originImage : UIImage , valueO : CGFloat?) -> UIImage
    {
        switch type
        {
        case ZXY_FilterImgType.FilterImgOrigin:
            return originImage.copy() as UIImage
        case ZXY_FilterImgType.FilterImgContrast:
            return self.filterImageFilterImgContrast(originImage, contrast: valueO).copy() as UIImage
        case ZXY_FilterImgType.FilterImgBrightness:
            return self.filterImageFilterImgBrightness(originImage, brightness: valueO).copy() as UIImage
        case ZXY_FilterImgType.FilterImgSaturation:
            return self.filterImageFilterImgSaturation(originImage, saturation: valueO).copy() as UIImage
        case ZXY_FilterImgType.FilterImggrayscale:
            return self.filterImageFilterImgGray(originImage).copy() as UIImage
        case ZXY_FilterImgType.FilterImgMonochrome:
            return self.filterImageFilterImgMonochrome(originImage, intensity: valueO).copy() as UIImage
        case ZXY_FilterImgType.FilterImgVignette:
            return self.filterImageFilterImgVignette(originImage).copy() as UIImage
        default:
            return originImage
            
        }
    }
    
    /**
    对比度
    
    :param: originImage 原始图片
    :param: contrast    强度
    
    :returns: 处理后的图片
    */
    private func filterImageFilterImgContrast(originImage : UIImage , contrast: CGFloat?) -> UIImage
    {
        var GPUIMG : GPUImagePicture = GPUImagePicture(image: originImage)
        var contrastFilter : GPUImageContrastFilter = GPUImageContrastFilter()
        if let contrasts = contrast
        {
            contrastFilter.contrast = contrasts
        }
        else
        {
            contrastFilter.contrast = 0.5
        }
        GPUIMG.addTarget(contrastFilter)
        contrastFilter.useNextFrameForImageCapture()
        GPUIMG.processImage()
        var filterImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return filterImage
    }
    
    /**
    亮度
    
    :param: originImage 原始图片
    :param: brightness  亮度
    
    :returns: 处理后的图片
    */
    private func filterImageFilterImgBrightness(originImage : UIImage , brightness: CGFloat?) -> UIImage
    {
        var GPUIMG : GPUImagePicture = GPUImagePicture(image: originImage)
        var contrastFilter : GPUImageBrightnessFilter = GPUImageBrightnessFilter()
        if let contrasts = brightness
        {
            contrastFilter.brightness = contrasts
        }
        else
        {
            contrastFilter.brightness = 0.5
        }

        GPUIMG.addTarget(contrastFilter)
        contrastFilter.useNextFrameForImageCapture()
        GPUIMG.processImage()
        var filterImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return filterImage
    }
    
    /**
    饱和度
    
    :param: originImage 原始图片
    :param: saturation  饱和度
    
    :returns: 处理后的图片
    */
    private func filterImageFilterImgSaturation(originImage : UIImage , saturation: CGFloat?) -> UIImage
    {
        var GPUIMG : GPUImagePicture = GPUImagePicture(image: originImage)
        var contrastFilter : GPUImageSaturationFilter = GPUImageSaturationFilter()
        if let saturations = saturation
        {
            contrastFilter.saturation = saturations
        }
        else
        {
            contrastFilter.saturation = 0.5
        }
        
        GPUIMG.addTarget(contrastFilter)
        contrastFilter.useNextFrameForImageCapture()
        GPUIMG.processImage()
        var filterImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return filterImage

    }
    
    /**
    光晕
    
    :param: originImage 原始图片
    
    :returns: 处理后的图片
    */
    private func filterImageFilterImgVignette(originImage : UIImage ) -> UIImage
    {
        var GPUIMG : GPUImagePicture = GPUImagePicture(image: originImage)
        var contrastFilter : GPUImageVignetteFilter = GPUImageVignetteFilter()
        GPUIMG.addTarget(contrastFilter)
        contrastFilter.useNextFrameForImageCapture()
        GPUIMG.processImage()
        var filterImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return filterImage

    }
    
    /**
    复古
    
    :param: originImage 原始图片
    :param: intensity   强度
    
    :returns: 处理后的图片
    */
    private func filterImageFilterImgMonochrome(originImage : UIImage , intensity: CGFloat?) -> UIImage
    {
        var GPUIMG : GPUImagePicture = GPUImagePicture(image: originImage)
        var contrastFilter : GPUImageMonochromeFilter = GPUImageMonochromeFilter()
        if let inten = intensity
        {
            contrastFilter.intensity = inten
        }
        GPUIMG.addTarget(contrastFilter)
        contrastFilter.useNextFrameForImageCapture()
        GPUIMG.processImage()
        var filterImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return filterImage

    }
    
    /**
    灰度
    
    :param: originImage 原始图片
    
    :returns: 处理后的图片
    */
    private func filterImageFilterImgGray(originImage : UIImage ) -> UIImage
    {
        var GPUIMG : GPUImagePicture = GPUImagePicture(image: originImage)
        var contrastFilter : GPUImageGrayscaleFilter = GPUImageGrayscaleFilter()
        GPUIMG.addTarget(contrastFilter)
        contrastFilter.useNextFrameForImageCapture()
        GPUIMG.processImage()
        var filterImage = contrastFilter.imageFromCurrentFramebuffer()
        
        return filterImage
    }
}
