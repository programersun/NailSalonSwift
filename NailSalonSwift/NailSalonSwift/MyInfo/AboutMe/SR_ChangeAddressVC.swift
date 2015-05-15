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
    
    //plist 文件名和数据
    var filename : String?
    var data = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor" )
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        searchText.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
    }
    
    func searchAddress() {
        var searcher = BMKPoiSearch()
        searcher.delegate = self
        var option = BMKNearbySearchOption()
    }
    
    
    func loadCommonAddress()
    {
        var paths     = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var plistPath = paths[0] as! String
        self.filename = plistPath.stringByAppendingPathComponent("address")
        self.data     = NSMutableArray(contentsOfFile: filename!)!
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

extension SR_ChangeAddressVC : UITableViewDataSource, UITableViewDelegate , BMKPoiSearchDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if self.data.count == 0 {
            return 10
//        }
//        else {
//            return self.data.count
//        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_ChangeAddressCell.cellID()) as! SR_ChangeAddressCell
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func onGetPoiDetailResult(searcher: BMKPoiSearch!, result poiDetailResult: BMKPoiDetailResult!, errorCode: BMKSearchErrorCode) {
        
    }
}

