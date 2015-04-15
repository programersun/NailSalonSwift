//
//  SettingViewController.swift
//  KickYourAss
//
//  Created by eagle on 15/2/9.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    
    var userInfo: ZXY_UserInfoDetail!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let flexLeft = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let logout = UIBarButtonItem(title: "退出账户", style: UIBarButtonItemStyle.Plain, target: self, action: "logoutButtonPressed:")
        let flexRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
//        navigationController?.toolbarItems = [flexLeft, logout, flexRight]
        setToolbarItems([flexLeft, logout, flexRight], animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.toolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    func logoutButtonPressed(sender: AnyObject) {
//        LCYCommon.sharedInstance.logout()
//        ZXY_UserInfoDetail.sharedInstance.logoutUser()
//        (navigationController?.viewControllers.first as? ZXY_MIMainVC)
//        navigationController?.popToRootViewControllerAnimated(true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
//        switch section {
//        case 0:
//            return 1
//        case 1:
////            return userInfo.role == "1" ? 1 : 2
//            return 2
//        default:
//            return 0
//        }
        return 2
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SettingCell.identifier, forIndexPath: indexPath) as SettingCell

        // Configure the cell...
        switch indexPath.section {
        case 1:
            switch indexPath.row {
//            case 0:
//                cell.textLabel?.text = "消息设置"
            case 0:
                cell.textLabel?.text = "修改密码"
            default:
                break
            }
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "关于我们"
            case 1:
                cell.textLabel?.text = "注册协议"
            case 2:
                cell.textLabel?.text = "身份验证"
            default:
                break
            }
        default:
            break
        }

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 1:
                break
            case 0:
                performSegueWithIdentifier("modifyPassword", sender: nil)
            default:
                break
            }
        case 0:
            switch indexPath.row {
            case 0:
                performSegueWithIdentifier("showVersion", sender: nil)
            case 1:
                performSegueWithIdentifier("showWeb", sender: nil)
            case 2:
                break
            default:
                break
            }
        default:
            break
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
