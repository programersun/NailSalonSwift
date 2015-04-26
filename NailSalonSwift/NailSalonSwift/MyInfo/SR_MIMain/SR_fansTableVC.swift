//
//  SR_fansTableVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/25.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_fansTableVC: UITableViewController {
    
    @IBOutlet var attentionTableView: UITableView!
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    private var dataForTable : SR_FansBaseClass?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHeaderAndFooterforTable()
        srW.startProgress(self.view)
        self.startLoadFansData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        
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
        if let datas = dataForTable?.data
        {
            return datas.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_attentionTableCellVC.cellId) as SR_attentionTableCellVC
        cell.toolView.backgroundColor = UIColor.NailRedColor()
        var cellData  = dataForTable?.data[indexPath.row] as SR_FansData
        //美甲师头像
        var imgUrl    = cellData.headImage as String?
        if let url    = imgUrl
        {
            if (imgUrl!.hasPrefix("http"))
            {
                cell.headImgView.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                cell.headImgView.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
            }
        }
        
        //美甲师姓名
        cell.userName.text = cellData.nickName
        
        //作品数量
        cell.userWorkCount.text = cellData.albumCount
        
        var scoreNSString : NSString = NSString(format: "%@", cellData.score)
        var doubleScore   = scoreNSString.doubleValue
        cell.starRateView?.scorePercent = CGFloat(doubleScore/5.0)
        //判断用户身份
        var type = cellData.role
        if type == "1" {
            cell.toolView.hidden = true
            cell.isArtist.hidden = true
        }        // Configure the cell...

        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellData  = dataForTable?.data[indexPath.row] as SR_FansData
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("ZXY_DFPArtistDetailVCID") as ZXY_DFPArtistDetailVC
        vc.artistID = cellData.userId
        self.navigationController?.pushViewController(vc, animated: true)
    }

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

    //停止上拉下拉刷新
    private func endFreshing()
    {
        attentionTableView.footerEndRefreshing()
        attentionTableView.headerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforTable()
    {
        attentionTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.startLoadFansData()
            ""
        }
        
        attentionTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.startLoadFansData()
            ""
        }
    }
    func startLoadFansData(){
        var userID = ZXY_UserInfoDetail.sharedInstance.getUserID()
        var urlString = ZXY_NailNetAPI.SR_AttentionAPI(SR_AttentionAPIType.SR_Fans)
        var parameter : Dictionary<String ,  AnyObject> = [ "user_id" : userID!]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            
                        self?.dataForTable = SR_FansBaseClass(dictionary: returnDic)
                        var result = self?.dataForTable?.result ?? 0
                        if result == 1000
                        {
                            self?.attentionTableView.reloadData()
                            self?.endFreshing()
                        }
                        else
                        {
                            var errorMessage = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                            self?.showAlertEasy("提示", messageContent: errorMessage)
                            self?.endFreshing()
                        }
                        if let s = self
                        {
                            s.srW.hideProgress(s.view)
                        }
            }) { [weak self](error) -> Void in
                println(error)
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
                self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
                ""
        }
        
    }

}
