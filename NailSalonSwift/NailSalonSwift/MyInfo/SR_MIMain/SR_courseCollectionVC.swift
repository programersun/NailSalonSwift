//
//  SR_courseCollectionVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_courseCollectionVC: UIViewController {
    
    var userID : String?
    var pageCount : Int = 1
    @IBOutlet weak var courseCollectionTableView: UITableView!
    private var dataForShow : NSMutableArray = NSMutableArray()
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        srW.startProgress(self.view)
        courseCollectionTableView.backgroundColor = UIColor.NailBackGrayColor()
        self.startLoadCourseCollectionData()
        self.addHeaderAndFooterforTable()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //停止上拉下拉刷新
    private func endFreshing()
    {
        courseCollectionTableView.footerEndRefreshing()
        courseCollectionTableView.headerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforTable()
    {
        courseCollectionTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.pageCount++
            self?.startLoadCourseCollectionData()
            ""
        }
        
        courseCollectionTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
            self?.startLoadCourseCollectionData()
            ""
        }
    }
    
    func startLoadCourseCollectionData()
    {
        var urlString = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseMyCollect)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: ["user_id" : self.userID! , "p" : pageCount], successBlock: { [weak self](returnDic) -> Void in
            var arr = SR_courseCollectionBaseClass(dictionary: returnDic).data
            if(self?.pageCount == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.courseCollectionTableView.footerEndRefreshing()
            self?.courseCollectionTableView.reloadData()
            if let s = self
            {
                s.srW.hideProgress(s.view)
            }
            }) {[weak self] (error) -> Void in
                self?.courseCollectionTableView.footerEndRefreshing()
                if let s = self
                {
                    s.srW.hideProgress(s.view)
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

extension SR_courseCollectionVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if UIDevice.isRunningOniPhone4s()
        {
            return 260
        }
        else
        {
            return 290
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataForShow.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_CourseDetailListCell.identifier) as SR_CourseDetailListCell
        cell.backgroundColor = UIColor.NailBackGrayColor()
        var cellData : SR_courseCollectionData = dataForShow[indexPath.row] as SR_courseCollectionData
        var imgUrl    = cellData.imgPath as String?
        if let url    = imgUrl
        {
            if (imgUrl!.hasPrefix("http"))
            {
                cell.courseImgView.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                cell.courseImgView.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
            }
        }
        cell.courseIntroductionLabel.text  = cellData.desc
        cell.courseNameLabel.text          = cellData.title
        cell.coursePraiseNum.text          = cellData.starNum
        cell.courseCollectionNum.text      = cellData.collectNum
        cell.courseNameLabel.textColor     = UIColor.NailRedColor()
        cell.coursePraiseNum.textColor     = UIColor.NailRedColor()
        cell.courseCollectionNum.textColor = UIColor.NailRedColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellData           = dataForShow[indexPath.row] as SR_courseCollectionData
        var story              = UIStoryboard(name: "SR_ORCourseStory", bundle: nil)
        var vc                 = story.instantiateViewControllerWithIdentifier("SR_ORgetCourseVCID") as SR_ORgetCourseVC
        vc.courseId            = cellData.dataIdentifier
        vc.title               = cellData.title
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

