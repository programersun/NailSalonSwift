//
//  SR_ChangeAddressVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/15.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
import MapKit

protocol SR_ChangeAddressVCProtocol : class
{
    func addressChange(sendKey: String, andValue sendValue: String)
}

class SR_ChangeAddressVC: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var rightBtn: UIBarButtonItem!
    
    weak var delegate : SR_ChangeAddressVCProtocol?
    
    
    var searchArray : NSMutableArray? = NSMutableArray()
    
    var dataForShow : [AnyObject]?
    
    //用户坐标
    var userCityName : String?
    var searcher = BMKPoiSearch()
    var pageIndex : Int32 = 0       //搜索到得地址当前页
    var pageCount : Int32 = 0       //页数
    
    var isFirstSearch : Bool = true //是否是第一个进入，第一次搜索本地数据库数据，否则从百度获取
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor" )
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        searchText.becomeFirstResponder()
        self.getUserInfo()
        
        dataForShow = ZXY_DataProviderHelper.readAllFromDB(DNName: "CommenAddress")
        self.searchTableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        searcher.delegate = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //停止上拉下拉刷新
    private func endFreshing()
    {
        searchTableView.footerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforTable()
    {
        searchTableView.addFooterWithCallback { [weak self] () -> Void in
            self?.pageIndex++
            self?.loadSearchAddress()
            ""
        }
    }
    
    //获取用户所在城市名称
    func getUserInfo(){
        userCityName =  ZXY_UserInfoDetail.sharedInstance.getUserCityName()
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
    
    @IBAction func letfBtnClick(sender: AnyObject) {
        searchText.becomeFirstResponder()
    }
    
    @IBAction func rightBtnClick(sender: AnyObject) {
        searchText.resignFirstResponder()
        if searchIsEmpty() == false {
            self.delegate?.addressChange("userAddr", andValue: self.searchText.text)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func editSearch(sender: AnyObject) {
        println("\(searchText.text)")
        if searchIsEmpty() {
            rightBtn.title = "取消"
        }
        else
        {
            rightBtn.title = "确定"
        }
    }
    
    @IBAction func searchAddress(sender: AnyObject) {
        if searchIsEmpty() == false {
            self.isFirstSearch = false
            self.searchArray?.removeAllObjects()
            self.loadSearchAddress()
        }
    }
    
    func loadSearchAddress() {
        self.addHeaderAndFooterforTable()
        searcher.delegate = self
        var option = BMKCitySearchOption()
        option.pageIndex = self.pageIndex
        option.pageCapacity = 15
        option.city = self.userCityName ?? ""
        option.keyword  = self.searchText.text as String
        var flag : Bool = searcher.poiSearchInCity(option)
        if flag {
            println("success")
        }
        else {
            println("fail")
        }
        
    }
    
    
    func loadCommonAddress()
    {
        
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

extension SR_ChangeAddressVC : UITableViewDataSource, UITableViewDelegate , BMKPoiSearchDelegate {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFirstSearch {
            return dataForShow?.count ?? 0
        }
        else {
            return self.searchArray?.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_ChangeAddressCell.cellID()) as! SR_ChangeAddressCell
        if self.isFirstSearch {
            var currentData = dataForShow?[indexPath.row] as! CommenAddress
            cell.addressLabel.text = currentData.name
            cell.detailAddressLabel.text = currentData.address
            cell.searchImg.image = UIImage(named: "searchItemD")
        }
        else {
            cell.addressLabel.text = self.searchArray?[indexPath.row].name ?? ""
            cell.detailAddressLabel.text = self.searchArray?[indexPath.row].address ?? ""
            cell.searchImg.image = UIImage(named: "searchItemD")
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell              = tableView.cellForRowAtIndexPath(indexPath) as! SR_ChangeAddressCell
        var name : String!    = cell.addressLabel.text
        var address : String! =  cell.detailAddressLabel.text
        var nameAndAddress    = "\(name)(\(address))"
        println("\(nameAndAddress)")
        self.delegate?.addressChange("userAddr", andValue: nameAndAddress)
        
        if self.isFirstSearch {
        }
        else {
//            var currentData = dataForShow?[indexPath.row] as! CommenAddress
//            var dic : Dictionary<String , AnyObject?> =
//            [   "name" : self.searchArray?[indexPath.row].name ?? "" ,
//                "address" : self.searchArray?[indexPath.row].address ?? "",
//                "uid" : self.searchArray?[indexPath.row].uid ?? "",
//                "city" : self.searchArray?[indexPath.row].city ?? "",
//                "phone" : self.searchArray?[indexPath.row].phone ?? "",
//                "postcode" : self.searchArray?[indexPath.row].postcode ?? "",
//                "epoitype" : self.searchArray?[indexPath.row].epoitype ?? 0
//            ]
            
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    func onGetPoiResult(searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        if errorCode.value == BMK_SEARCH_NO_ERROR.value {
            self.searchArray?.addObjectsFromArray(poiResult.poiInfoList)
//            self.searchArray?.addObject(poiResult.poiInfoList)
            self.pageCount = self.pageCount + poiResult.currPoiNum
            self.searchTableView.reloadData()
            self.endFreshing()
            println("\(poiResult.totalPoiNum)")
        }
        else {
            if errorCode.value == BMK_SEARCH_AMBIGUOUS_KEYWORD.value {
                println("起始点有歧义")
            }
            else {
                println("抱歉，未找到结果")
            }
        }
    }
}

