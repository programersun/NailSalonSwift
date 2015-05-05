
//
//  SR_OrderDetailVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/5.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderDetailVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var orderDetailTableView: UITableView!
    
    @IBOutlet weak var userCancel: UIButton!
    @IBOutlet weak var orderRefuse: UIButton!
    @IBOutlet weak var orderAccept: UIButton!
    
    var orderID : String?
    var userId : String?
    
    var dataForShow : SR_OrderDetailData?
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    //当前用户信息
    var userInfo : ZXY_UserDetailInfoData!
    private var userData : ZXY_UserDetailInfoUserDetailBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.backgroundColor = UIColor.NailRedColor()
        self.getUserInfo()
        self.userRole()
        self.loadOrderDetail()
//        srW.startProgress(self.view)
        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //判断用户身份：普通用户取消订单，美甲师拒绝和接受订单
    //修改按钮边框
    func userRole(){
        userCancel.layer.masksToBounds = true
        userCancel.layer.borderColor  = UIColor.NailGrayColor().CGColor
        userCancel.layer.borderWidth  = 0.5
        orderRefuse.layer.masksToBounds = true
        orderRefuse.layer.borderColor  = UIColor.NailGrayColor().CGColor
        orderRefuse.layer.borderWidth  = 0.5
        orderAccept.layer.masksToBounds = true
        orderAccept.layer.borderColor  = UIColor.NailGrayColor().CGColor
        orderAccept.layer.borderWidth  = 0.5
        switch self.userInfo.role {
        case "1":
            userCancel.hidden = false
            orderRefuse.hidden = true
            orderAccept.hidden = true
        case "2":
            userCancel.hidden = true
            orderRefuse.hidden = false
            orderAccept.hidden = false
        default:
            ""
        }
    }
    
    //加载订单详情数据
    func loadOrderDetail() {
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_OrderDetail)
        var parameter : Dictionary<String ,  AnyObject> = ["order_id": self.orderID!]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.dataForShow = SR_OrderDetailBaseClass(dictionary: returnDic).data
            println("hello")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func userCancelBtnClick(sender: AnyObject) {
        
    }
    
    @IBAction func orderRefuseBtnClick(sender: AnyObject) {
        
    }
    
    @IBAction func orderAcceptBtnClick(sender: AnyObject) {
        
    }

    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
extension SR_OrderDetailVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 125
        }
        else {
            return 50
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var firstCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailFirstCell.cellID()) as! SR_OrderDetailFirstCell
        var secondCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailSecondCell.cellID()) as! SR_OrderDetailSecondCell
        var thirdCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailThirdCell.cellID()) as! SR_OrderDetailThirdCell
        switch indexPath.row {
        case 0:
//            //美甲师头像
//            firstCell.headImg.layer.cornerRadius = CGRectGetWidth(firstCell.headImg.bounds) / 2
//            firstCell.headImg.layer.masksToBounds = true
//            firstCell.headImg.layer.borderColor  = UIColor.NailRedColor().CGColor
//            firstCell.headImg.layer.borderWidth  = 1
//            var imgUrl : String?
//            if self.userInfo.role == "1" {
//                imgUrl = dataForShow?.user.headImage
//                firstCell.nickName.text = dataForShow?.user.nickName
//            }
//            else {
//                imgUrl = dataForShow?.custom.headImage
//                firstCell.nickName.text = dataForShow?.custom.nickName
//            }
//            if let url    = imgUrl
//            {
//                if (imgUrl!.hasPrefix("http"))
//                {
//                    firstCell.headImg.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
//                }
//                else
//                {
//                    var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
//                    firstCell.headImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
//                }
//            }
//            
//            /**
//            订单状态
//            1：发出订单
//            2：用户取消订单
//            3：美甲师拒绝订单
//            4：美甲师接受订单
//            5：美甲师取消订单
//            6：用户取消订单（美甲师接受订单后）
//            7：交易完成
//            8：用户删除订单（隐藏）
//            9：美甲师删除订单（隐藏）
//            **/
//            var statusString = dataForShow?.orderStatus as String!
//            var perString = dataForShow?.preStatus as String!
//            switch statusString {
//            case "1" :
//                firstCell.orderStatus.text = "待接受"
//                firstCell.orderStatus.textColor = UIColor.NailGrayColor()
//            case "2":
//                firstCell.orderStatus.text = "顾客取消"
//                firstCell.orderStatus.textColor = UIColor.NailRedColor()
//            case "3" :
//                firstCell.orderStatus.text = "美甲师拒绝"
//                firstCell.orderStatus.textColor = UIColor.NailRedColor()
//            case "4":
//                firstCell.orderStatus.text = "美甲师接受"
//                firstCell.orderStatus.textColor = UIColor.NailGrayColor()
//            case "5":
//                firstCell.orderStatus.text = "美甲师取消"
//                firstCell.orderStatus.textColor = UIColor.NailRedColor()
//            case "6":
//                firstCell.orderStatus.text = "顾客取消"
//                firstCell.orderStatus.textColor = UIColor.NailRedColor()
//            case "7":
//                firstCell.orderStatus.text = "交易完成"
//                firstCell.orderStatus.textColor = UIColor.NailRedColor()
//            default:
//                switch perString {
//                case "1" :
//                    firstCell.orderStatus.text = "待接受"
//                    firstCell.orderStatus.textColor = UIColor.NailGrayColor()
//                case "2":
//                    firstCell.orderStatus.text = "顾客取消"
//                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
//                case "3" :
//                    firstCell.orderStatus.text = "美甲师拒绝"
//                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
//
//                case "4":
//                    firstCell.orderStatus.text = "美甲师接受"
//                    firstCell.orderStatus.textColor = UIColor.NailGrayColor()
//
//                case "5":
//                    firstCell.orderStatus.text = "美甲师取消"
//                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
//                case "6":
//                    firstCell.orderStatus.text = "顾客取消"
//                    firstCell.orderStatus.textColor = UIColor.NailGrayColor()
//                case "7":
//                    firstCell.orderStatus.text = "交易完成"
//                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
//                default:
//                    ""
//                }
//            }

            return firstCell
        case 1:
            //预约时间
            secondCell.titleLabel.text = "预约时间："
//            var timeString = dataForShow?.orderTime as String!
//            secondCell.orderTimeOrAddress.text = timeStampToDateString(timeString)
            return secondCell
        case 2:
            secondCell.titleLabel.text = "预约地点："
//            //预约地址
//            if (dataForShow?.detailAddr == "null") {
//                secondCell.orderTimeOrAddress.text = "待定"
//            }
//            else {
//                secondCell.orderTimeOrAddress.text = dataForShow?.detailAddr
//                
//            }
            return secondCell
        case 3:
            //预约主题
//            if (dataForShow?.albumDesc != nil) {
//                thirdCell.orderAblum.text = dataForShow?.albumDesc
//            }
//            else {
//                thirdCell.orderAblum.text = "待定"
//            }
            return thirdCell
        default:
            return firstCell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
