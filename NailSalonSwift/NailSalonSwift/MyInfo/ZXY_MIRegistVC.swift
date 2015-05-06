//
//  ZXY_MIRegistVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_MIRegistVCProtocol: class
{
    func userRegist(isUserRegist: Bool) -> Void
    func artistRegist(isArtistRegist: Bool) -> Void
}

class ZXY_MIRegistVC: UIViewController {
    
    @IBOutlet var registSegment: UISegmentedControl!
    //接受美甲师用户名和密码
    var artistName : String?
    var artistPassword : String?
    
    var userInfo : ZXY_UserDetailInfoData?
    private var dataForShow : ZXY_UserDetailInfoUserDetailBase?
    
    weak var delegate : ZXY_MIRegistVCProtocol?
    
    var registUserVC : SR_registTableVC =  UIStoryboard(name: "MyInfoStory", bundle: nil).instantiateViewControllerWithIdentifier("registIdentity") as! SR_registTableVC
    var registArtistVC : SR_registTableVC =  UIStoryboard(name: "MyInfoStory", bundle: nil).instantiateViewControllerWithIdentifier("registIdentity") as! SR_registTableVC
    
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()

    @IBOutlet weak var registScrollView: UIScrollView!
    @IBOutlet weak var registProtocolBtn: UIButton!
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = registSegment
        registProtocolBtn.setTitleColor(UIColor.NailRedColor(), forState: UIControlState.Normal)
        registArtistVC.isArtistRegist = true
        registUserVC.isArtistRegist = false
        registArtistVC.delegate = self
        registUserVC.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        registScrollView.contentSize.width = 2 * screenWidth
        self.addChildViewController(registArtistVC)
        self.addChildViewController(registUserVC)
        registArtistVC.tableView.frame = CGRectMake(0, 0, screenWidth, registScrollView.frame.size.height)
        registUserVC.tableView.frame = CGRectMake(screenWidth, 0,screenWidth, registScrollView.frame.size.height)
        self.registScrollView.addSubview(registArtistVC.tableView)
        self.registScrollView.addSubview(registUserVC.tableView)
        registScrollView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var segueID = segue.identifier
        if(segueID == "toCheckIdVC")
        {
            var checkIdVC = segue.destinationViewController as! SR_checkIdVC
            checkIdVC.userName = artistName
            checkIdVC.userPassword = artistPassword
        }
        
        if( segueID == "toUserInfo")
        {
            var propertyVC = segue.destinationViewController as! ICYProfileViewController
            propertyVC.userInfo = userInfo
            println("\(ZXY_UserInfoDetail.sharedInstance.getUserID())")
            println("\(ZXY_UserInfoDetail.sharedInstance.getUserDetailInfo())")
        }
    }


    @IBAction func backAction(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func registChange(sender: AnyObject) {
        var seg = sender as! UISegmentedControl
        if seg.selectedSegmentIndex == 0
        {
            self.delegate?.artistRegist(true)
            registScrollView.setContentOffset(CGPointMake(0, registScrollView.contentOffset.y), animated: true)
        }
        else
        {
            self.delegate?.userRegist(false)
            registScrollView.setContentOffset(CGPointMake(screenWidth, registScrollView.contentOffset.y), animated: true)
        }
    }

    @IBAction func portocolAction(sender: AnyObject) {
        self.performSegueWithIdentifier("toProtocolVC", sender: nil)
    }
    
    func startDownLoadUserDetailInfo()
    {
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID()
        if(userID == nil)
        {
            return
        }
        srW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.ZXY_MyInfoAPI(ZXY_MyInfoAPIType.MI_MyInfo)
        var parameter = ["user_id" : userID!]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            self?.dataForShow = ZXY_UserDetailInfoUserDetailBase(dictionary: returnDic)
            var result = self?.dataForShow?.result
            if(result == 1000)
            {
                ZXY_UserInfoDetail.sharedInstance.saveUserDetailInfo(returnDic)
                self?.userInfo = self?.dataForShow?.data
                println("\(self?.userInfo!)")
                self?.performSegueWithIdentifier("toUserInfo", sender: nil)
//                self?.reloadUserData()
            }
            else
            {
                var messageError = ZXY_ErrorMessageHandle.messageForErrorCode(result ?? 0)
                self?.showAlertEasy("提示", messageContent: messageError)
            }
            
            }) {[weak self] (error) -> Void in
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
        }
        
    }
//    func reloadUserData()
//    {
//        currentTable.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
//        
//    }
//    
}

extension ZXY_MIRegistVC: SR_registTableVCProtocol {
    func toCheckIdVC() {
        self.performSegueWithIdentifier("toCheckIdVC", sender: nil)
    }
    
    func userRegist(userName: String, userPassword: String) {
        
        self.srW.startProgress(self.view)
        
        var urlString = ZXY_NailNetAPI.ZXY_MainAPI + ZXY_MyInfoAPIType.MI_Regist.rawValue
        var parameter : Dictionary<String , AnyObject> = ["user_name": userName , "password": userPassword , "role": 1]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: {[weak self] (returnDic) -> Void in
            var result: Double = returnDic["result"] as! Double
            if(result == Double(1000))
            {
                var userid : Double = returnDic["data"] as! Double
                ZXY_UserInfoDetail.sharedInstance.saveUserID("\(userid)")
                self?.startDownLoadUserDetailInfo()
            }
            else
            {
                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                self?.showAlertEasy("提示", messageContent: errorString)
            }
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

        }
        //self.performSegueWithIdentifier("toUserInfo", sender: nil)
    }
    
    func artistRegist(userName: String, userPassword: String) {
        artistName = userName
        artistPassword = userPassword
    }
}
extension ZXY_MIRegistVC : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        println("1")
        if scrollView.contentOffset.x < screenWidth
        {
            registSegment.selectedSegmentIndex = 0
            self.delegate?.artistRegist(true)
        }
        else
        {
            registSegment.selectedSegmentIndex = 1
            self.delegate?.userRegist(false)
        }

    }
}