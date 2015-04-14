//
//  ZXY_MIRegistVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MIRegistVC: UIViewController {
    
    var registUserVC : SR_registTableVC =  UIStoryboard(name: "MyInfoStory", bundle: nil).instantiateViewControllerWithIdentifier("registIdentity") as SR_registTableVC
    var registArtistVC : SR_registTableVC =  UIStoryboard(name: "MyInfoStory", bundle: nil).instantiateViewControllerWithIdentifier("registIdentity") as SR_registTableVC
    
    @IBOutlet weak var registScrollView: UIScrollView!
    @IBOutlet weak var registProtocolBtn: UIButton!
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    override func viewDidLoad() {
        super.viewDidLoad()
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

    }


    @IBAction func backAction(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func registChange(sender: AnyObject) {
        var seg = sender as UISegmentedControl
        if seg.selectedSegmentIndex == 0
        {
            registScrollView.setContentOffset(CGPointMake(0, registScrollView.contentOffset.y), animated: true)
        }
        else
        {
            registScrollView.setContentOffset(CGPointMake(screenWidth, registScrollView.contentOffset.y), animated: true)
        }
    }

    @IBAction func portocolAction(sender: AnyObject) {
        self.performSegueWithIdentifier("toProtocolVC", sender: nil)
    }
}

extension ZXY_MIRegistVC: SR_registTableVCProtocol {
    func toCheckIdVC() {
        self.performSegueWithIdentifier("toCheckIdVC", sender: nil)
    }
    
    func userRegist(userName: String, userPassword: String) {
        var urlString = ZXY_NailNetAPI.ZXY_MainAPI + ZXY_MyInfoAPIType.MI_Regist.rawValue
        var parameter : Dictionary<String , AnyObject> = ["user_name": userName , "password": userPassword , "role": 1]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { (returnDic) -> Void in
//            if(resultID == Double(1000))
//            {
//                
//            }
//            else
//            {
//                var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(resultID)
//                self?.showAlertEasy("提示", messageContent: errorString)
//                self?.endFreshing()
//            }
            }) { (error) -> Void in
                println(error)
//                if let s = self
//                {
//                    s.srW.hideProgress(s.view)
//                }
//                self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
//                ""
        }
    }
}