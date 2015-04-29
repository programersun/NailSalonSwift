//
//  ZXY_PictureTakeVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/3.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_PictureTakeDelegate : class
{
    func clickChoosePictureBtn()
    func clickTakePhotoBtn()
}

class ZXY_PictureTakeVC: UIViewController {

    weak var delegate : ZXY_PictureTakeDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentView()
    {
        var wind = UIApplication.sharedApplication().keyWindow
        wind?.rootViewController?.addChildViewController(self)
        self.view.alpha = 0
        wind?.addSubview(self.view)
        UIView.animateWithDuration(0.3, animations: {[weak self] () -> Void in
            self?.view.alpha = 1
            print("")
        })
    }
    
    func hideView()
    {
        UIView.animateWithDuration(0.3, animations: {[weak self] () -> Void in
            self?.view.alpha = 0
            print("")
        }) { [weak self] (com) -> Void in
            self?.removeFromParentViewController()
            self?.view.removeFromSuperview()
        }
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.hideView()
    }
    
    @IBAction func takePhotoAction(sender: AnyObject) {
        delegate.clickTakePhotoBtn()
        self.hideView()
    }
    
    @IBAction func choosePictureAction(sender: AnyObject) {
        delegate.clickChoosePictureBtn()
        self.hideView()
    }
    
    
    
}
