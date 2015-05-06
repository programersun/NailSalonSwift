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
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    /**
    订单页面
    1用户信息在本页面获取 : getUserInfo()
    2.如果从美甲师详细信息页面预约，需传递美甲师id和orderType = 0
    3.如果从图集详细页面预约，需传递图集id和描述、美甲师id 和orderType = 1
    **/
    var userId : String?
    var artistId : String?
    var userName : String?
    var orderTel : String?
    var orderTime : String? = ""
    var userAddress : String?
    var ablumName : String?
    var ablumId : String?
    var artistName : String?
    var orderType : Int?
    
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
    
    override func viewWillAppear(animated: Bool) {
        self.orderTableView.reloadData()
        self.navigationController?.navigationBar.hidden = true
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
            self.userName = self.userInfo.nickName
            if let telString = self.userInfo.tel {
                self.orderTel = telString
            }
            else {
                self.orderTel = "null"
            }
            if  self.userInfo.address != "null" {
                self.userAddress = self.userInfo.address
            }
            else {
                self.userAddress = "待定"
            }

        }
    }

    func startSubmit() {
        srW.startProgress(self.view)
        
        /**
        orderTime要转换成时间戳
        **/
        self.orderTime = "1430819820"
        
        
        if self.orderTime == "" {
            self.showAlertEasy("提示", messageContent: "预约时间不能为空")
        }
        else {
            var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_OrderAdd)
            var parameter : Dictionary<String ,  AnyObject> = ["user_id": self.artistId! , "custom_id" : self.userId!,"real_name" : self.userName!,"sex": self.userInfo.sex! ,"order_time": self.orderTime! ,"tel": self.orderTel! , "detail_addr": self.userAddress! ,"album_id": self.ablumId! ,"ablum_desc": self.ablumName!]
            println("\(parameter)")
            ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
                var story = UIStoryboard(name: "SR_OrderStory", bundle: nil)
                var vc = story.instantiateViewControllerWithIdentifier("SR_OrderTableVCID") as! SR_OrderTableVC
                vc.userID    = self?.userId
                vc.role      = self?.userInfo.role
                vc.artistID  = self?.artistId
                vc.ablumId   = self?.ablumId
                vc.orderType = self?.orderType
                self?.navigationController?.pushViewController(vc, animated: true)
            }, failBlock: { [weak self](error) -> Void in
                println(error)
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
                self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
                ""
            })
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
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //提交订单
    @IBAction func submitOrder(sender: AnyObject) {
        self.startSubmit()
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
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_OrderMainVCCell.cellID()) as! SR_OrderMainVCCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "顾客姓名"
            cell.insertLabel.text = self.userName
        case 1:
            cell.titleLabel.text = "顾客电话"
            cell.insertLabel.text = self.orderTel
        case 2:
            cell.titleLabel.text = "预约时间"
            cell.insertLabel.text = self.orderTime
            
        case 3:
            cell.titleLabel.text = "预约地点"
            cell.insertLabel.text = self.userAddress
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
            var story = UIStoryboard(name: "SR_OrderStory", bundle: nil)
            var vc = story.instantiateViewControllerWithIdentifier("SR_ChangeOrderInfoID") as! SR_ChangeOrderInfo
            if let userNameString = self.userName {
                 vc.changeInfo = userNameString
            }
            else {
                 vc.changeInfo = userInfo.nickName
            }
            vc.changeType = 0
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            var story = UIStoryboard(name: "SR_OrderStory", bundle: nil)
            var vc = story.instantiateViewControllerWithIdentifier("SR_ChangeOrderInfoID") as! SR_ChangeOrderInfo
            if let telString = self.orderTel {
                vc.changeInfo = telString
            }
            else {
                vc.changeInfo = userInfo.tel
            }
            vc.changeType = 1
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            ""
        case 3:
            var story = UIStoryboard(name: "SR_OrderStory", bundle: nil)
            var vc = story.instantiateViewControllerWithIdentifier("SR_ChangeOrderInfoID") as! SR_ChangeOrderInfo
            vc.changeInfo = self.userAddress
            vc.changeType = 2
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            var story = UIStoryboard(name: "SR_MIMainStory", bundle: nil)
            var vc = story.instantiateViewControllerWithIdentifier("SR_myAlbumVCID") as! SR_myAlbumVC
            vc.userID = userId!
            vc.artistID = artistId!
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            ""
        }
    }
}

extension SR_OrderMainVC : SR_myAlbumVCProtocol ,SR_ChangeOrderInfoProtocol  {
    //选择主题样式返回值
    func backToOrder(ablumDesc: String, ablumId: String?) {
        self.ablumName = ablumDesc
        self.ablumId = ablumId
        self.orderTableView.reloadData()
    }
    
    //修改订单信息的代理
    func changeNickName(nickName: String) {
        self.userName = nickName
    }
    func changeTel(tel: String) {
        self.orderTel = tel
    }
    func changeAddress(address: String) {
        self.userAddress = address
    }
}
