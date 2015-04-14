//
//  SR_checkIdVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/13.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_checkIdVC: UIViewController {
    
    @IBOutlet weak var checkTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTableView.backgroundColor = UIColor.NailBackGrayColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
extension SR_checkIdVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0
        {
            return 160
        }
        else
        {
            return 61
        }
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch indexPath.row
        {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("check_0") as? UITableViewCell
            var idImgView = cell?.viewWithTag(1) as UIImageView
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("check_1") as? UITableViewCell
            var trueNameText = cell?.viewWithTag(1) as UITextField
            trueNameText.delegate = self
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("check_2") as? UITableViewCell
            var idText = cell?.viewWithTag(1) as UITextField
            idText.delegate = self
        case 3:
            cell = tableView.dequeueReusableCellWithIdentifier("check_3") as? UITableViewCell
            var button =  cell?.viewWithTag(1) as UIButton
            button.layer.cornerRadius = 4
            button.backgroundColor = UIColor.NailRedColor()
            button.addTarget(self, action: Selector("checkValidate"), forControlEvents: UIControlEvents.TouchUpInside)
        default:
            break
        }
        cell?.backgroundColor = UIColor.NailBackGrayColor()
        return cell!
    }
    
    func checkValidate()
    {
        println("hello")
    }
}

extension SR_checkIdVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        var frame:CGRect = checkTableView.frame
        frame.origin.y = -130
        checkTableView.frame = frame
        return true
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        var frame:CGRect = checkTableView.frame
        frame.origin.y = 64
        checkTableView.frame = frame
        self.view.endEditing(true)
        return true
    }
}
