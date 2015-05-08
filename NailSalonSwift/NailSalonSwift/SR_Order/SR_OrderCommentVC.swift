//
//  SR_OrderCommentVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderCommentVC: UIViewController {
    
    @IBOutlet weak var commentTableView: UITableView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var cameraBackgroundView: UIControl!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var registPhotoBtn: UIButton!
    
    var commentString : String = ""
    var orderID : String?
    var score : CGFloat = 5
    var commentImg : UIImage?
    
    //当前用户信息
    var userId : String?
    var userInfo : ZXY_UserDetailInfoData!
    private var userData : ZXY_UserDetailInfoUserDetailBase?
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentBtn.layer.borderColor = UIColor.NailGrayColor().CGColor
        commentBtn.layer.borderWidth = 0.5
        commentBtn.layer.masksToBounds = true
        self.getUserInfo()
        cameraBackgroundView.hidden = true
        cameraBackgroundView.layer.opacity = 0
        cameraBtn.hidden = true
        registPhotoBtn.hidden = true
        commentImg = UIImage(named: "commentImg")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //获取当前用户的信息
    func getUserInfo() {
        self.userId = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
        if let user = userInfoDic {
            self.userData = ZXY_UserDetailInfoUserDetailBase(dictionary: user)
            self.userInfo = self.userData?.data
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //发送评论
    func loadComment() {
        srW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_CommentAdd)
        var parameter : Dictionary<String ,  AnyObject> = ["order_id": self.orderID! ,"role": self.userInfo.role! ,"comment" : self.commentString, "score": self.score]
        println("\(parameter)")
        var imgData = NSData()
        imgData = UIImageJPEGRepresentation(commentImg, 1)
        ZXY_NetHelperOperate.sharedInstance.startPostImg(urlString, parameter: parameter, imgData: [imgData], fileKey: "Filedata", success: { [weak self](returnDic) -> Void in
            var result: Double = returnDic["result"] as! Double
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            if result == 1000 {
                self?.navigationController?.popViewControllerAnimated(true)
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: errorString)
            }
            
        }) { [weak self](failError) -> Void in
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            ""
        }
    }
    
    //上传图片背景点击
    @IBAction func camerBackgroundTouch(sender: AnyObject) {
        self.cameraBackgroundOut()
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
    
    //发送评论按钮
    @IBAction func commentBtnClick(sender: AnyObject) {
        if self.commentString == "" {
            self.showAlertEasy("提示", messageContent: "评论不能为空")
        }
        else {
            self.loadComment()
        }
    }
}

extension SR_OrderCommentVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userInfo.role == "1" {
            return 3
        }
        else
        {
            return 2
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            if self.userInfo.role == "1" {
                return 160
            }
            else {
                return 50
            }
        case 2:
            return 50
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var firstCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderCommentFirstCell.cellID()) as! SR_OrderCommentFirstCell
        var secondCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderCommentSecondCell.cellID()) as! SR_OrderCommentSecondCell
        var thirdCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderCommentThirdCell.cellID()) as! SR_OrderCommentThirdCell
        switch indexPath.row {
        case 0:
            firstCell.delegate = self
            return firstCell
        case 1:
            var cell : UITableViewCell!
            if self.userInfo.role == "1" {
                secondCell.showImgView.image = commentImg
                secondCell.delegate = self
                cell = secondCell
            }
            else {
                thirdCell.delegate = self
                cell = thirdCell
            }
            return cell
        case 2:
            thirdCell.delegate = self
            return thirdCell
        default:
            return firstCell
        }
    }
}
extension SR_OrderCommentVC : SR_OrderCommentThirdCellProtocol,SR_OrderCommentSecondCellProtocol ,SR_OrderCommentFirstCellProtocol,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func clickImg() {
        println("hello")
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
    
    func commentTextChange(commentString: String) {
        self.commentString = commentString
        println(self.commentString)
    }
    
    func cameraBackgroundTouch() {
        self.cameraBackgroundOut()
    }
    
    func scoreChange(score: CGFloat) {
        self.score = score
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        var resizeImg =  UIImage(image: image, scaledToFillToSize: CGSize(width: 200, height: 200))
        self.commentImg = resizeImg
        var index = NSIndexPath(forRow: 1, inSection: 0)
        self.commentTableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.None)
        self.cameraBackgroundOut()
        println("success")
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.cameraBackgroundOut()
        println("cancel")
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

}
