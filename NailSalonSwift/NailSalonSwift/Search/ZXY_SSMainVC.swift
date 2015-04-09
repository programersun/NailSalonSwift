//
//  ZXY_SSMainVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_SSMainVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var SearchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.title = "搜索"

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension ZXY_SSMainVC : UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate
{
    /**
    根据indexPath 返回cell所需要显示的图片与title
    
    :param: indexPath table indexpath
    
    :returns: 图片名字 title 名字
    */
    func itemDataForTable(indexPath : NSIndexPath) ->   String
    {
        if(indexPath.section == 0)
        {
            var currentRow = indexPath.row
            switch currentRow
            {
            case 0:
                return "标签"
            default:
                return "标签"
            }
        }
        else
        {
            var currentRow = indexPath.row
            switch currentRow
            {
            case 0:
                return "昵称"
            case 1:
                return "附近"
            default:
                return "昵称"
            }
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var SSMainCell = tableView.dequeueReusableCellWithIdentifier(ZL_SSMainCell.cellID()) as ZL_SSMainCell
        
            var titleName = self.itemDataForTable(indexPath)
            SSMainCell.itemTitle.text = titleName
            SSMainCell.itemTitle.textColor = UIColor.NailGrayColor()
            return SSMainCell
        }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      
            return 62
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 2
        default:
            return 3
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 62
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRectZero)
        headerView.backgroundColor = UIColor.whiteColor()
        return headerView
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("lala", sender: nil)
//    }
    
}
















