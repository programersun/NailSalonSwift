//
//  ZXY_DFPArtDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtDetailVC: UIViewController {

    private var dataForComment : [AnyObject]?
    
    @IBOutlet weak var currentTable: UITableView!
    private var dataForTag : String? = "哈哈 啦啦 再见 你好么 冰雪消融 霸气凌峰 啦啦啦啦啦 悠悠 中文 是不是傻啊啊啊啊啊啊啊啊啊啊啊"

    var artWorkID : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startGetArtDetail()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        currentTable.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //currentTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startGetArtDetail()
    {
        var userID : String? = ZXY_UserInfoDetail.sharedInstance.getUserID() ?? ""
        var stringURL = ZXY_NailNetAPI.ZXY_ADFPAPI(ZXY_ADFPAPIType.ADFP_ArtDetail)
        var parameter = ["user_id" : userID , "album_id" : artWorkID]
        ZXY_NetHelperOperate().startGetDataPost(stringURL, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            ""
            ""
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

extension ZXY_DFPArtDetailVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var imgContentCell = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADImgContainerCell.cellID()) as ZXY_DFPADImgContainerCell
        var tagCell        = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADTagCell.cellID()) as ZXY_DFPADTagCell
        var commentCell    = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADCommentCell.cellID()) as
            ZXY_DFPADCommentCell
        
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        
        switch currentSection
        {
        case 0:
            return imgContentCell
        case 1:
            tagCell.setTagView(dataForTag)
            return tagCell
        case 2:
            return commentCell
        default :
            return imgContentCell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        switch currentSection
        {
        case 0:
            return 259
        case 1 :
            var tagV = ZXY_TagLabelView()
            tagV.allTags = dataForTag
            var tagViewHeight = tagV.getCellHeight()
            var cellHeight    = tagViewHeight + 44
            return cellHeight
        case 2:
            return 80
        default:
            return 80
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 1
        case 2 where dataForComment != nil:
            return dataForComment!.count
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
}

    
    

