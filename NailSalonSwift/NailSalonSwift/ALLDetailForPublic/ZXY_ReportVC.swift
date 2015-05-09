//
//  ZXY_ReportVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/26.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_ReportVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    var selectItemArr : [Int]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "举报"
        selectItemArr = []
        currentTable.tableFooterView = UIView(frame : CGRectZero)
//        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName : ZXY_AllColor.SEARCH_RED_COLOR], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("submitAction"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func submitAction()
    {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        dispatch_after(dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(2 * Double(NSEC_PER_SEC))
            ), dispatch_get_main_queue()) { [weak self]() -> Void in
             MBProgressHUD().hide(true)
             self?.navigationController?.popViewControllerAnimated(true)
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

extension ZXY_ReportVC : UITableViewDataSource , UITableViewDelegate
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell     = tableView.dequeueReusableCellWithIdentifier("reportCellID") as! UITableViewCell
        var cellLbl  = cell.viewWithTag(1002) as! UILabel
        var cellImg  = cell.viewWithTag(1001) as! UIImageView
        var cellInfo = ""
        var currentRow = indexPath.row
        switch currentRow {
        case 0 :
            cellInfo = "色情"
        case 1:
            cellInfo = "谣言"
        case 2 :
            cellInfo = "恶意营销"
        case 3:
            cellInfo = "侮辱诋毁"
        default :
            cellInfo = "暴力"
        }
        
        var flag       = contains(selectItemArr!, currentRow)
        if(flag)
        {
            cellImg.image = UIImage(named: "select_circle")
        }
        else
        {
            cellImg.image = UIImage(named : "noSelect_circle")
        }
        cellLbl.text = cellInfo
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currentRow = indexPath.row
        var flag       = contains(selectItemArr!, currentRow)
        if(flag)
        {
            selectItemArr =
                filter(selectItemArr!, { (current) -> Bool in
                if(current == currentRow)
                {
                    return false
                }
                else
                {
                    return true
                }
            })
            
            
        }
        else
        {
            selectItemArr?.append(currentRow)
        }
        currentTable.reloadData()
    }
}
