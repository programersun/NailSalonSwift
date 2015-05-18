//
//  ZXY_DFPArtistDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//  美甲师 2 普通用户1

import UIKit

class ZXY_DFPArtistDetailVC: UIViewController , UIAlertViewDelegate {
    private var screenSize  = UIScreen.mainScreen().bounds
    @IBOutlet weak var contentScroll: UIScrollView!

    @IBOutlet weak var widthOfAttensionBtn: NSLayoutConstraint!
    @IBOutlet weak var avaterAristImg: UIImageView!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var isArtistImg: UIImageView!
    
    @IBOutlet weak var isAristLbl: UILabel!
    
    @IBOutlet weak var evalueateView: UIView!
    
    @IBOutlet weak var attensionBtn: UIButton!
    
    @IBOutlet weak var distanceLbl: UILabel!
    
    @IBOutlet weak var filterSeg: UISegmentedControl!
    
    @IBOutlet weak var headerV: UIView!
    
    var zxyW = ZXY_WaitProgressVC()
    
    private var currentUserRole = "1"
    private var currentArtRole  = "1"
    
    
    private var isShowChat = false
    
    
    private var dataForShow : ZXY_ArtistDetailModelBase?
    
    @IBOutlet weak var lingdangBtn: UIImageView!
    
    @IBAction func lingDangAction(sender: AnyObject) {
        if currentUserRole == "1" && currentArtRole != "1"
        {
            if isShowChat
            {
                isShowChat = false
                self.hideTheChatOrYue()
            }
            else
            {
                isShowChat = true
                self.showTheChatOrYue()
            }
        }
        else
        {
            self.chatBaoAction("")
        }
        
    }
    @IBOutlet weak var chatBtn: UIImageView!
    
    @IBAction func chatBaoAction(sender: AnyObject) {
        println("交流")
        
        var userInfo = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
        
        if userInfo == nil
        {
            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
            alert.show()
            return

        }
        else
        {
            if self.artistID == ZXY_UserInfoDetail.sharedInstance.getUserID(){
                self.showAlertEasy("提示", messageContent: "不能和自己聊天")
            }
            else {
                var my = ZXY_UserDetailInfoUserDetailBase(dictionary: userInfo)
                var myData = my.data
                var artData = dataForShow?.data
                if artData == nil
                {
                    return
                }
                else
                {
                    if artistID == nil
                    {
                        return
                    }
                    var chatView = ChatViewController(chatter: artistID!, isGroup: false)
                    chatView.title = artData?.nickName
                    var imgHeader : String? = artData!.headImage
                    var stringURL : String? =  ZXY_ALLApi.ZXY_MainAPIImage + (imgHeader ?? "")
                    if let img = imgHeader
                    {
                        if(img.hasPrefix("http"))
                        {
                            stringURL = artData!.headImage
                        }
                    }
                    chatView.imgURLTo = stringURL
                    var myHeadImg : String? = myData.headImage
                    if let myI = myHeadImg
                    {
                        var imgURL =  ZXY_ALLApi.ZXY_MainAPIImage + myData.headImage
                        if myI.hasPrefix("http")
                        {
                            imgURL = myI
                        }
                        chatView.imgURLMy = imgURL
                    }
                    self.navigationController?.pushViewController(chatView, animated: true)
                }
            
            }
        }

    }
    
    
    @IBOutlet weak var yueBtm: UIImageView!
    
    @IBAction func yueAction(sender: AnyObject) {
        var story = UIStoryboard(name: "SR_OrderStory", bundle: nil) as UIStoryboard
        var orderVC = story.instantiateViewControllerWithIdentifier("SR_OrderMainVCID") as! SR_OrderMainVC
        orderVC.artistId  = self.artistID
        orderVC.orderType = 1
        self.navigationController?.pushViewController(orderVC, animated: true)
    }
    
    
    
    func showTheChatOrYue()
    {
        chatBtn.hidden = false
        yueBtm.hidden  = false
        chatBtn.layer.addAnimation(ZXY_AnimationHelper().animationForPositionOrRotation(lingdangBtn.center, endPoint: chatBtn.center, endBlock: nil), forKey: "chatBtn")
        yueBtm.layer.addAnimation(ZXY_AnimationHelper().animationForPositionOrRotation(lingdangBtn.center, endPoint: yueBtm.center, endBlock: nil), forKey: "chatBtn")
    }
    
    func hideTheChatOrYue()
    {
        chatBtn.layer.addAnimation(ZXY_AnimationHelper().animationForPositionOrRotation(chatBtn.center, endPoint: lingdangBtn.center, endBlock: {[weak self] () -> Void in
            self?.chatBtn.hidden = true
            ""
        }), forKey: "chatBtn")
        
        yueBtm.layer.addAnimation(ZXY_AnimationHelper().animationForPositionOrRotation(yueBtm.center, endPoint: lingdangBtn.center, endBlock: {[weak self] () -> Void in
            self?.yueBtm.hidden = true
            ""
            }), forKey: "chatBtn")

        
    }
    
    var artistID : String?
    
    var isUp = true
    var previousYForCollect : CGFloat = 0
    var previousYForTable   : CGFloat = 0
    var firstCollectionVC : ZXY_DFPArtistCollectionVC!
    var secontTableVC     : ZXY_DFPArtistTableVC!
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    @IBOutlet weak var toTopDistance: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideTheChatOrYue()
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        contentScroll.contentSize.width = 2 * screenSize.width
        contentScroll.delegate = self
        self.startInitSeg()
        self.startLoadData()
        headerV.backgroundColor = UIColor.NailRedColor()
        self.avaterAristImg.layer.cornerRadius = 35
        self.avaterAristImg.layer.masksToBounds = true
        self.attensionBtn.layer.cornerRadius   = 4
        self.attensionBtn.layer.masksToBounds  = true
        self.attensionBtn.layer.borderColor    = UIColor.whiteColor().CGColor
        self.attensionBtn.layer.borderWidth    = 1
        self.lingdangBtn.hidden = true
        self.setNaviBarRightImage("blockImg")
        // Do any additional setup after loading the view.
    }
    
    override func rightNaviButtonAction() {
        var alert = UIAlertView(title: "提示", message: "是否将此用户加入黑名单？", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确认")
        alert.tag = 110
        alert.show()
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.navigationBar.hidden = false
        self.startInitFirst()
        self.startInitSecond()
    }

    private func startLoadData()
    {
        if artistID == nil
        {
            return 
        }
        
        srW.startProgress(self.view)
        var stringURL = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADPF_ArtistDetailInfo)
        var myID = ZXY_UserInfoDetail.sharedInstance.getUserID() ?? ""
        
        var parameter = ["user_id" : artistID! , "my_user_id" : myID]
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            self?.dataForShow = ZXY_ArtistDetailModelBase(dictionary: returnDic)
            var result = self?.dataForShow?.result ?? 0
            if result == 1000
            {
                self?.reloadDataForView()
                
            }
            else
            {
                var errorMessage = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: errorMessage)
            }
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
        }) { [weak self] (error) -> Void in
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            ""
            ""
        }
        
    }
    
    private func reloadDataForView()
    {
        var needShow = dataForShow?.data
        var artistName = needShow?.nickName
        var isArtist   = needShow?.role
        var score      = needShow?.score ?? "0"
        var headURL  : String?  = needShow?.headImage
        var doubleScore = NSString(string: score).doubleValue
        self.artistName.text = artistName
        var attension = needShow?.isAttention ?? 0
        var myID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if myID == nil
        {
            self.attensionBtn.hidden = false
            self.attensionBtn.setTitle("关注", forState: UIControlState.Normal)
        }
        else if myID == artistID!
        {
             self.attensionBtn.hidden = true
            self.widthOfAttensionBtn.constant = 0
        }
        else
        {
             self.attensionBtn.hidden = false
            if attension == 1
            {
                self.attensionBtn.setTitle("已关注", forState: UIControlState.Normal)
            }
            else
            {
                self.attensionBtn.setTitle("关 注", forState: UIControlState.Normal)
            }
        }
        
        var userCoordinate = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
        if let location = userCoordinate
        {
            var artistLocationLa = needShow?.latitude
            var artistLocationLo = needShow?.longitude
            var latitude = location["latitude"]!
            var logitude = location["longitude"]!
            if latitude == nil
            {
                self.distanceLbl.hidden = true
            }
            else
            {
                self.distanceLbl.hidden = false
            }
            var userCoordinate   = CLLocationCoordinate2DMake( latitude ?? 0,logitude ?? 0 )
            if artistLocationLa != nil && artistLocationLo != nil
            {
                var coordinateArtist = ZXY_LocationRelative.sharedInstance.xYStringToCoor(artistLocationLo, latitude: artistLocationLa)
                if coordinateArtist != nil
                {
                    var distance = ZXY_LocationRelative.distanceCompareCoor(coordinateArtist, userPosition: userCoordinate)
                    self.distanceLbl.text = "\(Double(round(100 * distance)/100)) km"
                }
            }
            
        }
        
        if isArtist == "1"
        {
            currentArtRole = "1"
            isAristLbl.hidden = true
            isArtistImg.hidden = true
        }
        else
        {
            currentArtRole = "2"
            isAristLbl.hidden = false
            isArtistImg.hidden = false
        }
        
        var startV = CWStarRateView(frame: self.evalueateView.bounds, numberOfStars: 5)
        startV.allowIncompleteStar = true
        startV.scorePercent = CGFloat(doubleScore/5.0)
        self.evalueateView.addSubview(startV)
        if let head = headURL
        {
            var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + head
            if head.hasPrefix("http")
            {
                imgURL = head
            }
            self.avaterAristImg.setImageWithURL(NSURL(string: imgURL))
        }
        self.startInitLoadChatImg()
        
    }
    
    func startInitLoadChatImg()
    {
        var userInfo = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
        if userInfo == nil
        {
            return
        }
        else
        {
            var user = ZXY_UserInfoBase(dictionary: userInfo)
            var userData = user.data
            currentUserRole = userData.role
        }
        
        if currentUserRole == "1" && currentArtRole != "1"
        {
            lingdangBtn.image = UIImage(named: "lingdang")
        }
        else
        {
            lingdangBtn.image = UIImage(named: "chatBao")
        }
        lingdangBtn.hidden = false
    }

    
    func startInitSeg()
    {
        filterSeg.selectedSegmentIndex = 0
        //filterSeg.frame = CGRectMake(0, filterSeg.frame.origin.y, filterSeg.frame.size.width, filterSeg.frame.size.height)
        filterSeg.setTitle("图集", forSegmentAtIndex: 0)
        filterSeg.setTitle("评价", forSegmentAtIndex: 1)
        filterSeg.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.NailRedColor()], forState: UIControlState.Selected)
        filterSeg.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.NailGrayColor()], forState: UIControlState.Normal)
        
        filterSeg.setDividerImage(UIImage(named: "verticalGray"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
        filterSeg.setDividerImage(UIImage(named: "verticalGray"), forLeftSegmentState: UIControlState.Selected, rightSegmentState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        
        filterSeg.setBackgroundImage(UIImage(named: "segBarSelect"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        filterSeg.setBackgroundImage(UIImage(named: "segBarNoSelect"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
    }

    
    func startInitFirst()
    {
        if firstCollectionVC == nil
        {
            firstCollectionVC = UIStoryboard(name: "PublicStory", bundle: nil).instantiateViewControllerWithIdentifier(ZXY_DFPArtistCollectionVC.vcID()) as! ZXY_DFPArtistCollectionVC
            firstCollectionVC.userID = self.artistID
            self.addChildViewController(firstCollectionVC)
            firstCollectionVC.delegatela = self
            firstCollectionVC.view.frame = CGRectMake(0, 0, screenSize.width,contentScroll.frame.size.height)
            self.contentScroll.addSubview(firstCollectionVC.view)
        }
    }
    
    func startInitSecond()
    {
        if secontTableVC == nil
        {
            secontTableVC = UIStoryboard(name: "PublicStory", bundle: nil).instantiateViewControllerWithIdentifier(ZXY_DFPArtistTableVC.vcID()) as! ZXY_DFPArtistTableVC
            secontTableVC.userID = self.artistID
            self.addChildViewController(secontTableVC)
            secontTableVC.delegateL = self
            secontTableVC.view.frame = CGRectMake(screenSize.width, 0, screenSize.width , contentScroll.frame.size.height)
            self.contentScroll.addSubview(secontTableVC.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func attensionChange(){
        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
            alert.show()
            return
        }
        var parameter : [String : AnyObject] = Dictionary<String , AnyObject>()
        var data = self.dataForShow?.data
        if artistID != nil
        {
            var control  = data?.isAttention == 1 ? 2 : 1
            parameter = ["user_id" : userID! , "attention_user_id" : artistID! , "control": "\(control)"]
            ZXY_NetHelperOperate().albumAgreeOrCollectionAndAtten(ZXY_ADFPAPIType.ADFP_ArtAttension, parameter: parameter, success: {[weak self] (currentStage) -> Void in
                data?.isAttention = Double(control)
                self?.isAttensionFunc(Double(control))
                ""
                }, fail: { (errorMessage) -> Void in
                    println(errorMessage)
                    ""
            })
        }
    }
    func isAttensionFunc(isAtten : Double)
    {
        if isAtten == 1
        {
            self.attensionBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.attensionBtn.setTitle("已关注", forState: UIControlState.Normal)
            self.attensionBtn.layer.borderColor = UIColor.whiteColor().CGColor
        }
        else
        {
            self.attensionBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.attensionBtn.setTitle("关 注", forState: UIControlState.Normal)
            self.attensionBtn.layer.borderColor = UIColor.whiteColor().CGColor
        }
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
extension ZXY_DFPArtistDetailVC : ZXY_DFPArtistCollectionVCDelegate , ZXY_DFPArtistTableVCDelegate , UIScrollViewDelegate , UIAlertViewDelegate
{
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func attensionAction(sender: AnyObject) {
        self.attensionChange()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var x = contentScroll.contentOffset.x
        if x == 0
        {
            filterSeg.selectedSegmentIndex = 0
        }
        else if x == screenSize.width
        {
            filterSeg.selectedSegmentIndex = 1
        }
    }
    
    @IBAction func typeChange(sender: AnyObject) {
        var indexOfControl = filterSeg.selectedSegmentIndex
        if indexOfControl == 0
        {
            contentScroll.contentOffset.x = 0
        }
        else
        {
            contentScroll.contentOffset.x = screenSize.width
        }
    }
    
    func collectionDidScroll(contentOffSet: CGPoint) {
        var y = contentOffSet.y
        if y > previousYForCollect
        {
            isUp = true
        }
        else
        {
            isUp = false
        }
        previousYForCollect = y
        self.titleHeaderViewScroll(y)
    }
    
    func tableDidScroll(contentOffSet: CGPoint) {
        var y = contentOffSet.y
        if y > previousYForTable
        {
            isUp = true
        }
        else
        {
            isUp = false
        }
        previousYForTable = y

        //firstCollectionVC.currentCollection.contentOffset.y = y
        self.titleHeaderViewScroll(y)
    }
    
    func titleHeaderViewScroll(y : CGFloat)
    {
        if(toTopDistance.constant <= -144 && isUp)
        {
            toTopDistance.constant = -144
            return
        }
        
        if(toTopDistance.constant >= 0 && !isUp)
        {
            toTopDistance.constant = 0
        }
        
        if !isUp
        {
            if y <= 144
            {
                toTopDistance.constant = -y
            }
        }
        else
        {
            toTopDistance.constant = -y
        }
    }
    func sendAlbumIDToVC(albumID: String) {
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("artDetailID") as! ZXY_DFPArtDetailVC
        vc.artWorkID = albumID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ZXY_DFPArtistDetailVC : UIAlertViewDelegate , ZXY_LoginRegistVCProtocol {
    func userLoginSuccess() {
        self.startLoadData()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 110
        {
            if buttonIndex == 0
            {
                println("hello world 0")
            }
            else
            {
                EaseMob.sharedInstance().chatManager.blockBuddy(self.artistID, relationship: eRelationshipFrom)
                self.showAlertEasy("提示", messageContent: "添加黑名单成功，您可以在设置中查看")
                println("hello world 1")
            }
        }
        else
        {
            if(buttonIndex == 1)
            {
                var story = UIStoryboard(name: "MyInfoStory", bundle: nil) as UIStoryboard
                var loginVC = story.instantiateViewControllerWithIdentifier("loginVCID") as! ZXY_LoginRegistVC
                loginVC.delegate = self
                loginVC.navigationController?.navigationBar.hidden = true
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
}
