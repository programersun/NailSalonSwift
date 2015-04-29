//
//  SR_SearchMainVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_SearchMainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
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
extension SR_SearchMainVC : UITableViewDataSource, UITableViewDelegate {
    /**
    根据indexPath 返回cell所需要显示的图片与title
    
    :param: indexPath table indexpath
    
    :returns: 图片名字 title 名字
    */
    func itemDataForTable(indexPath : NSIndexPath) -> (imageName : String , itemTitle: String)
    {
        var currentSection = indexPath.section
        switch currentSection
        {
        case 0:
            
            var currentRow = indexPath.row
            switch currentRow
            {
            case 0:
                return ("ablum","图集")
            case 1:
                return ("","标签")
            default:
                return ("ablum","图集")
            }
            
        case 1:
            
            var currentRow = indexPath.row
            switch currentRow
            {
            case 0:
                return ("friends","美甲师/普通用户")
            case 1:
                return ("","昵称")
            case 2:
                return ("","附近")
            default:
                return ("friends","美甲师/普通用户")
            }
        default:
            return ("","")
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 62
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 3
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var SSMainCell = tableView.dequeueReusableCellWithIdentifier(ZL_SSMainCell.cellID()) as ZL_SSMainCell
        var SSItemCell = tableView.dequeueReusableCellWithIdentifier(ZL_SSItemCell.cellID()) as ZL_SSItemCell
        if(indexPath.row == 0)
        {
            var imgName = self.itemDataForTable(indexPath).imageName
            var titleName = self.itemDataForTable(indexPath).itemTitle
            SSItemCell.imageItem.image = UIImage(named: imgName)
            SSItemCell.titleItem.text = titleName
            return  SSItemCell
        }else{
            var titleName = self.itemDataForTable(indexPath).itemTitle
            SSMainCell.itemTitle.text = titleName
            SSMainCell.itemTitle.textColor = UIColor.NailGrayColor()
            return SSMainCell
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 1:
                self.performSegueWithIdentifier("toLabelVC", sender: nil)
            default:
                ""
            }
        case 1:
            switch indexPath.row {
            case 1:
                self.performSegueWithIdentifier("toNickNameVC", sender: nil)
            case 2:
                self.performSegueWithIdentifier("toNeabyVC", sender: nil)
            default:
                ""
            }
        default:
            ""
        }
    }
}
