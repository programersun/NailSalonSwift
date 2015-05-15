//
//  SR_SettingMessageTableVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/13.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_SettingMessageTableVC: UITableViewController {
    
    @IBOutlet weak var newMessage: UISwitch!
    @IBOutlet weak var soundMessage: UISwitch!
    @IBOutlet weak var shakeMessage: UISwitch!
    
    var filename  : String?
    var data : NSMutableDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息设置"
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        var paths     = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        var plistPath = paths[0] as! String
        self.filename = plistPath.stringByAppendingPathComponent("pushSetting.plist")
        self.data     = NSMutableDictionary(contentsOfFile: self.filename!)
        var message  = self.data!["message"] as! String
        var sound = self.data!["sound"] as! String
        var shake = self.data!["shake"] as! String
        if message == "1" {
            self.newMessage.on = true
        }
        else {
            self.newMessage.on = false
        }
        
        if sound == "1" {
            self.soundMessage.on = true
        }
        else {
            self.soundMessage.on = false
            if shake != "1" {
                self.newMessage.on = false
            }
        }
        
        if shake == "1" {
            self.shakeMessage.on = true
        }
        else {
            self.shakeMessage.on = false
            if sound != "1" {
                self.newMessage.on = false
            }
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch section {
        case 0:
            if self.newMessage.on == true {
                return 3
            }
            else {
                return 1
            }
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func pushSetting(type : Int , value : String) {

        self.data = NSMutableDictionary(contentsOfFile: self.filename!)
        switch type {
        case 0:
            data?.setValue("\(value)", forKey: "message")
        case 1:
            data?.setValue("\(value)", forKey: "sound")
        case 2:
            data?.setValue("\(value)", forKey: "shake")
        default:
            ""
        }
        data?.writeToFile(self.filename!, atomically: true)
    }
    
    @IBAction func newMessage(sender: UISwitch) {
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
        if sender.on == true {
            println("开")
            self.pushSetting(0, value: "1")
            self.pushSetting(1, value: "1")
            self.pushSetting(2, value: "1")
        }
        else {
            println("关")
            self.pushSetting(0, value: "0")
            self.pushSetting(1, value: "0")
            self.pushSetting(2, value: "0")
        }
    }
    
    @IBAction func soundMessage(sender: UISwitch) {
        if sender.on == true {
            println("开")
            self.pushSetting(1, value: "1")
        }
        else {
            println("关")
            if self.shakeMessage.on == false {
                self.newMessage.on = false
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
            }
            
            
            self.pushSetting(1, value: "0")
        }
    }
    
    @IBAction func shakeMessage(sender: UISwitch) {
        if sender.on == true {
            println("开")
            self.pushSetting(2, value: "1")
        }
        else {
            println("关")
            self.pushSetting(2, value: "0")
            if self.soundMessage.on == false {
                self.newMessage.on = false
                self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
            
            }
        }
    }
    

    
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
//
//        // Configure the cell...
//
//        return cell
//    }


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
