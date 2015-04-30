//
//  ZXY_ImageItemView.swift
//  ZXYImageBrowser
//
//  Created by ZXYStart on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_ImageItemViewDelegate : class
{
    func clickItemAtIndexPath(indexPath : Int)
    func longPressItemAtIndexPath(indexPath : Int , giveYouImage : UIImage)
}

class ZXY_ImageItemView: UIScrollView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegateOfItem : ZXY_ImageItemViewDelegate?
    
    private var activity    : UIActivityIndicatorView!
    
    private var currentImage : UIImageView!
    
    private var currentItem : ZXY_ImageItem!
    
    private var _isDoubleTap : Bool = false
    
    func setCurrentItem(currentItem : ZXY_ImageItem!)
    {
        self.currentItem = currentItem
        self.showImage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.startInitZXYIV()
        self.startInitActivity()
    }
    
    convenience  init() {
        self.init()
        self.startInitZXYIV()
        self.startInitActivity()
    }
    
    private func startInitZXYIV()
    {
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator   = false
        self.backgroundColor                = UIColor.clearColor()
        self.delegate = self
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        var doubleTap = UITapGestureRecognizer(target: self, action: Selector("handleDoubleTap:"))
        doubleTap.numberOfTapsRequired = 2
        
        var singleTap = UITapGestureRecognizer(target: self, action: Selector("handleSingleTap:"))
        singleTap.numberOfTapsRequired = 1
        //singleTap.delaysTouchesBegan = true
        
        var pressGes = UILongPressGestureRecognizer(target: self, action: Selector("handlePressGes:"))
        pressGes.minimumPressDuration = 1
        self.addGestureRecognizer(pressGes)
        
        self.addGestureRecognizer(singleTap)
        
        self.addGestureRecognizer(doubleTap)
        currentImage = UIImageView()
        currentImage.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(currentImage)
    }
    
    
    private func startInitActivity()
    {
        var boundsI   = self.bounds
        self.activity = UIActivityIndicatorView(frame: CGRectMake(boundsI.width / 2 - 20, boundsI.height / 2 - 20, 40, 40))
        self.activity.hidesWhenStopped = true
        self.addSubview(activity)
        self.activity.startAnimating()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showImage() -> Void
    {
        if(currentItem.itemName != nil)
        {
            var image = UIImage(named: currentItem.itemName!)
            currentItem.itemImage = image
            self.activity.stopAnimating()
            self.ajustImageFrame()
        }
        
        
        else
        {
            currentImage.setImageWithURLRequest(NSURLRequest(URL: currentItem.itemURL!), placeholderImage: UIImage(), success: {[weak self] (request, response, image) -> Void in
                self?.currentItem.itemImage = image
                self?.activity.stopAnimating()
                self?.ajustImageFrame()
                
                }, failure: { (request, response, error) -> Void in
                    ""
                    ""
                    println("下载图片失败")
            })

//            currentImage.sd_setImageWithURL(currentItem.itemURL, completed: { [weak self] (image, error, SDImageCacheTypeDisk, url) -> Void in
//                self?.currentItem.itemImage = image
//                self?.activity.stopAnimating()
//                self?.ajustImageFrame()
//            })
        }
    }
    
    func ajustImageFrame()
    {
        var image = currentItem.itemImage
        var imageSize = image?.size
        var imageHeight = imageSize?.height
        var imageWidth  = imageSize?.width
        
        var viewSize    = self.bounds.size
        var viewHeight  = viewSize.height
        var viewWidth   = viewSize.width
        var radio: CGFloat   = 0.0
        
        var minScale = 1.0
        
        var maxScale : CGFloat = 2.0
        
        if(UIScreen.instancesRespondToSelector(Selector("scale")))
        {
            maxScale = UIScreen.mainScreen().scale
        }
        
        self.minimumZoomScale = CGFloat(minScale)
        self.maximumZoomScale = maxScale
        self.zoomScale        = 1
        
        if(imageWidth != 0)
        {
             radio   = imageSize!.height / imageSize!.width
        }
        
        if(imageHeight < viewHeight && imageWidth < viewWidth)
        {
            currentImage.contentMode = UIViewContentMode.ScaleAspectFit
            currentImage.frame       = CGRectMake(0, 0, viewWidth, viewHeight)
        }
        
        else if(imageWidth <= imageHeight)
        {
            currentImage.contentMode = UIViewContentMode.ScaleAspectFit
            currentImage.frame       = CGRectMake(0, 0, viewWidth, viewHeight)
        }
        else if(imageWidth > imageHeight)
        {
            currentImage.contentMode = UIViewContentMode.ScaleAspectFit
            currentImage.frame       = CGRectMake(0, 0, viewWidth,viewHeight)
        }
        
        currentImage.center          = CGPointMake(viewWidth/2, viewHeight/2)
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentImage, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentImage, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentImage, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentImage, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        currentImage.image = image
    }
    
    func handleDoubleTap(tap : UITapGestureRecognizer)
    {
        _isDoubleTap = true
        var tapPoint = tap.locationInView(self)
        if (self.zoomScale == self.maximumZoomScale) {
            self.setZoomScale(self.minimumZoomScale, animated: true)
            
        } else {
            self.zoomToRect(CGRectMake(tapPoint.x, tapPoint.y, 1, 1), animated: true)
        }

    }
    
    func handleSingleTap(tap : UITapGestureRecognizer)
    {
        _isDoubleTap = false
        var timer = NSTimer(timeInterval: 0.3, target: self, selector: Selector("singleAction"), userInfo: nil, repeats: false)
        var loop : NSRunLoop = NSRunLoop.mainRunLoop()
        loop.addTimer(timer, forMode: NSDefaultRunLoopMode)
    }
    
    func singleAction()
    {
        if(_isDoubleTap)
        {
            return
        }
        
        if(self.delegateOfItem != nil)
        {
            self.delegateOfItem?.clickItemAtIndexPath(currentItem.itemIndex!)
        }
    }
    
    func handlePressGes(press : UILongPressGestureRecognizer)
    {
        if(press.state == UIGestureRecognizerState.Began)
        {
            if(currentItem.itemImage == nil)
            {
                return
            }
            if(self.delegateOfItem != nil)
            {
                self.delegateOfItem!.longPressItemAtIndexPath(currentItem.itemIndex!, giveYouImage: currentItem.itemImage!)
            }
        }
        
    }
    
}

extension ZXY_ImageItemView : UIScrollViewDelegate
{
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return currentImage
    }
}
