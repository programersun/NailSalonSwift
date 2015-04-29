//
//  ZXY_PickImgPictureVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/9.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

protocol ZXY_PickImgPictureVCDelegate : class
{
    func deletePhoto(img : UIImage , row : Int)
}

class ZXY_PickImgPictureVC: UIViewController {

    var isNaviInitHide : Bool = false
    @IBOutlet weak var currentImgV: UIImageView!
    var thisImage : UIImage!
    var thisRow   : Int!
    weak var delegate : ZXY_PickImgPictureVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentImgV.image = thisImage
        self.setNaviBarLeftImage("backArrow")
        self.setNaviBarRightImage("trashImg")
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        self.title = "1/1"
        
    }

    func setCurrentImage(currentImg : UIImage , andRow : Int)
    {
        thisImage = currentImg
        thisRow = andRow
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.barTintColor = ZXY_AllColor.SEARCH_RED_COLOR
    }
    
    override func rightNaviButtonAction() {
        if(self.delegate != nil)
        {
            self.delegate?.deletePhoto(thisImage , row: thisRow)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
