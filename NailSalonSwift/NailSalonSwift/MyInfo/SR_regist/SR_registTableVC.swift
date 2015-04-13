//
//  SR_registTableVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol SR_registTableVCProtocol: class
{
    func toCheckIdVC() -> Void
}

class SR_registTableVC: UITableViewController {

    @IBOutlet weak var registButton: UIButton!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var userConfirmPasswordText: UITextField!
    
    var isArtistRegist: Bool? = true
    
    weak var delegate: SR_registTableVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = UIColor.NailBackGrayColor()
        registButton.backgroundColor = UIColor.NailRedColor()
        self.registButton.layer.cornerRadius = 4
        
        if isArtistRegist == true
        {
            registButton.setTitle("下一步", forState: UIControlState.Normal)
        }
        else
        {
            registButton.setTitle("确认注册", forState: UIControlState.Normal)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func registBtnClick(sender: AnyObject) {
        self.view.endEditing(true)
//        if(self.userNameText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 11)
//        {
//            self.showAlertEasy("提示", messageContent: "请输入正确的手机号码")
//            return
//        }
//        
//        if(self.userPasswordText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
//        {
//            self.showAlertEasy("提示", messageContent: "请输入密码")
//            return
//        }
//        
//        if(self.userPasswordText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != self.userConfirmPasswordText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
//        {
//            self.showAlertEasy("提示", messageContent: "两次密码输入不一致")
//            return
//        }
        
        if isArtistRegist == true
        {
            //美甲师身份验证
            self.delegate?.toCheckIdVC()
        }
        else
        {
            //用户注册
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 4
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
