//
//  SR_checkIdVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/13.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_checkIdVC: UIViewController {
    
    @IBOutlet weak var checkTableView: UITableView!
    
    @IBOutlet weak var cameraBackgroundView: UIControl!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var registPhotoBtn: UIButton!
    
    var screenSize  = UIScreen.mainScreen().bounds
    var idImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTableView.backgroundColor = UIColor.NailBackGrayColor()
        cameraBackgroundView.hidden = true
        cameraBackgroundView.layer.opacity = 0
        cameraBtn.hidden = true
        registPhotoBtn.hidden = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoardShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoradFrameChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoardHide:"), name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //键盘弹出
    func keyBoardShow(noty : NSNotification)
    {
        var keyBoardInfo = noty.userInfo
        if let key = keyBoardInfo
        {
            var keyBoardValue : NSValue = key[UIKeyboardFrameEndUserInfoKey] as NSValue
            var keyBoardHeight          = keyBoardValue.CGRectValue().origin.y
            var keyBoardShowDuration    = key[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
            UIView.animateWithDuration(keyBoardShowDuration.doubleValue, animations: { [weak self]() -> Void in
                if let s = self
                {
                    if ( keyBoardHeight + 280 > s.screenSize.height)
                    {
                        self?.checkTableView.frame = CGRectMake(0, -112, s.screenSize.width, s.screenSize.height)
                    }
                }
                
            })
        }
    }
    //键盘改变
    func keyBoradFrameChange(noty: NSNotification)
    {
        var keyBoardInfo = noty.userInfo
        if let key = keyBoardInfo
        {
            var keyBoardValue : NSValue = key[UIKeyboardFrameEndUserInfoKey] as NSValue
            var keyBoardHeight          = keyBoardValue.CGRectValue().origin.y
            var keyBoardShowDuration    = key[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
            UIView.animateWithDuration(keyBoardShowDuration.doubleValue, animations: { [weak self]() -> Void in
                if let s = self
                {
                    if ( keyBoardHeight + 280 > s.screenSize.height)
                    {
                        self?.checkTableView.frame = CGRectMake(0, 64 - keyBoardHeight, s.screenSize.width, s.screenSize.height)
                    }
                }
            })
        }
        
    }
    //键盘推出
    func keyBoardHide(noty : NSNotification)
    {
        UIView.animateWithDuration(0.5, animations: { [weak self]() -> Void in
            if let s = self
            {
                self?.checkTableView.frame = CGRectMake(0, 64, s.screenSize.width, s.screenSize.height)
            }
        })
        
    }

}
extension SR_checkIdVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 160
        }
        else
        {
            return 61
        }
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row
        {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("check_0") as? UITableViewCell
            var idImgView = cell?.viewWithTag(1) as UIImageView
            idImgView.image = UIImage(named: "idCheck")
            idImageView = idImgView
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("check_1") as? UITableViewCell
            var trueNameText = cell?.viewWithTag(1) as UITextField
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("check_2") as? UITableViewCell
            var idText = cell?.viewWithTag(1) as UITextField
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("check_3") as? UITableViewCell
            var button =  cell?.viewWithTag(1) as UIButton
            button.layer.cornerRadius = 4
            button.backgroundColor = UIColor.NailRedColor()
            button.addTarget(self, action: Selector("registBtnClick"), forControlEvents: UIControlEvents.TouchUpInside)
        default:
            break
        }
        cell?.backgroundColor = UIColor.NailBackGrayColor()
        return cell!
    }
    
    //注册按钮
    func registBtnClick()
    {
        println("hello")
    }
    
    //弹出加入照片选项
    @IBAction func idImgViewTouch(sender: AnyObject) {
        cameraBtn.hidden = false
        registPhotoBtn.hidden = false
        cameraBackgroundView.hidden = false
        cameraBackgroundView.layer.opacity = 0.95
        cameraBackgroundView.layer.addAnimation(SR_Animation.animationForAlpha(0, to: 0.95), forKey: "opacity")
        cameraBtn.layer.addAnimation(SR_Animation.animationDown(), forKey: "scale")
        cameraBtn.layer.anchorPoint = CGPointMake(0.5, 0.5)
        registPhotoBtn.layer.addAnimation(SR_Animation.animationDown(), forKey: "scale")
        registPhotoBtn.layer.anchorPoint = CGPointMake(0.5, 0.5)
    }
    
    @IBAction func cameraBackgroundTouch(sender: AnyObject) {
        cameraBackgroundOut()
    }
    
    //推出加入照片选项
    func cameraBackgroundOut()
    {
        self.cameraBackgroundView.layer.opacity = 0
        cameraBtn.layer.addAnimation(SR_Animation().animationUp({ (isFinish) -> Void in
            self.cameraBtn.hidden = true
            ""
        }), forKey: "scale")
        cameraBtn.layer.anchorPoint = CGPointMake(0.5, 0.5)
        registPhotoBtn.layer.addAnimation(SR_Animation().animationUp({ (isFinish) -> Void in
            self.registPhotoBtn.hidden = true
            ""
        }), forKey: "scale")
        registPhotoBtn.layer.anchorPoint = CGPointMake(0.5, 0.5)
        cameraBackgroundView.layer.addAnimation(SR_Animation().animationForAlpha(0.95, to: 0, finishBlock: { (isFinish) -> Void in
            self.cameraBackgroundView.hidden = true
            ""
        }), forKey: "opacity")

    }
    
    @IBAction func cameraBtnClick(sender: AnyObject) {
        var sourceType: UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.Camera
        var picker: UIImagePickerController               = UIImagePickerController()
        picker.delegate                                   = self
        picker.allowsEditing                              = true
        picker.sourceType                                 = sourceType
        self.presentViewController(picker, animated: true) { () -> Void in
        }
    }
    
    @IBAction func registPhotoBtnClick(sender: AnyObject) {
        var sourceType: UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.PhotoLibrary
        var picker: UIImagePickerController               = UIImagePickerController()
        picker.delegate                                   = self
        picker.allowsEditing                              = true
        picker.sourceType                                 = sourceType
        self.presentViewController(picker, animated: true) { () -> Void in
            
        }
    }
}

extension SR_checkIdVC: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var resizeImg =  UIImage(image: image, scaledToFillToSize: CGSize(width: 200, height: 120))
        idImageView.image = resizeImg
        println("success")
        cameraBackgroundOut()
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        cameraBackgroundOut()
        println("cancel")
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
}