//
//  SR_searchNearbyVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/29.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_searchNearbyVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchMapView: BMKMapView!
    @IBOutlet weak var rightBtn: UIBarButtonItem!
    
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
        // Do any additional setup after loading the view.
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
//            self?.loadAtristSearch()
            ""
        }
        
        searchTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
//            self?.loadAtristSearch()
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
            srW.startProgress(self.searchTableView)
            self.addHeaderAndFooterforTable()
            
        }
        else
        {
            isMap = true
        }
    }
    
    //搜索附近美甲师
    func loadAtristSearch(){
        var urlString = ZXY_NailNetAPI.SR_SearchAPI(SR_SearchAPIType.SR_SearchUser)
        userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var parameter : Dictionary<String ,  AnyObject> = ["city": userCityName! , "lng": longitude! , "lat": latitude!, "user_id" : userID! , "control" : control , "p" : pageCount]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
//            var arr = SR_searchUserBaseClass(dictionary: returnDic).data
//            if(self?.pageCount == 1)
//            {
//                self?.dataForShow.removeAllObjects()
//                self?.dataForShow.addObjectsFromArray(arr)
//            }
//            else
//            {
//                self?.dataForShow.addObjectsFromArray(arr)
//            }
//            self?.searchTableView.reloadData()
//            self?.endFreshing()
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
