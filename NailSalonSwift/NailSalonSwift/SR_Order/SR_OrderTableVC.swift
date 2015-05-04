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
    @IBOutlet weak var topBar: UIView!
    
    var artistID : String?
    var userID : String?
    var ablumName : String?
    var ablumId : String?
    var role : String!
    var pageCount : Int = 1
    var dataForShow : NSMutableArray = NSMutableArray()
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBar.backgroundColor = UIColor.NailRedColor()
        self.orderListTableView.backgroundColor = UIColor.NailBackGrayColor()
        srW.startProgress(self.view)
        self.loadOrderInfo()
        self.addHeaderAndFooterforTable()
        // Do any additional setup after loading the view.
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
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            ""
        }
    }

    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
        var imgUrl    = cellData.headImage as String?
        if let url    = imgUrl
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
        
        //美甲师姓名
        cell.nickName.text = cellData.nickName
        
        //预约时间
        cell.orderTime.text = cellData.addTime
        println("\(cellData.addTime)")
        
        //预约地址
        if (cellData.detailAddr == "null") {
            cell.orderAddress.text = "待定"
        }
        else {
            cell.orderAddress.text = cellData.detailAddr

        }
        
        //预约主题
        if (self.ablumName != nil) {
            cell.orderAblum.text = self.ablumName
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
                cell.orderState.text = "交易完成"
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
                    cell.orderState.text = "交易完成"
                    cell.orderState.textColor = UIColor.NailRedColor()
                    cell.orderDeleteBtn.hidden = false
                default:
                    ""
                }
        }

        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
