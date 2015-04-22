//
//  ZXY_MIMainVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MIMainVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    private var dataForShow : ZXY_UserDetailInfoUserDetailBase?
    var zxyW : ZXY_WaitProgressVC = ZXY_WaitProgressVC()

    var userInfo: ZXY_UserDetailInfoData!
    override func viewDidLoad() {
        super.viewDidLoad()
        startDownLoadUserDetailInfo()
        self.navigationController?.navigationBar.hidden = true
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        startDownLoadUserDetailInfo()
        reloadUserData()
    }
//    override func viewWillAppear(animated: Bool) {
////        startDownLoadUserDetailInfo()
//        reloadUserData()
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    private func startDownLoadUserDetailInfo()
    {
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            return
        }
        zxyW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.ZXY_MyInfoAPI(ZXY_MyInfoAPIType.MI_MyInfo)
        var parameter = ["user_id" : userID!]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
            }
//            self?.dataForShow = ZXY_UserDetailInfoUserDetailBase(dictionary: returnDic)
//            var result = self?.dataForShow?.result
            var result = returnDic["result"] as Double
            if(result == 1000)
            {
                ZXY_UserInfoDetail.sharedInstance.saveUserDetailInfo(returnDic)
//                self?.userInfo = self?.dataForShow?.data
                println("\(self?.userInfo!.nickName)")
                self?.reloadUserData()
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

    func reloadUserData()
    {
        currentTable.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var segueID = segue.identifier
        if(segueID == "toLoginVC")
        {
            var loginVC = segue.destinationViewController as ZXY_LoginRegistVC
            loginVC.delegate = self
        }
        if( segueID == "toUserInfo")
        {
            var propertyVC = segue.destinationViewController as ICYProfileViewController
            propertyVC.userInfo = userInfo
//            println("\(userInfo)")
//            println("\(ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo())")
        }
        if( segueID == "toSettingVC")
        {
            var settingVC = segue.destinationViewController as SettingVC
            settingVC.userInfo = userInfo
//            settingVC.delegate = self
        }
    }
}

extension ZXY_MIMainVC : UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate , ZXY_LoginRegistVCProtocol
{
    /**
    根据indexPath 返回cell所需要显示的图片与title
    
    :param: indexPath table indexpath
    
    :returns: 图片名字 title 名字
    */
    func itemDataForTable(indexPath : NSIndexPath) -> (imageName : String , itemTitle: String)
    {
        if(indexPath.section == 1)
        {
            var currentRow = indexPath.row
            switch currentRow
            {
            case 0:
                return ("miMessage","消息")
            case 1:
                return ("miAttension","关注")
            default:
                return ("miMessage","消息")
            }
        }
        else
        {
            var currentRow = indexPath.row
            switch currentRow
            {
            case 0:
                return ("miOrder","订单")
            case 1:
                return ("miAlbum","图集")
            case 2:
                return ("miCollection","收藏")
            default:
                return ("miOrder","订单")
            }

        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var bigCell = tableView.dequeueReusableCellWithIdentifier(ZXY_MIMainVCell.cellID()) as ZXY_MIMainVCell
        bigCell.delegate = self
        var smallCell = tableView.dequeueReusableCellWithIdentifier(ZXY_MIMainItemCell.cellID()) as ZXY_MIMainItemCell
        if(indexPath.section == 0)
        {
            bigCell.backImg.backgroundColor = UIColor.NailRedColor()
            var isUserLogin = ZXY_UserInfoDetail.sharedInstance.isUserLogin()
            if !isUserLogin
            {
                bigCell.userNotLoginMethod()
            }
            else
            {
                bigCell.userLoginMethod()
                var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
                if let user = userInfoDic
                {
                    self.dataForShow = ZXY_UserDetailInfoUserDetailBase(dictionary: user)
                    userInfo = self.dataForShow?.data
                    var headImg  = userInfo?.headImage?
                    if let hI = headImg
                    {
                        var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + hI
                        if hI.hasPrefix("http")
                        {
                            imgURL = hI
                        }
                        bigCell.userAvatar.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "imgHolder"))
                    }
                    println("\(userInfo?.nickName)")
                    bigCell.nameLbl.text = userInfo?.nickName
                    bigCell.isArtistLbl.text = "美甲师"
                    var role = userInfo?.role? ?? "1"
                    if role == "2"
                    {
                        bigCell.isArtistImg.hidden = false
                        bigCell.isArtistLbl.hidden = false
                    }
                    else
                    {
                        bigCell.isArtistImg.hidden = true
                        bigCell.isArtistLbl.hidden = true
                    }
                }
                
            }
            return bigCell
        }
        else
        {
            
            var imgName = self.itemDataForTable(indexPath).imageName
            var titleName = self.itemDataForTable(indexPath).itemTitle
            smallCell.itemImg.image = UIImage(named: imgName)
            smallCell.itemTitle.text = titleName
            smallCell.itemTitle.textColor = UIColor.NailGrayColor()
            
            return smallCell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section
        {
        case 0:
            return 226
        case 1:
            return 62
        default:
            return 62
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 3
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section
        {
        case 0:
            return 0
        case 1:
            return 0
        case 2:
            return 40
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRectZero)
        headerView.backgroundColor = UIColor.whiteColor()
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func userLoginSuccess() {
        self.startDownLoadUserDetailInfo()
    }
}

extension ZXY_MIMainVC : ZXY_MIMainVCellProtocol
{
    func loginBtnClick() {
        self.performSegueWithIdentifier("toLoginVC", sender: nil)
    }
    
    func settingBtnClick() {
        EaseMob.sharedInstance().chatManager.asyncLogoffWithUnbindDeviceToken(true, completion: { (object, error) -> Void in
            self.performSegueWithIdentifier("toSettingVC", sender: nil)
        }, onQueue: nil)
    }
    
    func headImgTouch() {
        self.performSegueWithIdentifier("toUserInfo", sender: nil)
    }
}