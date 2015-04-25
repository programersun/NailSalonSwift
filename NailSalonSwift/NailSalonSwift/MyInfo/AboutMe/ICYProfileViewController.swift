//
//  ICYProfileViewController.swift
//  KickYourAss
//
//  Created by sun on 15/4/17.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ICYProfileViewController: UITableViewController {
    
    typealias RequestBlock = () -> Void
    var requestBlock : RequestBlock!
    
    var userInfo: ZXY_UserDetailInfoData!
    private var dataForShow : ZXY_UserDetailInfoUserDetailBase?
    var zxyW : ZXY_WaitProgressVC = ZXY_WaitProgressVC()
    var userInfoValue : Dictionary<String , AnyObject?>! = Dictionary<String , AnyObject?>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("\(userInfo)")
        userInfoValue.extend(["userName" : userInfo.nickName , "userProfile" : userInfo.headImage , "userSex" : userInfo.sex , "userTel" : userInfo.tel , "userRealName" : userInfo.realName , "userAddr" : userInfo.address])
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell!

        // Configure the cell...
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileAvatarCell.identifier) as UITableViewCell
                let cell = cell as ICYProfileAvatarCell
                cell.icyMainLabel.text = "头像"
                cell.icyImageView.layer.cornerRadius = CGRectGetWidth(cell.icyImageView.bounds) / 2
                cell.icyImageView.layer.masksToBounds = true
                if let headImg = userInfoValue["userProfile"] as? String
                {
                    cell.imagePath = headImg.toAbsoluteImagePath()
                }
                else
                {
                    var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
                    if let user = userInfoDic
                    {
                        self.dataForShow = ZXY_UserDetailInfoUserDetailBase(dictionary: user)
                        var userData = self.dataForShow?.data
                        var headImg  = userData?.headImage?
                        if let hI = headImg
                        {
                            var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + hI
                            if hI.hasPrefix("http")
                            {
                                imgURL = hI
                            }
                            cell.imagePath = imgURL
                        }
                    }
                }
            case 1:
                cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileCell.identifier) as UITableViewCell
                let cell = cell as ICYProfileCell
                cell.icyMainLabel.text = "昵称"
                cell.icyDetailLabel.text = userInfoValue["userName"]? as? String
            case 2:
                cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileCell.identifier) as UITableViewCell
                let cell = cell as ICYProfileCell
                cell.icyMainLabel.text = "性别"
                var sexString : String?  = userInfoValue["userSex"]? as? String
                var sex: String = sexString ?? "3"
                cell.icyDetailLabel.text = sexString == "1" ? "男" : sexString == "2" ? "女" : "未知"
            default:
                break
            }
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier(ICYProfileCell.identifier) as UITableViewCell
            let cell = cell as ICYProfileCell
            switch indexPath.row {
            case 0:
                
                cell.icyMainLabel.text = "注册电话"
                if let telString = userInfoValue["userTel"] as? String
                {
                    cell.icyDetailLabel.text = telString.checkNull()
                }
                else
                {
                    cell.icyDetailLabel.text = ""
                }
            case 1:
                cell.icyMainLabel.text = "真实姓名"
                if let realNameString  = userInfoValue["userRealName"] as? String
                {
                    cell.icyDetailLabel.text = realNameString.checkNull()
                }
                else
                {
                    cell.icyDetailLabel.text = ""
                }
            case 2:
                cell.icyMainLabel.text = "常用地址"
                if let address = userInfoValue["userAddr"] as? String
                {
                    cell.icyDetailLabel.text = address.checkNull()
                }
                else
                {
                    cell.icyDetailLabel.text = ""
                }
            default:
                break
            }
        default:
            break
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 60.0
        } else {
            return 44.0
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var section = indexPath.section
        var row     = indexPath.row
        var story   = UIStoryboard(name: "MyInfoStory", bundle: nil)
        var vc      = story.instantiateViewControllerWithIdentifier("changeInfoID") as ZXY_DateChangeInfoVC
        vc.delegate = self
        if(section == 0)
        {
            switch row
            {
            case 0:
//                self.selectProfileFunction()
                return
            case 1 :
                vc.setInitValueAndTitle("userName", initValue: userInfoValue["userName"]?)
                self.navigationController?.pushViewController(vc, animated: true)
            case 2 :
                var changeSexAler = UIAlertView()
                changeSexAler.title = "提示"
                changeSexAler.addButtonWithTitle("男")
                changeSexAler.addButtonWithTitle("女")
                changeSexAler.delegate = self
                changeSexAler.show()
                
//                vc.setInitValueAndTitle("userSex", initValue: userInfoValue["userSex"]?)
//                vc.setIsInput(false)

            default:
                return
            }
        }
        else
        {
            switch row
            {
            case 0:
                vc.setInitValueAndTitle("userTel", initValue: userInfoValue["userTel"]?)
            case 1 :
                vc.setInitValueAndTitle("userRealName", initValue: userInfoValue["userRealName"]?)
            case 2 :
                vc.setInitValueAndTitle("userAddr", initValue: userInfoValue["userAddr"]?)
            default :
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func selectProfileFunction()
    {
//        var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
//        var vc    = story.instantiateInitialViewController() as ZXY_PictureTakeVC
//        vc.delegate = self
//        vc.presentView()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

extension ICYProfileViewController :  UINavigationControllerDelegate , UIImagePickerControllerDelegate, ZXY_DateChangeInfoVCDelegate
//    , ZXY_ImagePickerDelegate , ZXY_PictureTakeDelegate
{
    func afterChange(sendKey: String, andValue sendValue: String) {
        userInfoValue.extend([sendKey : sendValue])
        self.startLoadInfoData()
    }
    
//    func clickChoosePictureBtn() {
////        var zxy_imgPick = ZXY_ImagePickerTableVC()
////        zxy_imgPick.setMaxNumOfSelect(1)
////        zxy_imgPick.delegate = self
////        zxy_imgPick.presentZXYImagePicker(self)
//    }
//    
//    func clickTakePhotoBtn() {
//        
////        var photoPicker = UIImagePickerController()
////        photoPicker.sourceType = UIImagePickerControllerSourceType.Camera
////        photoPicker.delegate = self
////        self.presentViewController(photoPicker, animated: true) { () -> Void in
////            
////        }
//    }
//    
//    func ZXY_ImagePicker(imagePicker: ZXY_ImagePickerTableVC, didFinishPicker assetArr: [ALAsset]) {
//        if(assetArr.count > 0)
//        {
////            var myUserID = LCYCommon.sharedInstance.userInfo?.userID
//            var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
//            if(myUserID == nil)
//            {
//                return
//            }
//            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            var firstProfile : UIImage = self.AlssetToUIImage(assetArr[0])
//            firstProfile     = UIImage(image: firstProfile, scaledToFillToSize: CGSize(width: 400  ,height: 400))
//            self.startLoadImgData(firstProfile)
//        }
//    }
//    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
//        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//        picker.dismissViewControllerAnimated(true, completion: { [weak self]() -> Void in
////            var myUserID = LCYCommon.sharedInstance.userInfo?.userID
//            var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
//            if(myUserID == nil)
//            {
//                return
//            }
//            
//            var firstProfile     = UIImage(image: image, scaledToFillToSize: CGSize(width: 400  ,height: 400))
//            self?.startLoadImgData(firstProfile)
//        })
//        
//    }
//    
//    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
//            
//        })
//    }
//    
//    func startLoadImgData(img : UIImage)
//    {
//        var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
//        if(myUserID == nil)
//        {
//            return
//        }
//        zxyW.startProgress(self.view)
//        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_ChangeProfileAPI
//        ZXY_NetHelperOperate.sharedInstance.startPostImg(urlString, parameter: ["user_id" : myUserID!], imgData: [UIImageJPEGRepresentation(img, 0.8)], fileKey: "Filedata", success: { [weak self](returnDic) -> Void in
//            var status = returnDic["result"] as Int
//            if(status == 1000)
//            {
//                self?.userInfo.headImage = returnDic["data"] as String
//                self?.userInfoValue.extend(["userProfile" : returnDic["data"] as String])
//                self?.startDownLoadUserDetailInfo()
//                self?.tableView.reloadData()
//            }
//            if let s = self
//            {
//                s.zxyW.hideProgress(s.view)
//            }
//            }, failure: { [weak self](failError) -> Void in
//                if let s = self
//                {
//                    s.zxyW.hideProgress(s.view)
//                }
//                return
//        })
//
//    }
//    
    func startLoadInfoData()
    {
        var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(myUserID == nil)
        {
            return
        }
        zxyW.startProgress(self.view)
        var urlString           = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_ChangeInfoAPI
        var nick_Name : String? = userInfoValue["userName"] as? String
        var real_name : String? = userInfoValue["userRealName"] as? String
        var sex       : String? = userInfoValue["userSex"]? as? String
        var address   : String? = userInfoValue["userAddr"]? as? String
        var tel       : String? = userInfoValue["userTel"]? as? String
        var parameter : Dictionary<String , AnyObject> = ["nick_name" : nick_Name == nil ? "" : nick_Name! , "real_name" : real_name == nil ? "" : real_name!, "sex" : sex == nil ? "3" : sex! , "address" : address == nil ? "" : address! , "tel" : tel == nil ? "" : tel!,"user_id" : myUserID!]

        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
            }
            var result = returnDic["result"] as Double
            if(result == 1000)
            {
                self?.userInfo.nickName = nick_Name
                self?.userInfo.realName = real_name
                self?.userInfo.sex      = sex
                self?.userInfo.address  = address
                self?.userInfo.tel      = tel
                self?.startDownLoadUserDetailInfo()
                self?.tableView.reloadData()
                if self?.requestBlock != nil {
                    self?.requestBlock()
                }
            }
            else
            {
                self?.showAlertEasy("提示", messageContent: "修改个人信息失败，请稍后尝试")
            }
            }) {[weak self] (error) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
            }
            self?.showAlertEasy("提示", messageContent: "网络状况不佳，请稍后尝试")
            return
        }
    }
    
    private func startDownLoadUserDetailInfo()
    {
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            return
        }
//        zxyW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.ZXY_MyInfoAPI(ZXY_MyInfoAPIType.MI_MyInfo)
        var parameter = ["user_id" : userID!]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
            }
            var result = returnDic["result"] as Double
            if(result == 1000)
            {
                ZXY_UserInfoDetail.sharedInstance.saveUserDetailInfo(returnDic)
                println("\(self?.userInfo!.nickName)")
            }
            else
            {
                var messageError = ZXY_ErrorMessageHandle.messageForErrorCode(result ?? 0)
                self?.showAlertEasy("提示", messageContent: messageError)
            }
            }) {[weak self] (error) -> Void in
                if let s = self
                {
                    s.zxyW.hideProgress(s.view)
                }
        }
        
    }
    
    @IBAction func backAction(sender: AnyObject)
    {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

//修改性别
extension ICYProfileViewController: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        var sex : String?
        switch buttonIndex
        {
        case 0:
            sex = "1"
        case 1:
            sex = "2"
        default:
            return
            
        }
        let sexString = userInfoValue["userSex"] as? String
        if  sexString != sex
        {
            userInfoValue.extend(["userSex": sex])
            println("\(sex)")
            println("\(userInfoValue)")
            startLoadInfoData()
        }
    }
}