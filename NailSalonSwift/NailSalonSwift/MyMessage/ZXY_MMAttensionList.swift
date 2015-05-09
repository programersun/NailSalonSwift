//
//  ZXY_MMAttensionList.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MMAttensionList: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    var dataForShow : [AnyObject]?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dataForShow = ZXY_DataProviderHelper.readAllFromDB(DNName: "AttensionNoti")
        self.currentTable.reloadData()
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

extension ZXY_MMAttensionList: UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("lala") as! UITableViewCell
        var currentData = dataForShow?[indexPath.row] as! AttensionNoti
        var imgV = cell.viewWithTag(222) as! UIImageView
        imgV.layer.cornerRadius = 25
        imgV.layer.masksToBounds = true
        var titleLbl = cell.viewWithTag(2222) as! UILabel
        var timeLbl  = cell.viewWithTag(22222) as! UILabel
        var statusString = "美甲师"
        if currentData.atten_role == "1"
        {
            statusString = "用户"
        }
        
        titleLbl.text = statusString + " " + currentData.atten_name + " 关注了你"
        timeLbl.text  = self.timeStampToDateString(currentData.atten_time)
        var imgString : String? = currentData.atten_avatar
        if let a = imgString
        {
            var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + a
            if a.hasPrefix("http")
            {
                imgURL = a
            }
            imgV.setImageWithURL(NSURL(string : imgURL))
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForShow?.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currentRow = indexPath.row
        var currentData = dataForShow?[indexPath.row] as! AttensionNoti
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var detailArtist = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as!ZXY_DFPArtistDetailVC
        detailArtist.artistID = currentData.atten_id
        self.navigationController?.pushViewController(detailArtist, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            var currentRow = indexPath.row
            
            var currentData = dataForShow?[indexPath.row] as! AttensionNoti
            ZXY_DataProviderHelper.deleteObject(DBName: "AttensionNoti", object: currentData)
            dataForShow?.removeAtIndex(currentRow)
            tableView.reloadData()
        }
    }
}
