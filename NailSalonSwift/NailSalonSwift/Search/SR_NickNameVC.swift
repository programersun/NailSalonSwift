//
//  SR_NickNameVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_NickNameVC: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var rightBtn: UIBarButtonItem!
    
    var userCoordinate : Dictionary<String, Double?>?
    var userCityName : String?
    var latitude : Double?
    var longitude : Double?
    var userID : String!
    var searchString : String?
    var pageCount : Int = 1
    var dataForShow : NSMutableArray = NSMutableArray()
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor" )
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        searchText.becomeFirstResponder()
        self.getUserInfo()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func letfBtnClick(sender: AnyObject) {
        searchText.becomeFirstResponder()
    }
    
    @IBAction func rightBtnClick(sender: AnyObject) {
        searchText.resignFirstResponder()
        if searchIsEmpty() {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        else
        {
            srW.startProgress(self.searchTableView)
            self.loadAtristSearch()
        }
    }
    
    @IBAction func editSearch(sender: AnyObject) {
        println("\(searchText.text)")
        searchString = searchText.text as String?
        if searchIsEmpty() {
            rightBtn.title = "取消"
        }
        else
        {
            self.addHeaderAndFooterforTable()
            srW.startProgress(self.searchTableView)
            rightBtn.title = "搜索"
            self.loadAtristSearch()
        }
    }

    /**
    判断文本框的内容是否有值
    若为空rightBtn为取消
    若不为空rightBtn为搜索
    **/
    func searchIsEmpty() -> Bool{
        var nowSrting = searchText.text
        if nowSrting == ""{
            return true
        }
        else {
            return false
        }
    }
    
    //搜索美甲师
    func loadAtristSearch(){
        var urlString = ZXY_NailNetAPI.SR_SearchAPI(SR_SearchAPIType.SR_SearchUser)
        userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        searchString = searchText.text as String!
        println("\(searchString)+++")
        var parameter : Dictionary<String ,  AnyObject> = ["city": userCityName! , "lng": longitude! , "lat": latitude!, "user_id" : userID! , "nick_name" : searchString!, "p" : pageCount]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var arr = SR_searchUserBaseClass(dictionary: returnDic).data
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
            }
            }) { [weak self](error) -> Void in
                println(error)
                if let s = self
                {
                    s.srW.hideProgress(s.searchTableView)
                }
                self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
                ""
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
extension SR_NickNameVC : UITableViewDataSource, UITableViewDelegate {
    
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
        var cellData = dataForShow[indexPath.row] as! SR_searchUserData
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
        self.searchText.resignFirstResponder()
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var detailArtist = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as! ZXY_DFPArtistDetailVC
        var CellData = dataForShow[indexPath.row] as! SR_searchUserData
        detailArtist.artistID = CellData.userId
        self.navigationController?.pushViewController(detailArtist, animated: true)
    }
}

