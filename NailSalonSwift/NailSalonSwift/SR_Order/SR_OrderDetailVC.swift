
//
//  SR_OrderDetailVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/5.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderDetailVC: UIViewController {
    
    typealias RequestBlock = (status : String) -> Void
    var requestBlock : RequestBlock!
    
    @IBOutlet weak var orderDetailTableView: UITableView!
    @IBOutlet weak var userCancel: UIButton!
    @IBOutlet weak var orderRefuse: UIButton!
    @IBOutlet weak var orderAccept: UIButton!

    var myFun : ((hello : String ) -> String)?
    
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    
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
        self.getUserInfo()
        srW.startProgress(self.view)
        self.loadOrderDetail()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.loadOrderDetail()
        userCancel.hidden = true
        orderRefuse.hidden = true
        orderAccept.hidden = true
        self.btnHeight.constant = 0
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
        self.btnHeight.constant = 50
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
                //判断是否评论过
                if dataForShow?.data.commId != "0" {
                    userCancel.hidden = true
                    self.btnHeight.constant = 0
                }
            default:
                userCancel.hidden = true
                orderRefuse.hidden = true
                orderAccept.hidden = true
                self.btnHeight.constant = 0
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
                //判断是否评论过
                if dataForShow?.data.commTouserId != "0" {
                    userCancel.hidden = true
                    self.btnHeight.constant = 0
                }
                //用户是否评论
                if dataForShow?.data.commId == "0" {
                    userCancel.hidden = true
                    self.btnHeight.constant = 0
                }
            default:
                userCancel.hidden = true
                orderRefuse.hidden = true
                orderAccept.hidden = true
                self.btnHeight.constant = 0
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
        var urlString = ZXY_NailNetAPI.SR_OrderAPITpye(SR_OrderAPIType.SR_ChangeOrderStatus)
        var parameter : Dictionary<String ,  AnyObject> = ["status": nextStatus ,"role": self.userInfo.role! ,"user_id" : self.userId!, "order_id": self.orderID!]
        println("\(parameter)")
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var result : Double = returnDic["result"] as! Double
            if result == 1000 {
                self?.loadOrderDetail()
                if self?.requestBlock != nil {
                    self?.requestBlock(status: nextStatus)
                }
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
    
    /**
    订单状态改变
    role ： 1.普通用户 2.美甲师
    1.用户：
        1.发订单           1 --> 2         6 --> 8
        2.取消(未接受)      2 --> 8         7 --> 8
        6.取消(已接受)      3 --> 8
        7.完成             4 --> 6、7
        8.删除             5 --> 8
    2.美甲师：
        3.拒绝             1 --> 3、4      5 --> 9
        4.接受                             6 --> 9
        5.取消             3 --> 9         7 --> 9
        9.删除             4 --> 5
    **/
    
    //取消订单or完成评价
    @IBAction func userCancelBtnClick(sender: AnyObject) {
        switch dataForShow!.data.orderStatus {
        case "1":
            self.changeOrderStatus("2")
        case "4":
            self.changeOrderStatus("5")
        case "7":
            var story  = UIStoryboard(name: "SR_OrderStory", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("SR_OrderCommentVCID") as! SR_OrderCommentVC
            vc.orderID = self.orderID
            vc.title   = "填写评价"
            self.navigationController?.pushViewController(vc, animated: true)
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
        if self.dataForShow?.data.commTouserId != "0" || self.dataForShow?.data.commId != "0" {
            self.orderDetailTableView.scrollEnabled = true
            return 2
        }
        else {
            self.orderDetailTableView.scrollEnabled = false
            return 1
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataForShow == nil {
            return 0
        }
        else {
            switch section {
            case 0:
                return 4
            case 1:
                var commentNum : Int = 0
                if self.dataForShow?.data.commTouserId != "0" {
                    commentNum++
                }
                if self.dataForShow?.data.commId != "0" {
                    commentNum++
                }
                return commentNum
            default:
                return 4
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return 125
            }
            else {
                return 50
            }
        case 1:
            switch indexPath.row {
            case 0:
                if self.dataForShow?.data.user.comment.imagePath == nil {
                    return 85
                }
                else {
                    return 175
                }
            case 1:
                return 85
            default:
                return 0
            }
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var firstCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailFirstCell.cellID()) as! SR_OrderDetailFirstCell
        var secondCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailSecondCell.cellID()) as! SR_OrderDetailSecondCell
        var thirdCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailThirdCell.cellID()) as! SR_OrderDetailThirdCell
        var commentCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderDetailCommentCell.cellID()) as! SR_OrderDetailCommentCell
        switch indexPath.section {
        case 0:
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
                else {
                    firstCell.headImg.image = UIImage(named: "headImg")
                }
                
                if self.dataForShow?.data.user.tel == ""{
                    firstCell.chatBtnWidth.constant = 15
                    firstCell.telBtn.hidden = true
                }
                else {
                    firstCell.chatBtnWidth.constant = 50
                    firstCell.telBtn.hidden = false
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
        case 1:
            var headImgUrl : String?
            var nameString : String?
            var commentScore : NSString?
            var commentTime : String?
            var commentString : String?
            var commentImgUrl : String?
            switch indexPath.row {
            case 0:
                headImgUrl    = dataForShow?.data.custom.headImage
                nameString    = dataForShow?.data.custom.nickName
                commentScore  = NSString(format: "%@", dataForShow!.data.user.comment.score)
                commentTime   = dataForShow?.data.user.comment.addTime
                commentString = dataForShow?.data.user.comment.comment
                commentImgUrl = dataForShow?.data.user.comment.imagePath
                if self.dataForShow?.data.user.comment.imageId == "0" {
                    commentCell.commentImg.hidden = true
                }
                ""
            case 1:
                headImgUrl = dataForShow?.data.user.headImage
                nameString = dataForShow?.data.user.nickName
                commentScore  = NSString(format: "%@", dataForShow!.data.custom.comment.score)
                commentTime   = dataForShow?.data.custom.comment.addTime
                commentString = dataForShow?.data.custom.comment.comment
                commentImgUrl = dataForShow?.data.custom.comment.imagePath
                commentCell.commentImg.hidden = true
                ""
            default:
                ""
            }
            
            //评论头像
            if let url = headImgUrl
            {
                if (url.hasPrefix("http"))
                {
                    commentCell.headImg.setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "imgHolder"))
                }
                else
                {
                    var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + url
                    commentCell.headImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
                }
            }
            //评论昵称
            commentCell.nickName.text = nameString
            
            //用户评价等级
            var doubleScore = commentScore!.doubleValue
            commentCell.starRateView?.scorePercent = CGFloat(doubleScore/5.0)
            
            //评价时间
            commentCell.commentTime.text = self.timeStampToDate(commentTime!)
            
            //评价内容
            commentCell.commentString.text = commentString
            
            //评价图片
            if let url = commentImgUrl
            {
                if (url.hasPrefix("http"))
                {
                    commentCell.commentImg.setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "imgHolder"))
                }
                else
                {
                    var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + url
                    commentCell.commentImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
                }
            }
            
            return commentCell
        default:
            return firstCell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3 {
            if dataForShow?.data.albumId != "0" {
                var story = UIStoryboard(name: "PublicStory", bundle: nil)
                var vc    = story.instantiateViewControllerWithIdentifier("artDetailID") as! ZXY_DFPArtDetailVC
                vc.artWorkID = dataForShow?.data.albumId
                vc.title     = "美甲室"
                self.navigationController?.pushViewController(vc, animated: true)

            }
            else
            {
                self.showAlertEasy("提示", messageContent: "用户未选定图集")
                println("hello")
            }
        }
    }
}

extension SR_OrderDetailVC : SR_OrderDetailFirstCellProtocol {
    
    //点击头像跳转到用户详细信息
    func clickHeadImg() {
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var detailArtist = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as!ZXY_DFPArtistDetailVC
        if self.userInfo.role == "1" {
            detailArtist.artistID = dataForShow?.data.userId
        }
        else {
            detailArtist.artistID = dataForShow?.data.customId
        }
        self.navigationController?.pushViewController(detailArtist, animated: true)
    }
    
    //发送消息
    func clickMessage() {
        println("交流")
        var myData = self.userData?.data
        var artistID : String?
        var headImgString : String?
        var nameString : String?
        if self.userInfo.role == "1" {
            artistID = dataForShow?.data.userId
            headImgString = dataForShow?.data.user.headImage ?? ""
            nameString = dataForShow?.data.user.nickName
        }
        else {
            artistID = dataForShow?.data.customId
            headImgString = dataForShow?.data.custom.headImage ?? ""
            nameString = dataForShow?.data.custom.nickName
        }
        var chatView = ChatViewController(chatter: artistID!, isGroup: false)
        chatView.title = nameString
        var stringURL =  ZXY_ALLApi.ZXY_MainAPIImage + headImgString!
        if let img = headImgString {
            if(img.hasPrefix("http"))
            {
                stringURL = headImgString!
            }
        }
        chatView.imgURLTo = stringURL
        var myHeadImg : String? = myData!.headImage
        if let myI = myHeadImg
        {
            var imgURL =  ZXY_ALLApi.ZXY_MainAPIImage + myData!.headImage!
            if myI.hasPrefix("http")
            {
                imgURL = myI
            }
            chatView.imgURLMy = imgURL
        }
        self.navigationController?.pushViewController(chatView, animated: true)

    }

    //拨打电话
    func clickTel() {
        println("\(self.dataForShow?.data.user.tel)")
        if let userTel = self.dataForShow?.data.user.tel {
            var tel = "telprompt://" + userTel
            println("\(tel))")
            var urlTel = NSURL(string: tel)
            UIApplication.sharedApplication().openURL(urlTel!)
        }
    }
}
