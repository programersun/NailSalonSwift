//
//  ZXY_DFPArtDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtDetailVC: UIViewController {
    let screenSize = UIScreen.mainScreen().bounds
    
    @IBOutlet var commentView: UIView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    
    private var dataForComment : ZXY_AlbumCommentBaseComment?
    private var dataforCommentArr : [ZXY_AlbumCommentData]?
    private var dataForTable : ZXY_AlbumDetailBaseAlbum?
    private var zxyW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    private var currentPage : Int = 1
    @IBOutlet weak var currentTable: UITableView!
    private var dataForTag : String? = ""

    var artWorkID : String!
    var userID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //commentView.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.startGetArtDetail()
        currentTable.hidden = true
        commentView.frame = CGRectMake(0, screenSize.height , screenSize.width , 70)
        self.view.addSubview(commentView)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
        currentTable.tableFooterView = UIView(frame: CGRectZero)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoardShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoradFrameChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoardHide:"), name: UIKeyboardWillHideNotification, object: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登出", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("rightBtnAction"))
        
        // Do any additional setup after loading the view.
        
    }
    
    func rightBtnAction()
    {
        ZXY_UserInfoDetail.sharedInstance.logoutUser()
        EaseMob.sharedInstance().chatManager.asyncLogoffWithUnbindDeviceToken(true, completion: { (object, error) -> Void in
            
        }, onQueue: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }
    
    func addFootterForTable()
    {
        currentTable.addFooterWithCallback { [weak self]() -> Void in
            self?.currentPage++
            self?.startGetComment()
        }
    }
    
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
                    self?.commentView.frame = CGRectMake(0,  keyBoardHeight - 134, s.screenSize.width, 70)
                }
                
            })
        }
        
    }
    
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
                    self?.commentView.frame = CGRectMake(0,  keyBoardHeight - 134, s.screenSize.width, 70)
                }
                
            })
        }

    }
    
    func keyBoardHide(noty : NSNotification)
    {
        UIView.animateWithDuration(0.5, animations: { [weak self]() -> Void in
            if let s = self
            {
                self?.commentView.frame = CGRectMake(0, s.screenSize.height, s.screenSize.width, 70)
            }
            
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGetArtDetail()
    {
        zxyW.startProgress(self.view)
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID() ?? ""
        var stringURL = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADFP_ArtDetail)
        var parameter = ["user_id" : userID , "album_id" : artWorkID]
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.dataForTable = ZXY_AlbumDetailBaseAlbum(dictionary: returnDic)
            var result = self?.dataForTable?.result ?? 0
            if result == 1000 || result == 1003
            {
                self?.dataForTag = self?.dataForTable?.data.tag? ?? ""
                self?.currentTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                self?.currentTable.reloadSections(NSIndexSet(index: 1), withRowAnimation: UITableViewRowAnimation.None)
                if let s = self
                {
                    self?.zxyW.hideProgress(s.view)
                    self?.currentTable.hidden = false
                }
                self?.addFootterForTable()
                self?.startGetComment()
                
                
            }
            else
            {
                var messageError = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: messageError)
                if let s = self
                {
                    self?.zxyW.hideProgress(s.view)
                }
            }
            return
            
        }) {[weak self] (error) -> Void in
            ""
            ""
            if let s = self
            {
                self?.zxyW.hideProgress(s.view)
            }
        }
    }

    func startGetComment()
    {
        var stringURL = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADFP_ArtComment)
        var parameter : [String : AnyObject] = ["album_id" : artWorkID , "p" : currentPage]
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.currentTable.footerEndRefreshing()
            self?.dataForComment = ZXY_AlbumCommentBaseComment(dictionary: returnDic)
            var result = self?.dataForComment?.result ?? 0
            if result == 1000 || result == 1003
            {
                if(self?.dataforCommentArr == nil || self?.currentPage == 0)
                {
                    self?.dataforCommentArr = []
                }
                var commentArr = self?.dataForComment?.data ?? []
                for comment in commentArr
                {
                    var value = comment as ZXY_AlbumCommentData
                    self?.dataforCommentArr?.append(value)
                }
                self?.currentTable.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)
            }
            else
            {
                var message = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: message)
            }
            
        }) {[weak self] (error) -> Void in
            self?.currentTable.footerEndRefreshing()
            ""
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
    

}

extension ZXY_DFPArtDetailVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var imgContentCell = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADImgContainerCell.cellID()) as ZXY_DFPADImgContainerCell
        var tagCell        = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADTagCell.cellID()) as ZXY_DFPADTagCell
        var commentCell    = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADCommentCell.cellID()) as
            ZXY_DFPADCommentCell
        var commentActionCell = tableView.dequeueReusableCellWithIdentifier("commentCellID") as UITableViewCell
        
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        switch currentSection
        {
        case 0:
            var imgCellData = dataForTable?.data
            var imgCellUser = imgCellData?.user
            var imgs      = imgCellData?.images?
            imgContentCell.artistID = imgCellData?.userId
            if let si = imgs
            {
                if si.count > 0
                {
                    var imgURL = si[0] as ZXY_AlbumDetailImages
                    var stringURL = ZXY_NailNetAPI.ZXY_MainAPIImage + imgURL.imagePath
                   // imgContentCell.contentImg.setImageWithURL(NSURL(string: stringURL), placeholderImage: UIImage(named: "imgHolder"))
                    
                }
            }
            imgContentCell.imgName.text = imgCellData?.dataDescription
            imgContentCell.artistName.text = imgCellUser?.nickName
            var avaImg = imgCellUser?.headImage?
            if let ava = avaImg
            {
                var avatarImg = ZXY_NailNetAPI.ZXY_MainAPIImage + ava
                if ava.hasPrefix("http")
                {
                    avatarImg = ava
                }
                imgContentCell.artistAvatar.setImageWithURL(NSURL(string: avatarImg), placeholderImage: UIImage(named: "imgHolder"))
            }
            var isCollection = imgCellData?.isCollect ?? 0
            var isAgree      = imgCellData?.isAgree   ?? 0
            var isAtten      = imgCellData?.isAtten   ?? 0
            var collectNum   = imgCellData?.collectCount ?? "0"
            var agreeNum     = imgCellData?.agreeCount ?? "0"
            imgContentCell.pageNum.numberOfPages = imgCellData?.images.count ?? 1
            imgContentCell.imgS = imgCellData?.images
            imgContentCell.isCollectionFunc(isCollection)
            imgContentCell.isAgreeFunc(isAgree)
            imgContentCell.isAttensionFunc(isAtten)
            imgContentCell.heartLbl.text = agreeNum
            imgContentCell.starLbl.text  = collectNum
            imgContentCell.delegate = self
            return imgContentCell
        case 1:
            var CellData = dataForTable?.data
            if let data = CellData
            {
                var tagString = data.tag?.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil) ?? ""
                tagCell.setTagView(tagString)
            }
            var price = CellData?.price ?? "0"
            tagCell.priceValue.text = "￥\(price)"
            return tagCell
        case 2:
            if indexPath.row == 0
            {
                var btn = commentActionCell.viewWithTag(111) as UIButton
                btn.addTarget(self, action: Selector("commentBtnAction"), forControlEvents: UIControlEvents.TouchUpInside)
                return commentActionCell
            }
            var currentData : ZXY_AlbumCommentData? = dataforCommentArr![indexPath.row - 1] as ZXY_AlbumCommentData
            var headImgUrl  = currentData?.headImage?
            if let head = headImgUrl
            {
                var imgURLString = ZXY_NailNetAPI.ZXY_MainAPIImage + head
                if head.hasPrefix("http")
                {
                    imgURLString = head
                }
                
                commentCell.criticImg.setImageWithURL(NSURL(string: imgURLString), placeholderImage: UIImage(named: "imgHolder"))
            }
            commentCell.criticName.text = currentData?.nickName ?? ""
            commentCell.commentLbl.text = currentData?.content  ?? ""
            var dataTime = self.timeStampToDateString(currentData?.addTime ?? "0")
            commentCell.timeLbl.text = dataTime
            return commentCell
        default :
            return imgContentCell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        switch currentSection
        {
        case 0:
            // MARK: 不要删除此处注释
//            var imgCellData = dataForTable?.data
//            var imgs      = imgCellData?.images?
//            if let imageReal = imgs
//            {
//                if imageReal.count > 0
//                {
//                    var tempImg = imageReal[0] as ZXY_AlbumDetailImages
//                    var width   = NSString(format: "%@", tempImg.width)
//                    var height  = NSString(format: "%@", tempImg.height)
//                    var ratio   = width.floatValue / height.floatValue
//                    return screenSize.width / CGFloat(ratio)
//                }
//            }
            return 311
        case 1 :
            var tagV = ZXY_TagLabelView()
            tagV.lineWidth = UIScreen.mainScreen().bounds.width - 71
            dataForTag = dataForTag?.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
            tagV.setAllTagString(dataForTag ?? "")
            var tagViewHeight = tagV.getCellHeight()
            var cellHeight    = tagViewHeight + 44
            return cellHeight
        case 2:
            if(currentRow == 0)
            {
                return 50
            }
            var currentData : ZXY_AlbumCommentData? = dataforCommentArr![indexPath.row - 1] as ZXY_AlbumCommentData
            var testString = currentData?.content  ?? ""
            var height = UIViewController.getCellHeightWith(textString: testString, minHeight: 21, fontSize: UIFont.systemFontOfSize(17), constraintWidth: screenSize.width - 90)
            return height + 59
        default:
            return 80
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 1
        case 2 where dataforCommentArr != nil:
            return dataforCommentArr!.count + 1 ?? 1
        default:
            return 0
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
            return 20
        case 2:
            return 20
        default:
            return 0
        }
    }
    
    @IBAction func sendAction(sender: AnyObject)
    {
        
        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
            alert.show()
            return
            
        }
        else
        {
            zxyW.startProgress(self.view)
            var urlString = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADFP_ArtCommentAdd)
            var parameter = ["user_id" : userID , "album_id" : self.artWorkID , "content" : self.commentText.text]
            ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
                if let s = self
                {
                    s.zxyW.hideProgress(s.view)
                }
                var result: Double = returnDic["result"] as Double
                if result == 1000
                {
                    var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
                    var userInfo    = ZXY_UserDetailInfoUserDetailBase(dictionary: userInfoDic)
                    var user : ZXY_UserDetailInfoData = userInfo.data as ZXY_UserDetailInfoData
                    var commentUser = ZXY_AlbumCommentData()
                    commentUser.nickName = user.nickName
                    commentUser.headImage = user.headImage
                    commentUser.userId    = ZXY_UserInfoDetail.sharedInstance.getUserID()
                    commentUser.addTime   = "\(NSDate(timeIntervalSinceNow: 0).timeIntervalSince1970)"
                    commentUser.content   = self?.commentText.text
                    self?.dataforCommentArr?.insert(commentUser, atIndex: 0)
                    self?.commentText.resignFirstResponder()
                    self?.currentTable.reloadSections(NSIndexSet(index: 2), withRowAnimation: UITableViewRowAnimation.None)

                }
                else
                {
                    var errorMessage = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                    self?.showAlertEasy("提示", messageContent: errorMessage)
                }
                ""
                ""
            }, failBlock: { [weak self](error) -> Void in
                ""
                if let s = self
                {
                    s.zxyW.hideProgress(s.view)
                }
                ""
            })
        }

    }
    
    func commentBtnAction()
    {
        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
            alert.tag = 1
            alert.show()
            
            
        }
        else
        {
            commentText.becomeFirstResponder()
        }
    }
    
}

extension ZXY_DFPArtDetailVC : UIAlertViewDelegate , ZXY_LoginRegistVCProtocol , ZXY_DFPADImgContainerCellProtocol
{
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 1 {
            if(buttonIndex == 1)
            {
                var story = UIStoryboard(name: "MyInfoStory", bundle: nil) as UIStoryboard
                var loginVC = story.instantiateViewControllerWithIdentifier("loginVCID") as ZXY_LoginRegistVC
                loginVC.title = "登录"
                loginVC.delegate = self
                loginVC.navigationItem.leftBarButtonItem?.title = "返回"
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
        if alertView.tag == 2 {
            switch buttonIndex {
            case 0:
                return
            case 1:
                self.deleteAblum()
                self.navigationController?.popViewControllerAnimated(true)
            default:
                return
            }

        }
    }
    
    func deleteAblum(){
        zxyW.startProgress(self.view)
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_DeleteAlbumAPI
        var parameter = ["album_id" : artWorkID!]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in

        }) { [weak self](error) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
            }
        }
    }
    
    func userLoginSuccess() {
        self.startDownLoadUserDetailInfo()
        
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
            var userInfo = ZXY_UserDetailInfoUserDetailBase(dictionary: returnDic)
            var result = userInfo.result
            if(result == 1000)
            {
                ZXY_UserInfoDetail.sharedInstance.saveUserDetailInfo(returnDic)
                self?.startGetArtDetail()
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
    
    func userClickCollectionImg() {
        self.operateStatusChange(ZXY_ADFPAPIType.ADFP_ArtCollection)
    }
    
    func userClickAgreeImg() {
        self.operateStatusChange(ZXY_ADFPAPIType.ADFP_ArtAgree)
    }
    
    func userClickAttensionImg() {
        self.operateStatusChange(ZXY_ADFPAPIType.ADFP_ArtAttension)
    }
    
    func userClickEditBtn() {
        var editAler = UIAlertView()
        editAler.message  = "您确定删除图集吗？"
        editAler.title    = "提示"
        editAler.addButtonWithTitle("取消")
        editAler.addButtonWithTitle("确定")
        editAler.tag = 2
        editAler.delegate = self
        editAler.show()
    }
    
    func userClickAvaterImg() {
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var detailArtist = storyboard?.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as ZXY_DFPArtistDetailVC
        var imgCellData = dataForTable?.data
        var imgCellUser = imgCellData?.user
        if imgCellUser == nil
        {
            return
        }
        detailArtist.artistID = imgCellUser?.userId
        self.navigationController?.pushViewController(detailArtist, animated: true)
    }
    
    func operateStatusChange(type : ZXY_ADFPAPIType)
    {
        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var currentData = self.dataForTable?.data
        if currentData == nil
        {
            return
        }
        if userID == nil
        {
            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
            alert.show()
            return
        }
        var parameter : [String : AnyObject] = Dictionary<String , AnyObject>()
        var data = self.dataForTable?.data
        println("\(type.rawValue)")
        switch type
        {
        case .ADFP_ArtAttension:
            
            var artistID = data?.userId
            if artistID != nil
            {
                var control  = data?.isAtten == 1 ? 2 : 1
                parameter = ["user_id" : userID! , "attention_user_id" : artistID! , "control": "\(control)"]
                ZXY_NetHelperOperate().albumAgreeOrCollectionAndAtten(type, parameter: parameter, success: {[weak self] (currentStage) -> Void in
                    data?.isAtten = Double(control)
                    self?.currentTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                    ""
                }, fail: { (errorMessage) -> Void in
                    println(errorMessage)
                    ""
                })
            }
        case .ADFP_ArtAgree:
            var status = data?.isAgree == 1 ? 2 : 1
            parameter = ["user_id" : userID! , "album_id" : artWorkID , "status": status]
            ZXY_NetHelperOperate().albumAgreeOrCollectionAndAtten(type, parameter: parameter, success: {[weak self] (currentStage) -> Void in
                data?.isAgree = Double(status)
                self?.currentTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
            }, fail: { (errorMessage) -> Void in
                
            })
        case .ADFP_ArtCollection:
            var status = data?.isCollect == 1 ? 2 : 1
            parameter = ["user_id" : userID! , "album_id" : artWorkID , "status": status]
            ZXY_NetHelperOperate().albumAgreeOrCollectionAndAtten(type, parameter: parameter, success: {[weak self] (currentStage) -> Void in
                data?.isCollect = Double(status)
                self?.currentTable.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
                
                }, fail: { (errorMessage) -> Void in
                    
            })
        default:
            return

        }
    }
    
    func clickImageAtIndexPath(indexPath: NSIndexPath) {
        var data = self.dataForTable?.data
        var items : [ZXY_ImageItem] = []
        if let da = data
        {
            var imgs = da.images
            for (index , value) in enumerate(imgs)
            {
                var realImage: ZXY_AlbumDetailImages = value as ZXY_AlbumDetailImages
                var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + realImage.imagePath
                var item = ZXY_ImageItem(itemURL: NSURL(string: imgURL))
                items.append(item)
            }
            var imgBrowser = ZXY_ImageBrowserVC()
            imgBrowser.setPhotos(items)
            imgBrowser.setSelectIndex(indexPath.row)
            imgBrowser.presentShow()
        }
    }

}


    

