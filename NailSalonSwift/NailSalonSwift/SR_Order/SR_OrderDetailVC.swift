
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
    
    var dataForShow : SR_OrderDetailBaseClass?
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    //当前用户信息
    var userInfo : ZXY_UserDetailInfoData!
    private var userData : ZXY_UserDetailInfoUserDetailBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topView.backgroundColor = UIColor.NailRedColor()
        self.navigationController?.navigationBar.hidden = true
        userCancel.hidden = true
        orderRefuse.hidden = true
        orderAccept.hidden = true
        self.getUserInfo()
        srW.startProgress(self.view)
        self.loadOrderDetail()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
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
            
            /**
            订单状态
            1：发出订单
            2：用户取消订单
            3：美甲师拒绝订单
            4：美甲师接受订单
            5：美甲师取消订单
            6：用户取消订单（美甲师接受订单后）
            7：交易完成
            8：用户删除订单（隐藏）
            9：美甲师删除订单（隐藏）
            **/
            switch dataForShow!.data.orderStatus {
            case "1":
                userCancel.hidden = false
                userCancel.setTitle("取消订单", forState: UIControlState.Normal)
                orderRefuse.hidden = true
                orderAccept.hidden = true
            case "4":
                userCancel.hidden = true
                orderRefuse.hidden = false
                orderRefuse.setTitle("取消订单", forState: UIControlState.Normal)
                orderAccept.hidden = false
                orderAccept.setTitle("完成订单", forState: UIControlState.Normal)
            case "7":
                userCancel.hidden = false
                userCancel.setTitle("填写评价", forState: UIControlState.Normal)
                orderRefuse.hidden = true
                orderAccept.hidden = true
            default:
                userCancel.hidden = true
                orderRefuse.hidden = true
                orderAccept.hidden = true
            }
        case "2":
            switch dataForShow!.data.orderStatus {
            case "1":
                userCancel.hidden = true
                orderRefuse.hidden = false
                orderRefuse.setTitle("拒绝订单", forState: UIControlState.Normal)
                orderAccept.hidden = false
                orderAccept.setTitle("接受订单", forState: UIControlState.Normal)
            case "4":
                userCancel.hidden = false
                userCancel.setTitle("取消订单", forState: UIControlState.Normal)
                orderRefuse.hidden = true
                orderAccept.hidden = true
            case "7":
                userCancel.hidden = false
                userCancel.setTitle("填写评价", forState: UIControlState.Normal)
                orderRefuse.hidden = true
                orderAccept.hidden = true
            default:
                userCancel.hidden = true
                orderRefuse.hidden = true
                orderAccept.hidden = true
            }
        default:
            ""
        }
    }
    
    //加载订单详情数据
    func loadOrderDetail() {
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_OrderDetail)
        var parameter : Dictionary<String ,  AnyObject> = ["order_id": self.orderID!]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.dataForShow = SR_OrderDetailBaseClass(dictionary: returnDic)
            var result = self?.dataForShow?.result ?? 0
            if result == 1000 {
                self?.userRole()
                self?.orderDetailTableView.reloadData()
            }
            else
            {
                var errorMessage = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: errorMessage)
            }
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
        }) { [weak self](error) -> Void in
            println(error)
            self?.userCancel.hidden = true
            self?.orderRefuse.hidden = true
            self?.orderAccept.hidden = true
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
    
    func changeOrderStatus(nextStatus : String) {
        srW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_ChangeOrderStatus)
        var parameter : Dictionary<String ,  AnyObject> = ["status": nextStatus ,"role": self.userInfo.role! ,"user_id" : self.userId!, "order_id": self.orderID!]
        println("\(parameter)")
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var result : Double = returnDic["result"] as! Double
            if result == 1000 {
                self?.loadOrderDetail()
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: errorString)
            }

        }, failBlock: { [weak self](error) -> Void in
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            ""
        })
    }
    //取消订单or完成评价
    @IBAction func userCancelBtnClick(sender: AnyObject) {
        switch dataForShow!.data.orderStatus {
        case "1":
            self.changeOrderStatus("2")
        case "4":
            self.changeOrderStatus("5")
        case "7":
            ""
        default:
            ""
        }
    }
    
    //美甲师拒绝订单or美甲师接受后用户取消订单
    @IBAction func orderRefuseBtnClick(sender: AnyObject) {
        switch dataForShow!.data.orderStatus {
        case "1":
            self.changeOrderStatus("3")
        case "4":
            self.changeOrderStatus("6")
        default:
            ""
        }
    }
    
    //美甲师接受or美甲师接受后用户完成订单
    @IBAction func orderAcceptBtnClick(sender: AnyObject) {
        switch dataForShow!.data.orderStatus {
        case "1":
            self.changeOrderStatus("4")
        case "4":
            self.changeOrderStatus("7")
        default:
            ""
        }
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
        if dataForShow == nil {
            return 0
        }
        else {
            return 4
        }
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
            //美甲师头像
            var imgUrl : String?
            if self.userInfo.role == "1" {
                imgUrl = dataForShow?.data.user.headImage
                firstCell.nickName.text = dataForShow?.data.user.nickName
            }
            else {
                imgUrl = dataForShow?.data.custom.headImage
                firstCell.nickName.text = dataForShow?.data.custom.nickName
            }
            if let url = imgUrl
            {
                if (imgUrl!.hasPrefix("http"))
                {
                    firstCell.headImg.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
                }
                else
                {
                    var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                    firstCell.headImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
                }
            }

            /**
            订单状态
            1：发出订单
            2：用户取消订单
            3：美甲师拒绝订单
            4：美甲师接受订单
            5：美甲师取消订单
            6：用户取消订单（美甲师接受订单后）
            7：交易完成
            8：用户删除订单（隐藏）
            9：美甲师删除订单（隐藏）
            **/

            switch dataForShow!.data.orderStatus {
            case "1" :
                firstCell.orderStatus.text = "待接受"
                firstCell.orderStatus.textColor = UIColor.NailGrayColor()
            case "2":
                firstCell.orderStatus.text = "顾客取消"
                firstCell.orderStatus.textColor = UIColor.NailRedColor()
            case "3" :
                firstCell.orderStatus.text = "美甲师拒绝"
                firstCell.orderStatus.textColor = UIColor.NailRedColor()
            case "4":
                firstCell.orderStatus.text = "美甲师接受"
                firstCell.orderStatus.textColor = UIColor.NailGrayColor()
            case "5":
                firstCell.orderStatus.text = "美甲师取消"
                firstCell.orderStatus.textColor = UIColor.NailRedColor()
            case "6":
                firstCell.orderStatus.text = "顾客取消"
                firstCell.orderStatus.textColor = UIColor.NailRedColor()
            case "7":
                firstCell.orderStatus.text = "已完成"
                firstCell.orderStatus.textColor = UIColor.NailRedColor()
            default:
                switch dataForShow!.data.preStatus {
                case "1" :
                    firstCell.orderStatus.text = "待接受"
                    firstCell.orderStatus.textColor = UIColor.NailGrayColor()
                case "2":
                    firstCell.orderStatus.text = "顾客取消"
                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
                case "3" :
                    firstCell.orderStatus.text = "美甲师拒绝"
                    firstCell.orderStatus.textColor = UIColor.NailRedColor()

                case "4":
                    firstCell.orderStatus.text = "美甲师接受"
                    firstCell.orderStatus.textColor = UIColor.NailGrayColor()

                case "5":
                    firstCell.orderStatus.text = "美甲师取消"
                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
                case "6":
                    firstCell.orderStatus.text = "顾客取消"
                    firstCell.orderStatus.textColor = UIColor.NailGrayColor()
                case "7":
                    firstCell.orderStatus.text = "已完成"
                    firstCell.orderStatus.textColor = UIColor.NailRedColor()
                default:
                    ""
                }
            }
            firstCell.delegate = self
            return firstCell
        case 1:
            //预约时间
            secondCell.titleLabel.text = "预约时间："
            var timeString = dataForShow?.data.orderTime as String!
            secondCell.orderTimeOrAddress.text = timeStampToDateString(timeString)
            return secondCell
        case 2:
            secondCell.titleLabel.text = "预约地点："
            //预约地址
            if (dataForShow?.data.detailAddr == "null") {
                secondCell.orderTimeOrAddress.text = "待定"
            }
            else {
                secondCell.orderTimeOrAddress.text = dataForShow?.data.detailAddr
                
            }
            return secondCell
        case 3:
            //预约主题
            if (dataForShow?.data.albumDesc != nil) {
                thirdCell.orderAblum.text = dataForShow?.data.albumDesc
            }
            else {
                thirdCell.orderAblum.text = "待定"
            }
            return thirdCell
        default:
            return firstCell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3 {
            var story = UIStoryboard(name: "PublicStory", bundle: nil)
            var vc    = story.instantiateViewControllerWithIdentifier("artDetailID") as! ZXY_DFPArtDetailVC
            vc.artWorkID = dataForShow?.data.albumId
            vc.title     = "美甲室"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SR_OrderDetailVC : SR_OrderDetailFirstCellProtocol {
    
    //点击头像跳转到用户详细信息
    func clickHeadImg() {
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var detailArtist = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as!ZXY_DFPArtistDetailVC
        detailArtist.artistID = dataForShow?.data.userId
        self.navigationController?.pushViewController(detailArtist, animated: true)
    }
    
    //发送消息
    func clickMessage() {
        
    }
    
    //拨打电话
    func clickTel() {
        
    }
}
