//
//  SR_LabelVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/28.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_LabelVC: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var rightBtn: UIBarButtonItem!
    var searchString : String?
    var pageCount : Int = 1
    var dataForShow : NSMutableArray = NSMutableArray()
    
    //加载动画
    let srW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor" )
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        searchText.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = false
    }

    //停止上拉下拉刷新
    private func endFreshing()
    {
        searchTableView.footerEndRefreshing()
        searchTableView.headerEndRefreshing()
    }
    /**
    为tableView 增加上拉加载下拉刷新
    */
    private func addHeaderAndFooterforTable()
    {
        searchTableView.addFooterWithCallback { [weak self]() -> Void in
            self?.pageCount++
            self?.loadLabelSearch()
            ""
        }
        
        searchTableView.addHeaderWithCallback { [weak self] () -> Void in
            self?.pageCount = 1
            self?.loadLabelSearch()
            ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func letfBtnClick(sender: AnyObject) {
        searchText.becomeFirstResponder()
    }

    @IBAction func rightBtnClick(sender: AnyObject) {
        searchText.resignFirstResponder()
        if searchIsEmpty() {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        else
        {
            srW.startProgress(self.searchTableView)
            self.loadLabelSearch()
        }
    }
    
    @IBAction func editSearch(sender: AnyObject) {
        println("\(searchText.text)")
        if searchIsEmpty() {
            rightBtn.title = "取消"
        }
        else
        {
            rightBtn.title = "搜索"
            self.addHeaderAndFooterforTable()
            srW.startProgress(self.searchTableView)
            self.loadLabelSearch()
        }
    }
    
    /**
        判断文本框的内容是否有值
        若为空rightBtn为取消
        若不为空rightBtn为搜索
    **/
    func searchIsEmpty() -> Bool{
        var nowSrting = searchText.text
        if nowSrting == ""{
            return true
        }
        else {
            return false
        }
    }
    
    //搜索图集
    func loadLabelSearch(){

        var urlString = ZXY_NailNetAPI.SR_SearchAPI(SR_SearchAPIType.SR_SearchLabel)
        searchString = searchText.text as String!
        println("\(searchString)+++")
        var parameter : Dictionary<String ,  AnyObject> = [ "search" : searchString!, "p" : pageCount]
        ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            var arr = SR_searchLabelBaseClass(dictionary: returnDic).data
            if(self?.pageCount == 1)
            {
                self?.dataForShow.removeAllObjects()
                self?.dataForShow.addObjectsFromArray(arr)
            }
            else
            {
                self?.dataForShow.addObjectsFromArray(arr)
            }
            self?.searchTableView.reloadData()
            self?.endFreshing()
            if let s = self
            {
                s.srW.hideProgress(s.searchTableView)
            }

        }) { [weak self](error) -> Void in
            println(error)
            self?.endFreshing()
            if let s = self
            {
                s.srW.hideProgress(s.searchTableView)
            }
            self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
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

extension SR_LabelVC : UITableViewDataSource, UITableViewDelegate {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForShow.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(SR_LabelCellVC.cellID()) as! SR_LabelCellVC
        cell.toolBar.backgroundColor = UIColor.NailRedColor()
        var cellData = dataForShow[indexPath.row] as! SR_searchLabelData
        //图集图片
        var imgUrl = cellData.image.cutPath as String?
        if let url    = imgUrl
        {
            if (imgUrl!.hasPrefix("http"))
            {
                cell.headImg.setImageWithURL(NSURL(string: imgUrl!), placeholderImage: UIImage(named: "imgHolder"))
            }
            else
            {
                var urlString = ZXY_NailNetAPI.ZXY_MainAPIImage + imgUrl!
                cell.headImg.setImageWithURL(NSURL(string: urlString), placeholderImage: UIImage(named: "imgHolder"))
            }
        }
        cell.headImg.layer.cornerRadius = 6
        cell.headImg.layer.masksToBounds = true
        //图集描述
        cell.ablumName.attributedText = cellData.dataDescription.rangeStringWithTarget(searchString ?? "")
        //用户昵称
        cell.nickName.attributedText = cellData.user.nickName.rangeStringWithTarget(searchString ?? "")
        //判断用户身份
        
        var type = cellData.user.role
        if type == "1" {
            cell.toolBar.hidden = true
            cell.isArtist.hidden = true
        }
        else
        {
            cell.toolBar.hidden = false
            cell.isArtist.hidden = false
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchText.resignFirstResponder()
        var currentData = dataForShow[indexPath.row] as!  SR_searchLabelData
        var albumID = currentData.albumId ?? ""
        var story = UIStoryboard(name: "PublicStory", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("artDetailID") as! ZXY_DFPArtDetailVC
        vc.artWorkID = albumID
        vc.title     = currentData.user.nickName
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
