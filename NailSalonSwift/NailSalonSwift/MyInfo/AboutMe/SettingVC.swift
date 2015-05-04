//
//  SettingVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/21.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    var userInfo: ZXY_UserDetailInfoData!

    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var topBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBarView.backgroundColor = UIColor.NailRedColor()
        logOutBtn.backgroundColor = UIColor.NailRedColor()
        logOutBtn.layer.cornerRadius = 4
        self.navigationController?.navigationBar.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        var logOutAler = UIAlertView()
        logOutAler.message  = "您确定退出账号吗？"
        logOutAler.title    = "提示"
        logOutAler.addButtonWithTitle("取消")
        logOutAler.addButtonWithTitle("确定")
        logOutAler.delegate = self
        logOutAler.show()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var segueID = segue.identifier
        if(segueID == "toCheckIdVC")
        {
            var checkIdVC = segue.destinationViewController as! SR_checkIdVC
            checkIdVC.userInfo = userInfo
        }
    }
    

}
extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
//            return 2
            return 1
        case 1:
            return userInfo.role == "1" ? 2 : 3
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SettingCell.identifier) as! SettingCell
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
//                cell.setCellText.text = "消息设置"
//            case 1:
                cell.setCellText.text = "修改密码"
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.setCellText.text = "关于我们"
            case 1:
                cell.setCellText.text = "注册协议"
            case 2:
                cell.setCellText.text = "身份验证"
            default:
                break
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                break
            case 1:
                performSegueWithIdentifier("toRessetPassWordVC", sender: nil)
                ""
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("toAboutUs", sender: nil)
            case 1:
                performSegueWithIdentifier("toSetProtocolVC", sender: nil)
            case 2:
                performSegueWithIdentifier("toSetCheckVC", sender: nil)
            default:
                break
            }
        default:
            break
        }
    }
}

extension SettingVC : UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            return
        case 1:
            ZXY_UserInfoDetail.sharedInstance.logoutUser()
            self.navigationController?.popViewControllerAnimated(true)
        default:
            return
        }
    }
}
