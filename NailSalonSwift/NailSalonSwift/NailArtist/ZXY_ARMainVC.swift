//
//  ZXY_ARMainVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

//排序方式
enum artistType : Int
{
    case astistTypeHot      = 1
    case astistTypeNearby   = 2
    case astistTypeComments = 3
    case astistTypeWorks    = 4
    
}

class ZXY_ARMainVC: UIViewController {
    
    var userCoordinate : Dictionary<String, Double?>?
    var userCityName : String?
    var latitude : Double?
    var longitude : Double?
    var userId : String?
    var control : artistType = artistType.astistTypeHot
    var pageCount : Int = 1
    var dataForTable : [SR_artistData]? = []
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    //热门
    var rightButtonSelect = true
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var HotView: UIView!
    @IBOutlet weak var backgroudView: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "美甲师"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        HotView.hidden = true
        backgroudView.hidden = true
        
        self.addHeaderAndFooterforCollection()
        self.getUserInfo()
        srW.startProgress(self.view)
        self.artistInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        arrowUp()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //获取用户信息
    func getUserInfo(){
        userCoordinate = ZXY_UserInfoDetail.sharedInstance.getUserCoordinate()
        if let userLocation = userCoordinate
        {
            latitude  = userLocation["latitude"]!
            longitude = userLocation["longitude"]!
        }
        else
        {}
        
        userCityName =  ZXY_UserInfoDetail.sharedInstance.getUserCityName()
        
        if let user_id = ZXY_UserInfoDetail.sharedInstance.getUserID()
        {
            userId = user_id
        }
        else
        {
            userId = ""
        }
    }
    
    //访问网络
    private func artistInfo() {
        var urlString = ZXY_NailNetAPI.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserListAPI
        
        var parameter : Dictionary<String ,  AnyObject> = ["city": userCityName!  , "lng": longitude! , "lat": latitude!, "user_id": userId! , "control": control.rawValue , "p": pageCount]
        println("\(parameter)")
        
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter ,successBlock: { [weak self](returnDit) -> Void in
            
            var baseData = SR_artistBaseClass(dictionary: returnDit)
            var resultID = baseData.result
            if(resultID == Double(1000))
            {
                if(self?.pageCount == 1)
                {
                    self?.dataForTable = []
                }
                var resultData = baseData.data
                
                for value in resultData
                {
                    var dataValue : SR_artistData = value as! SR_artistData
                    self?.dataForTable?.append(dataValue)
                }
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
                self?.mainTableView.reloadData()
                self?.endFreshing()
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(resultID)
                self?.showAlertEasy("提示", messageContent: errorString)
                self?.endFreshing()
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
            ""
        }
    }

    private func endFreshing()
    {
        mainTableView.footerEndRefreshing()
        mainTableView.headerEndRefreshing()
    }
    
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforCollection()
    {
        mainTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.pageCount++
            self?.artistInfo()
        }
        
        mainTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
            self?.artistInfo()
        }
    }
    
    //点击背景
    @IBAction func backgroundTouch(sender: AnyObject) {
        arrowUp()
    }
    //点击rightButtonItem按钮
    @IBAction func rightButtonItemClick(sender: AnyObject) {
        if rightButtonSelect {
            arrowDown()
        }
        else{
            arrowUp()
        }
    }
    //热门下拉
    func arrowDown(){
        rightButton.setImage(UIImage(named: "arrowDown"), forState: UIControlState())
        HotView.hidden = false
        rightButtonSelect = false
        backgroudView.hidden = false
        backgroudView.alpha = 0.8
        backgroudView.layer.addAnimation(SR_Animation.animationForAlpha(0, to: 0.8), forKey: "alpha")
        HotView.layer.addAnimation(SR_Animation.animationDown(), forKey: "down")
        HotView.layer.position = CGPointMake(self.view.bounds.width - 40, 6)
        HotView.layer.anchorPoint = CGPointMake(0.7,0)
    }
    //热门推出
    func arrowUp(){
        rightButton.setImage(UIImage(named: "arrowUp"), forState: UIControlState())
        rightButtonSelect = true
        HotView.layer.addAnimation(SR_Animation().animationUp({[weak self](finish) -> Void in
            self?.HotView.hidden = true
            ""
            }), forKey: "up")
        HotView.layer.position = CGPointMake(self.view.bounds.width - 40, 6)
        HotView.layer.anchorPoint = CGPointMake(0.7,0)
        backgroudView.alpha = 0.0
        backgroudView.layer.addAnimation(SR_Animation().animationForAlpha(0.8, to: 0, finishBlock: { [weak self](finish) -> Void in
            self?.backgroudView.hidden = true
            ""
        }), forKey: "alpha")
    }

    
    @IBAction func hotButtonClick(sender: UIButton) {
        rightButton.setTitle("热门", forState: UIControlState.Normal)
        control = artistType.astistTypeHot
        self.artistInfo()
        self.mainTableView.reloadData()
        arrowUp()
    }

    @IBAction func nearbyButtonClick(sender: UIButton) {
        rightButton.setTitle("附近", forState: UIControlState.Normal)
        control = artistType.astistTypeNearby
        //
        self.artistInfo()
        self.mainTableView.reloadData()
        arrowUp()
    }
    
    @IBAction func commentsButtonClick(sender: UIButton) {
        rightButton.setTitle("评价", forState: UIControlState.Normal)
        control = artistType.astistTypeComments
        self.artistInfo()
        self.mainTableView.reloadData()
        arrowUp()
    }
    
    @IBAction func worksButtonClick(sender: UIButton) {
        rightButton.setTitle("作品", forState: UIControlState.Normal)
        control = artistType.astistTypeWorks
        self.artistInfo()
        self.mainTableView.reloadData()
        arrowUp()
    }
}

extension ZXY_ARMainVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let datas = dataForTable
        {
            return datas.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SR_ARTableViewCell.identifier) as! SR_ARTableViewCell
        
        var cellData  = dataForTable?[indexPath.row]
        
        //美甲师头像
        var imgUrl    = cellData?.headImage as String?
        if let url    = imgUrl
        {
            if (imgUrl!.hasPrefix("http"))
            {
                cell.artistView.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                cell.artistView.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
            }
        }
        else {
            cell.artistView.image = UIImage(named: "headImg")
        }
        
        //美甲师姓名
        cell.artistName.text = cellData?.nickName
        
        //作品数量
        cell.artistWorkCount.text = cellData?.albumCount
        
        //认证
        if let pass = cellData?.isPass
        {
            if pass == "0"
            {
                cell.artistV.hidden = true
            }
            else
            {
                cell.artistV.hidden = false
            }
        }
        
        //用户与美甲师距离
        var userPosition = ZXY_LocationRelative.sharedInstance.xYStringToCoor("\(longitude!)" , latitude: "\(latitude!)")
        var lng = cellData?.longitude
        var lat = cellData?.latitude
        var artistPosition = ZXY_LocationRelative.sharedInstance.xYStringToCoor(lng, latitude: lat)
        var distance = ZXY_LocationRelative.distanceCompareCoor(artistPosition, userPosition: userPosition)
        cell.artistDistance.text = "\(Double(round(100 * distance)/100)) km"
        
        //评价等级
        var scoreNSString : NSString = NSString(format: "%@", cellData!.score)
        var doubleScore   = scoreNSString.doubleValue
        cell.starRateView?.scorePercent = CGFloat(doubleScore/5.0)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellData  = dataForTable?[indexPath.row]
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as! ZXY_DFPArtistDetailVC
        vc.artistID = cellData?.userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}