//
//  SR_OrderMainVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/30.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderMainVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var orderTableView: UITableView!
    
    /**
    订单页面
    1用户信息在本页面获取 : getUserInfo()
    2.如果从美甲师详细信息页面预约，需传递美甲师id
    3.如果从图集详细页面预约，需传递图集id和描述、美甲师id
    
    **/
    var userId : String?
    var artistId : String?
    var userName : String?
    var orderTel : String?
    var orderTime : String? = ""
    var userAddress : String? = ""
    var ablumName : String?
    var ablumId : String?
    
    //当前用户信息
    var userInfo : ZXY_UserDetailInfoData!
    private var userData : ZXY_UserDetailInfoUserDetailBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.backgroundColor = UIColor.NailRedColor()
        self.getUserInfo()
        self.navigationController?.navigationBar.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //获取当前用户的信息
    func getUserInfo() {
        self.userId = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
        if let user = userInfoDic {
            self.userData = ZXY_UserDetailInfoUserDetailBase(dictionary: user)
            self.userInfo = self.userData?.data
        }
    }

    func startSubmit() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //提交订单
    @IBAction func submitOrder(sender: AnyObject) {
        
    }

}
extension SR_OrderMainVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if UIDevice.isRunningOniPhone4s()
        {
            return 50
        }
        else
        {
            return 62
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_OrderMainVCCell.cellID()) as SR_OrderMainVCCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "顾客姓名"
            if let userNameString = self.userName {
                cell.insertLabel.text = userNameString
            }
            else {
                cell.insertLabel.text = userInfo.nickName
            }
            
        case 1:
            cell.titleLabel.text = "顾客电话"
            if let telString = self.orderTel {
                cell.insertLabel.text = telString
            }
            else {
                cell.insertLabel.text = userInfo.tel
            }
            
        case 2:
            cell.titleLabel.text = "预约时间"
            cell.insertLabel.text = self.orderTime
            
        case 3:
            cell.titleLabel.text = "预约地点"
            if  self.userAddress == "" {
                cell.insertLabel.text = userInfo.address
            }
            else {
                cell.insertLabel.text = self.userAddress
            }

        case 4:
            cell.titleLabel.text = "预约主题"
            if let ablumString = self.ablumName {
                cell.insertLabel.text = ablumString
            }
            else {
                cell.insertLabel.text = ""
            }
            
        default:
            ""
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            ""
        case 1:
            ""
        case 2:
//            var alert = UIAlertView()
//            alert.title    = "选择时间"
//            var datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.frame.size.width * 0.8, 200))
//            datePicker.datePickerMode = UIDatePickerMode.DateAndTime
//            alert.addSubview(datePicker)
//            alert.addButtonWithTitle("取消")
//            alert.addButtonWithTitle("确定")
//            alert.delegate = self
//            alert.show()
            ""

        case 3:
            ""
        case 4:
            var story = UIStoryboard(name: "SR_MIMainStory", bundle: nil)
            var vc = story.instantiateViewControllerWithIdentifier("SR_myAlbumVCID") as SR_myAlbumVC
            vc.userID = userId!
            vc.artistID = artistId!
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            ""
        }
    }
}

extension SR_OrderMainVC : SR_myAlbumVCProtocol , UIAlertViewDelegate {
    //选择主题样式返回值
    func backToOrder(ablumDesc: String, ablumId: String?) {
        self.ablumName = ablumDesc
        self.ablumId = ablumId
        self.orderTableView.reloadData()
    }
    
    //编辑时间
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            
        }
    }
}
