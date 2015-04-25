//
//  SR_ORgetCourseVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_ORgetCourseVC: UIViewController {

    var courseId  : String! //样式id
    var stringURL : String!
//    var shareURL  : String!

    private var dataForBtns : SR_CourseUserStatusBaseClass?
    private var zxyW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    @IBOutlet weak var getCourseWebView: UIWebView!
    @IBOutlet weak var praiseBtn: UIButton!
    @IBOutlet weak var collectionBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    typealias RequestBlock = () -> Void
    var requestBlock : RequestBlock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        var timeStamp = ZXY_NetHelperOperate().timeStamp()
        var token     = ZXY_NetHelperOperate().timeStampMD5("meijia\(timeStamp)")
        stringURL = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseDetail) + "?course_id=\(courseId)&timestamp=\(timeStamp)&token=\(token)"
        var request = NSURLRequest(URL: NSURL(string: stringURL)!, cachePolicy: NSURLRequestCachePolicy.ReloadRevalidatingCacheData, timeoutInterval: 30)
        self.getCourseWebView.loadRequest(request)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.startLoadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //加载点赞和收藏状态
    private func startLoadData()
    {
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            return
        }
        userID     = userID ?? ""
        var urlString = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseUserStatus)
        var parameter = ["user_id" : userID! ,"course_id": courseId!]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.dataForBtns = SR_CourseUserStatusBaseClass(dictionary: returnDic)
            var resultDouble  = self?.dataForBtns?.result
            if resultDouble == 1000 {
                self?.reloadStatus()
            }
            else
            {
                var message = ZXY_ErrorMessageHandle.messageForErrorCode(resultDouble!)
                self?.showAlertEasy("提示", messageContent: message)
            }
            }) {[weak self] (error) -> Void in
                self?.showAlertEasy("提示", messageContent: "网络连接错误")
                ""
        }
        
    }
    
    //改变点赞和收藏按钮图片和文字颜色
    func reloadStatus(){
        if let status = dataForBtns{
            var isStarNum = status.data.isStar
            var isCollectNum = status.data.isCollect
            
            if(isStarNum == "1"){
                self.praiseBtn.setImage(UIImage(named: "heart_gray"), forState: UIControlState.Normal)
                self.praiseBtn.setTitleColor(UIColor.NailGrayColor(), forState: UIControlState.Normal)
                self.praiseBtn.setTitle("已点赞", forState: UIControlState.Normal)
                self.praiseBtn.titleEdgeInsets.right = 10
                self.praiseBtn.imageEdgeInsets.left  = 40
            }
            else
            {
                self.praiseBtn.setImage(UIImage(named: "heart_red"), forState: UIControlState.Normal)
                self.praiseBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
                self.praiseBtn.setTitle("点赞", forState: UIControlState.Normal)
                self.praiseBtn.titleEdgeInsets.right = 10
                self.praiseBtn.imageEdgeInsets.left  = 30
            }
            
            if(isCollectNum == "1"){
                self.collectionBtn.setImage(UIImage(named: "star_gray"), forState: UIControlState.Normal)
                self.collectionBtn.setTitleColor(UIColor.NailGrayColor(), forState: UIControlState.Normal)
                self.collectionBtn.setTitle("已收藏", forState: UIControlState.Normal)
                self.collectionBtn.titleEdgeInsets.right = 9
                self.collectionBtn.imageEdgeInsets.left  = 40
            }
            else
            {
                self.collectionBtn.setImage(UIImage(named: "star_red"), forState: UIControlState.Normal)
                self.collectionBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
                self.collectionBtn.setTitle("收藏", forState: UIControlState.Normal)
                self.collectionBtn.titleEdgeInsets.right = 9
                self.collectionBtn.imageEdgeInsets.left  = 30
            }
        }
    }
    
    //分享
    @IBAction func shareBtnClick(sender: AnyObject) {
        
    }
    /**
    改变状态码
    
    :param: types 0 代表 点赞 ， 1 代表 收藏
    */
    
    //点赞
    @IBAction func praiseBtnClick(sender: AnyObject) {
        self.changeStatus(0)
    }
    //收藏
    @IBAction func collectionBtnClick(sender: AnyObject) {
        self.changeStatus(1)
    }
    
    func changeStatus(types : Int){
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            var alert = UIAlertView(title: "提示", message: "您还没有登录，请先登录吧", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "取消", "确定")
            alert.show()
            return
        }
        var urlString = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseStart)
        if types == 1 {
            urlString = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseCollect)
        }
        if let status = dataForBtns
        {
            var isStarNum = status.data.isStar
            var isCollect = status.data.isCollect
            var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID()
            if(userID == nil)
            {
                return
            }
            var statusNum = isStarNum
            if(types == 1) {
                statusNum = isCollect
            }
            
            if(statusNum == "1")
            {
                statusNum = "2"
            }
            else {
                statusNum = "1"
            }
            zxyW.startProgress(self.view)
            var parameter = ["user_id": userID , "course_id": courseId! , "status": statusNum]
            ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
                var result = returnDic["result"] as Double
                if result == 1000 {
                    if types == 1 {
                        self?.dataForBtns?.data.isCollect = statusNum
                    }
                    else{
                        self?.dataForBtns?.data.isStar = statusNum
                    }
                    self?.reloadStatus()
                    if let s = self
                    {
                        self?.zxyW.hideProgress(s.view)
                    }
                    if self?.requestBlock != nil {
                        self?.requestBlock()
                    }
                }
                else {
                    var message = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                    self?.showAlertEasy("提示", messageContent: message)
                    if let s = self
                    {
                        self?.zxyW.hideProgress(s.view)
                    }
                }
            }, failBlock: { [weak self](error) -> Void in
                self?.showAlertEasy("提示", messageContent: "网络连接错误")
                if let s = self
                {
                    self?.zxyW.hideProgress(s.view)
                }
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

}
extension SR_ORgetCourseVC : UIAlertViewDelegate , ZXY_LoginRegistVCProtocol {
    func userLoginSuccess() {
        self.startLoadData()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(buttonIndex == 1)
        {
            var story = UIStoryboard(name: "MyInfoStory", bundle: nil) as UIStoryboard
            var loginVC = story.instantiateViewControllerWithIdentifier("loginVCID") as ZXY_LoginRegistVC
            loginVC.delegate = self
            loginVC.navigationController?.navigationBar.hidden = true
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}
