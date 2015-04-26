//
//  ZXY_DFPArtistDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtistDetailVC: UIViewController {
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
    
    private var dataForShow : ZXY_ArtistDetailModelBase?
    
    var artistID : String?
    
    var isUp = true
    var previousYForCollect : CGFloat = 0
    var previousYForTable   : CGFloat = 0
    var firstCollectionVC : ZXY_DFPArtistCollectionVC!
    var secontTableVC     : ZXY_DFPArtistTableVC!
    
    @IBOutlet weak var toTopDistance: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startInitFirst()
        self.startInitSecond()
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func startLoadData()
    {
        if artistID == nil
        {
            return 
        }
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
        }) { [weak self] (error) -> Void in
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
        var headURL  : String?  = needShow?.headImage?
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
                self.attensionBtn.setTitle("关注", forState: UIControlState.Normal)
            }
        }
        
        var userCoordinate = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
        if let location = userCoordinate
        {
            var artistLocationLa = needShow?.latitude
            var artistLocationLo = needShow?.longitude
            var latitude = location["latitude"]!
            var logitude = location["longitude"]!
            var userCoordinate   = CLLocationCoordinate2DMake( latitude!,logitude! )
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
            isAristLbl.hidden = true
            isArtistImg.hidden = true
        }
        else
        {
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
            firstCollectionVC = UIStoryboard(name: "PublicStory", bundle: nil).instantiateViewControllerWithIdentifier(ZXY_DFPArtistCollectionVC.vcID()) as ZXY_DFPArtistCollectionVC
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
            secontTableVC = UIStoryboard(name: "PublicStory", bundle: nil).instantiateViewControllerWithIdentifier(ZXY_DFPArtistTableVC.vcID()) as ZXY_DFPArtistTableVC
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

//    func attensionChange(){
//        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
//        if(userID == nil)
//        {
//            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
//            alert.show()
//            return
//        }
//        var parameter : [String : AnyObject] = Dictionary<String , AnyObject>()
//        var data = self.dataForShow?.data
//        if artistID != nil
//        {
//            var control  = data?.isAttention == 1 ? 2 : 1
//            parameter = ["user_id" : userID! , "attention_user_id" : artistID! , "control": "\(control)"]
//            ZXY_NetHelperOperate().albumAgreeOrCollectionAndAtten(ZXY_ADFPAPIType.ADFP_ArtCollection, parameter: parameter, success: {[weak self] (currentStage) -> Void in
//                data?.isAttention = Double(control)
//                self?.isAttensionFunc(Double(control))
//                ""
//                }, fail: { (errorMessage) -> Void in
//                    println(errorMessage)
//                    ""
//            })
//        }
//    }
//    func isAttensionFunc(isAtten : Double)
//    {
//        if isAtten == 1
//        {
//            self.attensionBtn.setTitleColor(UIColor.NailGrayColor(), forState: UIControlState.Normal)
//            self.attensionBtn.setTitle("已关注", forState: UIControlState.Normal)
//            self.attensionBtn.layer.borderColor = UIColor.NailGrayColor().CGColor
//        }
//        else
//        {
//            self.attensionBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
//            self.attensionBtn.setTitle("关 注", forState: UIControlState.Normal)
//            self.attensionBtn.layer.borderColor = UIColor.NailRedColor().CGColor
//        }
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ZXY_DFPArtistDetailVC : ZXY_DFPArtistCollectionVCDelegate , ZXY_DFPArtistTableVCDelegate , UIScrollViewDelegate
{
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func attensionAction(sender: AnyObject) {
//        self.attensionChange()
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
        var vc    = story.instantiateViewControllerWithIdentifier("artDetailID") as ZXY_DFPArtDetailVC
        vc.artWorkID = albumID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ZXY_DFPArtistDetailVC : UIAlertViewDelegate , ZXY_LoginRegistVCProtocol {
    func userLoginSuccess() {
        self.startLoadData()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 1)
        {
            var story = UIStoryboard(name: "MyInfoStory", bundle: nil) as UIStoryboard
            var loginVC = story.instantiateViewControllerWithIdentifier("loginVCID") as ZXY_LoginRegistVC
            loginVC.delegate = self
            loginVC.navigationController?.navigationBar.hidden = true
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}
