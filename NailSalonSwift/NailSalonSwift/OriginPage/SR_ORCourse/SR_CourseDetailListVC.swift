//
//  SR_CourseDetailListVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_CourseDetailListVC: UIViewController {

    var courseType : String?
    var cateId : String?
    var pageCount : Int = 1
    
    @IBOutlet weak var courseDetilListTableView: UITableView!
    
    private var dataForShow : SR_courseDetilListBaseClass?
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = courseType
        self.navigationController?.toolbarHidden = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        courseDetilListTableView.delegate = self
        self.startLoadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //停止上拉下拉刷新
    private func endFreshing()
    {
        courseDetilListTableView.footerEndRefreshing()
        courseDetilListTableView.headerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforCollection()
    {
        courseDetilListTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.pageCount++
            self?.startLoadData()
        }
        
        courseDetilListTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
            self?.startLoadData()
        }
    }

    //加载数据
    func startLoadData(){
        srW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseDetailList)
        println("\(urlString)")
        var parameter : Dictionary<String , AnyObject > = ["cate_id" : cateId! ]
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter , successBlock: { [weak self](returnDic) -> Void in
            self?.dataForShow = SR_courseDetilListBaseClass(dictionary: returnDic )
            var result = self?.dataForShow?.result ?? 0
            if result == 1000
            {
                self?.courseDetilListTableView.reloadData()
                self?.endFreshing()
                if let s = self
                {
                    s.srW.hideProgress(s.view)
                }
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
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destinationViewController as SR_ORgetCourseVC
        destination.requestBlock = {[weak self]() -> Void in
            self?.courseDetilListTableView.reloadData()
            ""
        }
    }
    
}
extension SR_CourseDetailListVC : UITableViewDataSource , UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if UIDevice.isRunningOniPhone4s()
        {
            return 260
        }
        else
        {
            return 300
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let datas = dataForShow?.data
        {
            return datas.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_CourseDetailListCell.identifier) as SR_CourseDetailListCell
        cell.backgroundColor = UIColor.NailBackGrayColor()
        var cellData  = dataForShow?.data[indexPath.row] as SR_courseDetilListData?
        var imgUrl    = cellData?.imgPath as String?
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
        cell.courseIntroductionLabel.text = cellData?.desc
        cell.courseNameLabel.text         = cellData?.title
        cell.coursePraiseNum.text         = cellData?.starNum
        cell.courseCollectionNum.text     = cellData?.collectNum
        cell.courseNameLabel.textColor = UIColor.NailRedColor()
        cell.coursePraiseNum.textColor = UIColor.NailRedColor()
        cell.courseCollectionNum.textColor = UIColor.NailRedColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cellData  = dataForShow?.data[indexPath.row] as SR_courseDetilListData?
        var story = UIStoryboard(name: "SR_ORCourseStory", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("SR_ORgetCourseVCID") as SR_ORgetCourseVC
        vc.courseId = cellData?.dataIdentifier
        vc.title    = cellData?.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

