//
//  ZXY_DFPArtistTableVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol ZXY_DFPArtistTableVCDelegate : class
{
    func tableDidScroll(contentOffSet : CGPoint)
}

class ZXY_DFPArtistTableVC: UIViewController {

    
    var delegateL : ZXY_DFPArtistTableVCDelegate?
    @IBOutlet weak var currentTableV: UITableView!
    
    class func vcID() -> String
    {
        return "ZXY_DFPArtistTableVCID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension ZXY_DFPArtistTableVC : UITableViewDataSource ,UITableViewDelegate
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var currentSection = indexPath.section
        var emptyCell = tableView.dequeueReusableCellWithIdentifier("emptyCellID") as UITableViewCell
        var commentCell = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPArtistTableCell.cellID) as ZXY_DFPArtistTableCell
        if currentSection == 0
        {
           return emptyCell
        }
        else
        {
           return commentCell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return 10
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentSection = indexPath.section
        if currentSection == 0
        {
            return 211
        }
        else
        {
            return 128
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let de = delegateL
        {
            de.tableDidScroll(scrollView.contentOffset)
        }
    }
}
