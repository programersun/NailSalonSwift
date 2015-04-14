//
//  ZXY_SheetView.swift
//  ZXYPrettysHealth
//
//  Created by 宇周 on 15/1/16.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_SheetViewDelegate : class
{
    /**
    sheet点击代理时间
    
    :param: sheetView 所创建的sheetView 实例
    :param: index     非负表示用户点击按钮 ，-1表示点击取消
    
    :returns: 返回空
    */
    func clickItemAtIndex(sheetView: ZXY_SheetView,index: Int) -> Void
}

class ZXY_SheetView: UIView {
    private var titleString : String?
    private var cancelString: String?
    private var listString  : [String]?
    private var currentTable : UITableView!
    private var imgBack      : UIImageView?
    private var tableHeight = 30.0
    private var _parentView : UIView?
    private var backCo  =  UIColor(red: 218/255.0, green: 214/255.0, blue: 218/255.0, alpha: 1)
    weak var delegate : ZXY_SheetViewDelegate?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    /**
    实例化方法
    
    :param: zxyTitle  标题 设置为nil
    :param: cancelBtn 取消按钮的标题
    :param: messages  需要显示的按钮的文字聊表
    
    :returns: 实例
    */
    init(zxyTitle : String?,cancelBtn: String?,andMessage messages : [String]) {
        super.init(frame: UIScreen.mainScreen().bounds)
        self.backgroundColor = UIColor.lightGrayColor()
        self.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.0)
        self.opaque = true
        self.clipsToBounds = true
        self.titleString = zxyTitle
        self.cancelString = cancelBtn
        self.listString = messages
        if let isNil = currentTable
        {
        
        }
        else
        {
            currentTable                = UITableView()
            currentTable.backgroundColor = self.backCo
            currentTable.separatorStyle = UITableViewCellSeparatorStyle.None
            currentTable.delegate       = self
            currentTable.dataSource     = self
            currentTable.bounces        = false
            currentTable.registerClass(ZXY_SheetViewCell.self, forCellReuseIdentifier: ZXY_SheetViewCellID)
            currentTable.tableFooterView = UIView(frame: CGRectZero)
            self.addSubview(currentTable)
        }
    }

    func setBackCo(backCO : UIColor)
    {
        self.backCo = backCO
    }
    
    func getTableHeight() -> CGFloat
    {
        var currentHeight : CGFloat = 20
        if(titleString != nil)
        {
            
            currentHeight += 50
        }
        
        if(cancelString != nil)
        {
            currentHeight += 50
        }
        
        for var i = 0; i < listString?.count ;i++
        {
            currentHeight += 50
        }
        
        if(currentHeight > self.frame.size.height)
        {
            return 600
        }
        else
        {
            return currentHeight
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
    显示sheet
    
    :param: parentV 父类视图
    */
    func showSheet(parentV : UIView) -> Void
    {
        self._parentView = parentV
        self.frame  = CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        if(imgBack == nil)
        {
            imgBack = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
            imgBack?.userInteractionEnabled = true
        }
        imgBack?.backgroundColor = UIColor.blackColor()
        imgBack?.alpha = 0
        parentV.addSubview(imgBack!)
        var tapImg = UITapGestureRecognizer(target: self, action: Selector("tapImageMethod"))
        self.addGestureRecognizer(tapImg)
        currentTable.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height-self.getTableHeight(), UIScreen.mainScreen().bounds.size.width, self.getTableHeight())
        parentV.addSubview(self)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {[weak self] () -> Void in
            self?.imgBack?.alpha = 0.4
            self?.frame  = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        }) { (Bool) -> Void in
            
        }
    }
    
    func tapImageMethod() -> Void
    {
        if let isNil = _parentView
        {
            self.hideSheet(self._parentView!)
        }
        else
        {
            assert({
                    self._parentView == nil
                }(), {
                "Parent view is nil"
            }())
        }
    }
    
    func hideSheet(parentV : UIView?)
    {
        if(parentV == nil)
        {
            return
        }
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {[weak self] () -> Void in
            self?.imgBack?.alpha = 0
            if var isNil = self?._parentView
            {
                self?.frame  = CGRectMake(0, UIScreen.mainScreen().bounds.size.height, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
            }
            
            }) { [weak self](Bool) -> Void in
                self?.removeFromSuperview()
                self?.imgBack?.removeFromSuperview()
        }    }
}

extension ZXY_SheetView :UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_SheetViewCellID) as ZXY_SheetViewCell
        cell.backgroundColor = backCo
        if(currentSection == 0)
        {
            cell.setBtnString(titleString)
            cell.setCurrentIndex(-2)
        }
        else if(currentSection == 1)
        {
            cell.setBtnString(listString![currentRow])
            cell.setCurrentIndex(currentRow)
        }
        else
        {
            cell.setBtnString(cancelString)
            cell.setCurrentIndex(-1)
            cell.setBackColor(UIColor.lightGrayColor())
            cell.setTxTColor(UIColor.whiteColor())
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if(section == 1)
        {
            return 10
        }
        else if(section == 2)
        {
           return 10
        }
        
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            if(titleString == nil)
            {
                return 0
            }
            return 1
        }
        else if (section == 1)
        {
            if let isNil = listString
            {
                return listString!.count
            }
            else
            {
                return 0
            }
        }
        else
        {
            if(cancelString == nil)
            {
               return 0
            }
            return 1
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var curr: UIView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, 15))
        curr.backgroundColor = backCo
        return curr
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
}

extension ZXY_SheetView : SheetViewCellDelegate
{
    func clickButtonWithIndex(index: Int) {
        if(self.delegate != nil)
        {
           self.delegate?.clickItemAtIndex(self, index: index)
        }
        self.tapImageMethod()
    }
}
