 //
//  ZXY_MyBlockListVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/15.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MyBlockListVC: UIViewController {

    @IBOutlet weak var dataList: UITableView!
    private var allBlockUser : NSMutableArray = NSMutableArray()
    var zxyW : ZXY_WaitProgressVC = ZXY_WaitProgressVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        zxyW.startProgress(self.view)
        self.fetchBlockList()
        self.title = "黑名单"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchBlockList()
    {
        var error : EMError? = nil
        
        var allBlock = EaseMob.sharedInstance().chatManager.fetchBlockedList(&error)
        if error == nil
        {
            if allBlock != nil
            {
                for one in allBlock
                {
                    var realVar = one as! String
                    if !allBlockUser.containsObject(realVar)
                    {
                        allBlockUser.addObject(realVar)
                    }
                }
                dataList.reloadData()
                zxyW.hideProgress(self.view)
            }
            else
            {
                self.fetchBlockList()
            }
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

extension ZXY_MyBlockListVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_MyBlockCell.cellID) as! ZXY_MyBlockCell
        var currentID = allBlockUser[indexPath.row] as! String
        cell.startLoadData(currentID)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 68
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBlockUser.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        var currentRow = indexPath.row
        var currentData = allBlockUser[indexPath.row] as! String
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            allBlockUser.removeObject(currentData)
            EaseMob.sharedInstance().chatManager.unblockBuddy(currentData)
            tableView.reloadData()
        }
    }
}
