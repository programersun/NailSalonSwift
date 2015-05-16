//
//  CustomImageView.swift
//  ImageLoaderIndicator
//
//  Created by Rounak Jain on 24/01/15.
//  Copyright (c) 2015 Rounak Jain. All rights reserved.
//

import UIKit


class CustomImageView: UIImageView {
//  let progressIndecatorView = CircularLoaderView(frame: CGRectZero)
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
//    addSubview(self.progressIndecatorView)
//    progressIndecatorView.frame = bounds
//    progressIndecatorView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
    let url = NSURL(string: "http://www.raywenderlich.com/wp-content/uploads/2015/02/mac-glasses.jpeg")
//    sd_setImageWithURL(url, placeholderImage: nil, options: .CacheMemoryOnly, progress: {
//      [weak self]
//      (receivedSize, expectedSize) -> Void in
//      self!.progressIndecatorView.progress = CGFloat(receivedSize) / CGFloat(expectedSize)
//      ""
//      // Update progress here
//      }) {
//        [weak self]
//        (image, error, _, _) -> Void in
//        self!.progressIndecatorView.reveal()
//        // Reveal image here
//    }
    
  }
    
  
  
}

extension UIImageView
{
    func imgURL(sd_url : String)
    {
        

        var urlSession = NSURLSession()
        setImageWithURLRequest(NSURLRequest(URL: NSURL(string : sd_url)!), placeholderImage: nil, success: { [weak self](request, respose, img) -> Void in
            self?.image = img
            self?.animatableForImg()
                    }) { (request, response, error) -> Void in
            
        }
        
    
    }
    
    private func animatableForImg()
    {
        let progressIndecatorView = CircularLoaderView(frame: CGRectZero)
        self.addSubview(progressIndecatorView)
        progressIndecatorView.frame = self.bounds
        progressIndecatorView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        progressIndecatorView.reveal()

    }
}
