//
//  ZXY_ORCourseVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/31.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORCourseVC: UIViewController {

    @IBOutlet weak var currentTable: UITableView!
    private var dataForTable: ZXYCourseBaseList?
    private var dataCourseList : [ZXYCourseData]? = []
    @IBOutlet weak var courceImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLoadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func startLoadData()
    {
        var urlString = ZXY_NailNetAPI.ZXY_MainCourseAPI(ZXY_MainCourseAPIType.CourseCategoryList)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: nil, successBlock: {[weak self] (returnDic) -> Void in
            
            self?.dataForTable = ZXYCourseBaseList(dictionary: returnDic)
            if(self?.dataForTable == nil)
            {
                return
            }
            var result = self?.dataForTable?.result
            if(result == nil)
            {
                return
            }
            if(result == 1000)
            {
                if let realSelf = self
                {
                    realSelf.dataCourseList = []
                    for value in realSelf.dataForTable!.data
                    {
                        var courseValue: ZXYCourseData = value as ZXYCourseData
                        realSelf.dataCourseList?.append(courseValue)
                        realSelf.currentTable.reloadData()
                    }
                }
            }
            else
            {
                var alertString = ZXY_ErrorMessageHandle.messageForErrorCode(result!)
                self?.showAlertEasy("提示", messageContent: alertString)
            }
            
            
        }) {[weak self] (error) -> Void in
            ""
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

extension ZXY_ORCourseVC : UITableViewDelegate , UITableViewDataSource
{
    enum CourseType : Int
    {
        case CourseTypeFS = 0
        case CourseTypeSH = 1
        case CourseTypeGL = 2
        case CourseTypeXN = 3
        case CourseTypeDH = 4
        case CourseTypeKA = 5
        case CourseTypeJB = 6
        
        /**
        根据参教程类型返回图片名称、教程名称
        
        :param: type 教程类型
        
        :returns: 第一个参数代表图片名称、第二个参数代表教程名称
        */
        static func parameterToCourseType(type : Int) -> String
        {
            switch type
            {
            case 0:
                return "法式"
            case 1:
                return "手绘"
            case 2:
                return "光疗"
            case 3:
                return "新娘"
            case 4:
                return "雕花"
            case 5:
                return "可爱"
            case 6:
                return "渐变"
            default:
                return "法式"
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var firstCell = tableView.dequeueReusableCellWithIdentifier(ZXY_ORCourseMainFirstCell.cellID()) as ZXY_ORCourseMainFirstCell
        firstCell.headerTitleLbl.textColor = UIColor.NailRedColor()
        firstCell.headerSubTitleLbl.textColor = UIColor.NailGrayColor()
        
        var secondCell = tableView.dequeueReusableCellWithIdentifier(ZXY_ORCourseMainSecondCell.cellID()) as ZXY_ORCourseMainSecondCell
        secondCell.headerTitleLbl.textColor = UIColor.NailRedColor()
        secondCell.headerSubTitle.textColor = UIColor.NailGrayColor()
        
        var thirdCell  = tableView.dequeueReusableCellWithIdentifier(ZXY_ORCourseMainThirdCell.cellID()) as ZXY_ORCourseMainThirdCell
        thirdCell.headerTitleLbl.textColor = UIColor.NailRedColor()
        thirdCell.headerSubTitle.textColor = UIColor.NailGrayColor()
        
        var currentData = dataCourseList![indexPath.row]
        var url: String?     = currentData.imgPath
        var imgURL : String  = ""
        if let urlString = url
        {
            imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + urlString
        }
        
        var courses: [ZXYCourseCourse]? = []
        for value in currentData.course
        {
            var dataCourse: ZXYCourseCourse = value as ZXYCourseCourse
            courses?.append(dataCourse)
        }
        
        var titleLbl = CourseType.parameterToCourseType(indexPath.row)
        
        switch indexPath.row
        {
        case 0 , 3 ,6:
            firstCell.littleBar.backgroundColor = UIColor.NailRedColor()
            firstCell.headerImg.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "headerHolder"))
            firstCell.headerImg.layer.cornerRadius = CGRectGetWidth(firstCell.headerImg.bounds) / 2
            firstCell.headerImg.layer.borderColor = UIColor.NailRedColor().CGColor
            firstCell.headerSubTitleLbl.text    = titleLbl
            firstCell.headerTitleLbl.text       = titleLbl
            firstCell.setImgs(courses)
            return firstCell
        case 1 , 4:
            secondCell.littleBar.backgroundColor = UIColor.NailRedColor()
            secondCell.headerSubTitle.text    = titleLbl
            secondCell.headerTitleLbl.text       = titleLbl
            secondCell.setImgs(courses)
            secondCell.headerImg.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "headerHolder"))
            secondCell.headerImg.layer.cornerRadius = CGRectGetWidth(secondCell.headerImg.bounds) / 2
            secondCell.headerImg.layer.borderColor = UIColor.NailRedColor().CGColor
            return secondCell
        case 2 , 5:
            thirdCell.littleBar.backgroundColor = UIColor.NailRedColor()
            thirdCell.headerSubTitle.text    = titleLbl
            thirdCell.headerTitleLbl.text       = titleLbl
            thirdCell.setImgs(courses)
            thirdCell.headerImg.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "headerHolder"))
            thirdCell.headerImg.layer.cornerRadius = CGRectGetWidth(thirdCell.headerImg.bounds) / 2
            thirdCell.headerImg.layer.borderColor = UIColor.NailRedColor().CGColor
            return thirdCell
        default:
            firstCell.littleBar.backgroundColor = UIColor.NailRedColor()
            firstCell.headerSubTitleLbl.text    = titleLbl
            firstCell.headerTitleLbl.text       = titleLbl
            firstCell.setImgs(courses)
            firstCell.headerImg.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "headerHolder"))
            firstCell.headerImg.layer.cornerRadius = CGRectGetWidth(firstCell.headerImg.bounds) / 2
            firstCell.headerImg.layer.borderColor = UIColor.NailRedColor().CGColor
            return firstCell
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCourseList?.count ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if UIDevice.isRunningOniPhone4s()
        {
            return 240
        }
        else
        {
            return 290
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var type = CourseType.parameterToCourseType(indexPath.row)
        var story = UIStoryboard(name: "SR_ORCourseStory", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("SR_CourseDetailListVCID") as SR_CourseDetailListVC
        vc.courseType = type
        var courseData = dataCourseList![indexPath.row]
        vc.cateId    = courseData.cateId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
