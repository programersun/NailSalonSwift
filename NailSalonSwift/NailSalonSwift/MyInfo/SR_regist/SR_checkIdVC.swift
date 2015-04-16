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
    
    var userInfo : ZXY_UserDetailInfoData?
    
    //身份证照片
    var idImageView = UIImageView()
    //是否上传照片
    var postIdImage : Bool = false
    //美甲师用户名和密码
    var userName : String?
    var userPassword : String?
    
    var realName : String?
    var identCode : String?

    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var segueID = segue.identifier
        if( segueID == "toUserInfo")
        {
            var propertyVC = segue.destinationViewController as ICYProfileViewController
            propertyVC.userInfo = userInfo
            println("\(ZXY_UserInfoDetail.sharedInstance.getUserID())")
            println("\(ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo())")
        }
    }

    
    func  artistRegist()
    {
        var urlString = ZXY_NailNetAPI.ZXY_MainAPI + ZXY_MyInfoAPIType.MI_Regist.rawValue
        var parameter : Dictionary<String , AnyObject> = ["user_name": userName!  , "password": userPassword! , "role": 2 , "real_name": realName! , "ident_code": identCode!]
        var imgData = NSData()
        if postIdImage
        {
            imgData = UIImageJPEGRepresentation(idImageView.image, 1)
        }
        ZXY_NetHelperOperate().startPostImg(urlString, parameter: parameter, imgData:[imgData], fileKey: "Filedata", success: { [weak self](returnDic) -> Void in
            
            var result: Double = returnDic["result"] as Double
            if(result == Double(1000))
            {
                var userid : Double = returnDic["data"] as Double
                ZXY_UserInfoDetail.sharedInstance.saveUserID("\(userid)")
                ZXY_UserInfoDetail.sharedInstance.saveUserDetailInfo(returnDic)
                self?.userInfo = ZXY_UserDetailInfoData(dictionary: returnDic)
                self?.performSegueWithIdentifier("toArtistInfo", sender: nil)
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: errorString)
            }
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            }) { [weak self](error) -> Void in
                println(error)
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
                self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
                
        }
    }
    
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
extension SR_checkIdVC: UITableViewDelegate,UITableViewDataSource {
    
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
            var realNameText = cell?.viewWithTag(1) as UITextField
            realName = realNameText.text
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("check_2") as? UITableViewCell
            var idText = cell?.viewWithTag(1) as UITextField
            identCode = idText.text
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
        var realNameCell : UITableViewCell? = checkTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        var realNameText = realNameCell?.viewWithTag(1) as UITextField
        realName! = realNameText.text
        println("\(realName)")
        var identCodeCell : UITableViewCell? = checkTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0))
        var idText = identCodeCell?.viewWithTag(1) as UITextField
        identCode! = idText.text
        println("\(identCode)")
        println("\(userName)")
        println("\(userPassword)")
        if(realName == "")
        {
            self.showAlertEasy("提示", messageContent: "请输入正确的手机号码")
            return
        }
        if(identCode == "")
        {
            self.showAlertEasy("提示", messageContent: "请输入密码")
            return
        }
        self.srW.startProgress(self.view)
        artistRegist()
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
        postIdImage = true
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