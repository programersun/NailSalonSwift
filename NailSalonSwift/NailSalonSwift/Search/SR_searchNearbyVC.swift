//
//  SR_searchNearbyVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit

class SR_searchNearbyVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchMapView: BMKMapView!
    @IBOutlet weak var rightBtn: UIBarButtonItem!
    
    @IBOutlet weak var targetImage: UIButton!
    @IBOutlet weak var littleBoy: UIImageView!
    
    let mapScale   : CLLocationDegrees = 0.001
    var isFirst = true
    
    var annos : [SR_BMKAnnotation]! = []
    var isMapSpanFirst = true
    private var previousPointY : CGFloat = 0.0
    
    private var isDownLoad :  Bool       = false
    private var isLocationFirst : Bool   = true
    private var previousTimeStamp  = NSDate().timeIntervalSince1970
    var userCoordinate : Dictionary<String, Double?>?
    var userCityName : String?
    var latitude : Double?
    var longitude : Double?
    var userID : String!
    var control : Int = 2
    var pageCount : Int = 1
    var isMap : Bool = true
    var dataForShow : NSMutableArray = NSMutableArray()
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.searchTableView.hidden = true
        self.isMap = true
        self.getUserInfo()
        self.startInitLittleBoy()
        self.startInitTargetImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(isFirst)
        {
            self.reFreshLocation(true)
            searchMapView.frame = self.view.frame
            
            isFirst = false
        }
        else
        {
            
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("notiFinish"), name: ZXY_ConstValue.MAPAUTHKEY.rawValue, object: nil)
        
    }
    
    func notiFinish()
    {
        self.reFreshLocation(false)
    }
    
    override func viewWillAppear(animated: Bool) {
        searchMapView.viewWillAppear()
        searchMapView.delegate = self
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        searchMapView.viewWillDisappear()
        searchMapView.delegate = nil
        
    }
    
    func startInitLittleBoy()
    {
        littleBoy.image = UIImage(named: "search_personCenter")
        var images : [UIImage]  = [UIImage(named: "search_personLeft")!, UIImage(named: "search_personCenter")!, UIImage(named: "search_personRight")!]
        littleBoy.animationImages      = images
        littleBoy.animationDuration    = 0.5
        littleBoy.animationRepeatCount = 0
    }
    
    
    func startInitTargetImage()
    {
        targetImage.userInteractionEnabled = true
        var tapGes = UITapGestureRecognizer(target: self, action: Selector("reFreshLocation:"))
        targetImage.addGestureRecognizer(tapGes)
    }
    
    func reFreshLocation(isNotNoti : Bool)
    {
        if(isNotNoti)
        {
            
        }
        else
        {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
        var userLocationCoor :CLLocationCoordinate2D? = ZXY_LocationRelative.sharedInstance.sendLocationToEveryBody()?.coordinate
        if(userLocationCoor != nil)
        {
            pageCount = 1
            self.setCurrentUserLocation(userLocation: userLocationCoor!)
            self.loadAtristSearch()
        }
    }
    // 定位用户位置坐标
    private func setCurrentUserLocation(userLocation location: CLLocationCoordinate2D) -> Void
    {
        
        var region : BMKCoordinateRegion = BMKCoordinateRegion(center: location, span: BMKCoordinateSpan(latitudeDelta: mapScale, longitudeDelta: mapScale))
        
        if(isMapSpanFirst)
        {
            region = BMKCoordinateRegion(center: location, span: BMKCoordinateSpan(latitudeDelta: mapScale, longitudeDelta: mapScale))
            isMapSpanFirst = false
        }
        searchMapView.setRegion(region, animated: false)
        searchMapView.setCenterCoordinate(location, animated: false)
        searchMapView.showsUserLocation = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //停止上拉下拉刷新
    private func endFreshing()
    {
        searchTableView.footerEndRefreshing()
        searchTableView.headerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforTable()
    {
        searchTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.pageCount++
            self?.loadAtristSearch()
            ""
        }
        
        searchTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
            self?.loadAtristSearch()
            ""
        }
    }
    
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
            userID = user_id
        }
        else
        {
            userID = ""
        }
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func rightBtnClick(sender: AnyObject) {
        if isMap {
            isMap = false
            searchMapView.hidden = true
            littleBoy.hidden = true
            targetImage.hidden = true
            searchTableView.hidden = false
            rightBtn.image = UIImage(named: "search_near_map")
            srW.startProgress(self.searchTableView)
            self.addHeaderAndFooterforTable()
            self.loadAtristSearch()
        }
        else
        {
            isMap = true
            searchMapView.hidden = false
            littleBoy.hidden = false
            targetImage.hidden = false
            searchTableView.hidden = true
            rightBtn.image = UIImage(named: "search_near_list")
        }
    }
    
    //搜索附近美甲师
    func loadAtristSearch(){
        var urlString = ZXY_NailNetAPI.SR_SearchAPI(SR_SearchAPIType.SR_SearchUser)
        userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var parameter : Dictionary<String ,  AnyObject> = ["city": userCityName! , "lng": longitude! , "lat": latitude!, "user_id" : userID! , "control" : control , "p" : pageCount]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var arr = SR_searchNearbyBaseClass(dictionary: returnDic).data
            if(self?.pageCount == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.searchTableView.reloadData()
            self?.endFreshing()
            if let s = self
            {
                s.srW.hideProgress(s.searchTableView)
                s.littleBoy.stopAnimating()
            }
            self?.isDownLoad = false
            self?.reloadCurrentTable()
        }) { [weak self](error) -> Void in
                println(error)
                if let s = self
                {
                    s.srW.hideProgress(s.searchTableView)
                    s.littleBoy.stopAnimating()
                }
                self?.isDownLoad = false
                self?.reloadCurrentTable()
        }
        
    }
    
    func reloadCurrentTable()
    {

        annos.removeAll(keepCapacity: false)
        for var i = 0; i < dataForShow.count ;i++
        {
            if(i <= 5)
            {
                var currentUser : SR_searchNearbyData = dataForShow[i] as! SR_searchNearbyData
                var coordinatee : CLLocationCoordinate2D?
                coordinatee = self.xYStringToCoor(currentUser.longitude, latitude: currentUser.latitude)
                if(coordinatee == nil)
                {
                    continue
                }
                var anno = SR_BMKAnnotation(location: coordinatee!)
                var imgUrl = currentUser.headImage as String?
                if let url = imgUrl {
                    if(imgUrl!.hasPrefix("http")) {
                    }
                    else {
                        imgUrl = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                    }
                }
                if(imgUrl != nil)
                {
                    var url: NSURL? = NSURL(string: imgUrl!)
                    anno.setImgURLs(url)
                }
                anno.setCoordinates(coordinatee!)
                anno.setUserIDs(currentUser.userId)
                annos.append(anno)
            }
        }
        searchMapView.removeAnnotations(searchMapView.annotations)
        searchMapView.addAnnotations(annos)
        
    }
    
    func distanceCompareCoor(artistPosition : CLLocationCoordinate2D? , userPosition : CLLocationCoordinate2D?) -> Double
    {
        if(artistPosition != nil && userPosition != nil)
        {
            var artistPot = BMKMapPointForCoordinate(artistPosition!)
            var userPot   = BMKMapPointForCoordinate(userPosition!)
            var distance  = BMKMetersBetweenMapPoints(artistPot, userPot)
            return distance/1000
        }
        else
        {
            return 0
        }
        
    }
    
    func  xYStringToCoor(longitude : String? , latitude: String?) -> CLLocationCoordinate2D?
    {
        if(longitude == nil || latitude == nil)
        {
            return nil
        }
        else
        {
            var logFloat = (longitude! as NSString).doubleValue
            var latFloat = (latitude!  as NSString).doubleValue
            return CLLocationCoordinate2DMake(latFloat, logFloat)
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

// MARK: - 地图与定位的相关代理
extension SR_searchNearbyVC :  BMKMapViewDelegate , BMKLocationServiceDelegate , BMKGeoCodeSearchDelegate
{
    // MARK: - MapViewDelegate
    func mapView(mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        littleBoy.image = UIImage(named: "search_location")
        targetImage.hidden = true
    }
    
    func mapView(mapView: BMKMapView!, viewForAnnotation annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if(annotation.isKindOfClass(SR_BMKAnnotation.self))
        {
            var annoView : SR_DAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier("zxy_Anno") as? SR_DAnnotationView
            if(annoView == nil)
            {
                annoView = SR_DAnnotationView(annotation: annotation, reuseIdentifier: "zxy_Anno")
            }
            else
            {
                annoView!.annotation = annotation
            }
            
            var zxyAnno : SR_BMKAnnotation = annotation as! SR_BMKAnnotation
            if(zxyAnno.imgURL != nil)
            {
                annoView?.titleImg.setImageWithURL(zxyAnno.imgURL!)
                
            }
            annoView?.userID = zxyAnno.userID
            return annoView
        }
        else
        {
            var annoView = mapView.dequeueReusableAnnotationViewWithIdentifier("zxy_Anno")
            if(annoView == nil)
            {
                annoView = SR_DAnnotationView(annotation: annotation, reuseIdentifier: "zxy_Anno")
            }
            else
            {
                annoView.annotation = annotation
            }
            
            return annoView
            
        }
    }
    
    func mapView(mapView: BMKMapView!, didSelectAnnotationView view: BMKAnnotationView!) {
        if(view.isKindOfClass(SR_DAnnotationView.self))
        {
            var annoView = view as! SR_DAnnotationView
            var story  = UIStoryboard(name: "PublicStory", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as! ZXY_DFPArtistDetailVC
            if(annoView.userID != nil)
            {
                vc.artistID = annoView.userID!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                return
            }
            
        }
    }
    
    func mapView(mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        if(isDownLoad)
        {
            return
        }
        self.startInitLittleBoy()
        targetImage.hidden = false
        var currentTimeStamp = NSDate().timeIntervalSince1970
        littleBoy.startAnimating()
        self.loadAtristSearch()
        if(targetImage.hidden)
        {
            targetImage.hidden = false
            littleBoy.image = UIImage(named: "search_personCenter")
        }
    }
    
}


extension SR_searchNearbyVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForShow.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_searchUserCell.cellID()) as! SR_searchUserCell
        cell.toolBar.backgroundColor = UIColor.NailRedColor()
        var cellData = dataForShow[indexPath.row] as! SR_searchNearbyData
        //美甲师头像
        var imgUrl    = cellData.headImage as String?
        if let url    = imgUrl
        {
            if (imgUrl!.hasPrefix("http"))
            {
                cell.headImgView.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                cell.headImgView.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
            }
        }
        
        //美甲师姓名
        
        cell.nickName.text = cellData.nickName
        
        //作品数量
        cell.userWorkCount.text = cellData.albumCount
        
        
        //用户与美甲师距离
        var userPosition = ZXY_LocationRelative.sharedInstance.xYStringToCoor("\(longitude!)" , latitude: "\(latitude!)")
        var lng = cellData.longitude
        var lat = cellData.latitude
        var artistPosition = ZXY_LocationRelative.sharedInstance.xYStringToCoor(lng, latitude: lat)
        var distance = ZXY_LocationRelative.distanceCompareCoor(artistPosition, userPosition: userPosition)
        cell.userDistance.text = "\(Double(round(100 * distance)/100)) km"
        
        //评价等级
        var scoreNSString : NSString = NSString(format: "%@", cellData.score)
        var doubleScore   = scoreNSString.doubleValue
        cell.starRateView?.scorePercent = CGFloat(doubleScore/5.0)
        
        //判断用户身份
        var type = cellData.role
        if type == "1" {
            cell.toolBar.hidden = true
            cell.isArtistLabel.hidden = true
            cell.userV.hidden = true
        }
        else
        {
            cell.toolBar.hidden = false
            cell.isArtistLabel.hidden = false
            //认证
            if let pass = cellData.isPass
            {
                if pass == "0"
                {
                    cell.userV.hidden = true
                }
                else
                {
                    cell.userV.hidden = false
                }
            }
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var detailArtist = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as! ZXY_DFPArtistDetailVC
        var CellData = dataForShow[indexPath.row] as! SR_searchNearbyData
        detailArtist.artistID = CellData.userId
        self.navigationController?.pushViewController(detailArtist, animated: true)
    }
}
