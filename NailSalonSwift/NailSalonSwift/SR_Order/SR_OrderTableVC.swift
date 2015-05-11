//
//  SR_OrderTableVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderTableVC: UIViewController {
    
    @IBOutlet weak var orderListTableView: UITableView!

    var artistID : String?
    var userID : String?
    var role : String!
    var pageCount : Int = 1
    var dataForShow : NSMutableArray = NSMutableArray()
    var orderType : Int!
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()

    //当前用户信息
    var userInfo : ZXY_UserDetailInfoData!
    private var userData : ZXY_UserDetailInfoUserDetailBase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserInfo()
        self.orderListTableView.backgroundColor = UIColor.NailBackGrayColor()
        
        srW.startProgress(self.view)
        self.loadOrderInfo()
        self.addHeaderAndFooterforTable()
        
        // Do any additional setup after loading the view.
    }
    
    //获取当前用户的信息
    func getUserInfo() {
        self.userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var userInfoDic = ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo()
        if let user = userInfoDic {
            self.userData = ZXY_UserDetailInfoUserDetailBase(dictionary: user)
            self.userInfo = self.userData?.data
            self.role     = self.userInfo.role
        }
    }

    
    
    //停止上拉下拉刷新
    private func endFreshing()
    {
        orderListTableView.footerEndRefreshing()
        orderListTableView.headerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforTable()
    {
        orderListTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.pageCount++
            self?.loadOrderInfo()
            ""
        }
        
        orderListTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
            self?.loadOrderInfo()
            ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func loadOrderInfo() {
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_OrderList)
        var parameter : Dictionary<String ,  AnyObject> = ["user_id": self.userID! , "role" : self.role!,"p" : pageCount]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var arr = SR_OrderListBaseClass(dictionary: returnDic).data
            if(self?.pageCount == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.orderListTableView.reloadData()
            self?.endFreshing()
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
            self?.endFreshing()
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            ""
        }
    }
    
    //删除订单
    func orderDelete(nextStatus: String ,orderId : String) {
        srW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_ChangeOrderStatus)
        var parameter : Dictionary<String ,  AnyObject> = ["status": nextStatus ,"role": self.role! ,"user_id" : self.userID!, "order_id": orderId]
        println("\(parameter)")
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var result : Double = returnDic["result"] as! Double
            if result == 1000 {
                self?.loadOrderInfo()
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

    override func leftNaviButtonAction() {
        switch self.orderType {
        case 0:
            self.navigationController?.popToRootViewControllerAnimated(true)
        case 1:
            self.navigationController?.popToRootViewControllerAnimated(true)
        case 2:
            self.navigationController?.popViewControllerAnimated(true)
        default:
            ""
        }
    }
}

extension SR_OrderTableVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataForShow.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_OrderTableCell.cellID()) as! SR_OrderTableCell
        var cellData = dataForShow[indexPath.section] as! SR_OrderListData
        
        //美甲师头像
        cell.headImg.layer.cornerRadius = CGRectGetWidth(cell.headImg.bounds) / 2
        cell.headImg.layer.masksToBounds = true
        cell.headImg.layer.borderColor  = UIColor.NailRedColor().CGColor
        cell.headImg.layer.borderWidth  = 1
        var imgUrl = cellData.headImage as String?
        if let url = imgUrl
        {
            if (imgUrl!.hasPrefix("http"))
            {
                cell.headImg.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                cell.headImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
            }
        }
        else {
            cell.headImg.image = UIImage(named: "headImg")
        }
        
        //美甲师姓名
        cell.nickName.text = cellData.nickName
        
        //预约时间
        var timeString = timeStampToDateString(cellData.addTime)
        cell.orderTime.text = timeString
        
        //预约地址
        if (cellData.detailAddr == "null") {
            cell.orderAddress.text = "待定"
        }
        else {
            cell.orderAddress.text = cellData.detailAddr

        }
        
        //订单id
        cell.orderID = cellData.orderId
        cell.delegate = self
        
        //预约主题
        if (cellData.albumDesc != "") {
            cell.orderAblum.text = cellData.albumDesc
        }
        else {
            cell.orderAblum.text = "待定"
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
        cell.orderDeleteBtn.layer.borderColor = UIColor.NailBackGrayColor().CGColor
        cell.orderDeleteBtn.layer.borderWidth = 1
        cell.orderDeleteBtn.layer.cornerRadius = 4
        cell.orderDeleteBtn.layer.masksToBounds = true
        switch cellData.orderStatus {
            case "1" :
                cell.orderState.text = "待接受"
                cell.orderState.textColor = UIColor.NailGrayColor()
                cell.orderDeleteBtn.hidden = true
            case "2":
                cell.orderState.text = "顾客取消"
                cell.orderState.textColor = UIColor.NailRedColor()
                cell.orderDeleteBtn.hidden = false
            case "3" :
                cell.orderState.text = "美甲师拒绝"
                cell.orderState.textColor = UIColor.NailRedColor()
                cell.orderDeleteBtn.hidden = false
            case "4":
                cell.orderState.text = "美甲师接受"
                cell.orderState.textColor = UIColor.NailGrayColor()
                cell.orderDeleteBtn.hidden = true
            case "5":
                cell.orderState.text = "美甲师取消"
                cell.orderState.textColor = UIColor.NailRedColor()
                cell.orderDeleteBtn.hidden = false
            case "6":
                cell.orderState.text = "顾客取消"
                cell.orderState.textColor = UIColor.NailRedColor()
                cell.orderDeleteBtn.hidden = false
            case "7":
                cell.orderState.text = "已完成"
                cell.orderState.textColor = UIColor.NailRedColor()
                cell.orderDeleteBtn.hidden = false
            default:
                switch cellData.preStatus {
                case "1" :
                    cell.orderState.text = "待接受"
                    cell.orderState.textColor = UIColor.NailGrayColor()
                    cell.orderDeleteBtn.hidden = true
                case "2":
                    cell.orderState.text = "顾客取消"
                    cell.orderState.textColor = UIColor.NailRedColor()
                    cell.orderDeleteBtn.hidden = false
                case "3" :
                    cell.orderState.text = "美甲师拒绝"
                    cell.orderState.textColor = UIColor.NailRedColor()
                    cell.orderDeleteBtn.hidden = false
                case "4":
                    cell.orderState.text = "美甲师接受"
                    cell.orderState.textColor = UIColor.NailGrayColor()
                    cell.orderDeleteBtn.hidden = true
                case "5":
                    cell.orderState.text = "美甲师取消"
                    cell.orderState.textColor = UIColor.NailRedColor()
                    cell.orderDeleteBtn.hidden = false
                case "6":
                    cell.orderState.text = "顾客取消"
                    cell.orderState.textColor = UIColor.NailGrayColor()
                    cell.orderDeleteBtn.hidden = false
                case "7":
                    cell.orderState.text = "已完成"
                    cell.orderState.textColor = UIColor.NailRedColor()
                    cell.orderDeleteBtn.hidden = false
                default:
                    ""
                }
        }

        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellData = dataForShow[indexPath.section] as! SR_OrderListData
        var story = UIStoryboard(name: "SR_OrderStory", bundle: nil)
        var vc = story.instantiateViewControllerWithIdentifier("SR_OrderDetailVCID") as! SR_OrderDetailVC
        vc.orderID = cellData.orderId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SR_OrderTableVC : SR_OrderTableCellProtocol {
    func orderDelete( orderId : String ) {
        println("\(orderId)")
        if self.role == "1" {
            self.orderDelete("8", orderId: orderId)
        }
        else {
            self.orderDelete("9", orderId: orderId)
        }
    }
}
