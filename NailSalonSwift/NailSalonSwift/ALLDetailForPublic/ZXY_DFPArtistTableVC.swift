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

    var isDownload = false
    var userID : String?
    private var dataForShow : NSMutableArray = NSMutableArray()
    var currentPage : Int = 1
    var delegateL : ZXY_DFPArtistTableVCDelegate?
    @IBOutlet weak var currentTableV: UITableView!
    
    class func vcID() -> String
    {
        return "ZXY_DFPArtistTableVCID"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDownLoadOrderInfo()
        currentTableV.addFooterWithCallback {[weak self] () -> Void in
            self?.currentPage++
            self?.startDownLoadOrderInfo()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func startDownLoadOrderInfo()
    {
        self.currentTableV.footerEndRefreshing()
        if userID == nil
        {
            return
        }
        if(isDownload)
        {
            return
        }
        isDownload = true
        var stringURL = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_UserCommentAPI
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: ["user_id": userID! , "p" : currentPage], successBlock: {[weak self] (returnDic) -> Void in
            var returnData = ZXY_UserCommentBase(dictionary: returnDic).data
            if(self?.currentPage == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(returnData)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(returnData)
            }
            self?.currentTableV.reloadData()
            self?.currentTableV.footerEndRefreshing()
            }) {[weak self] (error) -> Void in
                self?.currentTableV.footerEndRefreshing()
                ""
                
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
            var currentUser : ZXY_UserCommentData = dataForShow[indexPath.row] as ZXY_UserCommentData
            var stringURL: String? = currentUser.headImage?
            if let url = stringURL
            {
                var headURL = ZXY_NailNetAPI.ZXY_MainAPIImage + url
                if(url.hasPrefix("http"))
                {
                    headURL = currentUser.headImage
                }
                commentCell.criticAvatar.setImageWithURL(NSURL(string: headURL), placeholderImage: UIImage(named: "headImg"))
            }
            
            var imgURL: String? = currentUser.imagePath?
            if let urlString = imgURL
            {
                commentCell.artImg.hidden = false
                var downImg = ZXY_NailNetAPI.ZXY_MainAPIImage + urlString
                commentCell.artImg.setImageWithURL(NSURL(string: downImg), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                commentCell.artImg.hidden = true
            }
            
            commentCell.commentLbl.text = currentUser.comment ?? ""
            commentCell.addTime.text    = self.timeStampToDateString(currentUser.ctime)
            commentCell.criticName.text = currentUser.nickName ?? ""
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
            return dataForShow.count
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        if currentSection == 0
        {
            return 179
        }
        else
        {
            var currentUser : ZXY_UserCommentData = dataForShow[indexPath.row] as ZXY_UserCommentData
            var imgURL : String? = currentUser.imagePath?
            var commentContent = currentUser.comment ?? ""
            var constraintWith = UIScreen.mainScreen().bounds.width - 83
            var labelHeight = UIViewController.getCellHeightWith(textString: commentContent, minHeight: 21, fontSize: UIFont.systemFontOfSize(17), constraintWidth: constraintWith)
            
            if let stringURL = imgURL
            {
                return 107 + labelHeight
            }
            else
            {
                return 79 + labelHeight
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if let de = delegateL
        {
            de.tableDidScroll(scrollView.contentOffset)
        }
    }
}
