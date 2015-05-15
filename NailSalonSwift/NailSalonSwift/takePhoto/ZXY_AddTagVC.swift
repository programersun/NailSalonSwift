//
//  ZXY_AddTagVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_AddTagVCDelegate : class
{
    func cancelClick()
    func sureClick(tags : [String])
}


class ZXY_AddTagVC: UIViewController {

    let screenSize : CGSize = UIScreen.mainScreen().bounds.size
    
    var delegate : ZXY_AddTagVCDelegate!
    
    var label : UILabel!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var heightOfTag: NSLayoutConstraint!
    @IBOutlet weak var currentTable: UITableView!
    @IBOutlet weak var currentTagLbl: ZXY_TagLabelView!
    
    @IBOutlet var commentView: UIView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var backgroudImg: UIImageView!
    
    @IBAction func cancelAction(sender: AnyObject) {
//        dataSelect = []
        currentTable.reloadData()
        self.resetTagV()
        delegate.cancelClick()
    }
    
   
    @IBAction func submitAction(sender: AnyObject) {
        var lala : [String] = []
        for var i = 0 ; i < dataSelect.count ; i++
        {
            var temp = dataSelect[i] as! String
            if(!dataArrCo.containsObject(temp))
            {
                if (!dataArrThe.containsObject(temp))
                {
                    if !dataArrHis.containsObject(temp)
                    {
                        dataArrHis.insertObject(temp, atIndex: 0)
                    }
                }
            }
            lala.append(temp)
        }
        if dataArrHis.count != 0
        {
            for var i = 0 ; i < dataArrHis.count ;i++
            {
                if i >= 10
                {
                    dataArrHis.removeObject(dataArrHis[i])
                }
            }
            
            var pathString = ZXY_DataProviderHelper.tagListFilePath()
            var dataForTableTemp = NSMutableDictionary(contentsOfFile: pathString)!
            dataForTableTemp["history"] = dataArrHis
            dataForTableTemp.writeToFile(pathString, atomically: true)
            dataForTable = NSMutableDictionary(contentsOfFile: pathString)!
            dataArrHis   = dataForTable["history"] as! NSMutableArray
            dataArrThe   = dataForTable["theme"] as! NSMutableArray
            dataArrCo   = dataForTable["color"] as! NSMutableArray
            currentTable.reloadData()

        }
        
        
        delegate.sureClick(lala)
    }
    
    
    
    
    
    
    var dataForTable : NSMutableDictionary = NSMutableDictionary()
    var dataArrHis      : NSMutableArray = NSMutableArray()
    var dataArrThe : NSMutableArray = NSMutableArray()
    var dataArrCo  : NSMutableArray = NSMutableArray()
    var dataSelect  : NSMutableArray = NSMutableArray()

    @IBAction func addBtnAction(sender: AnyObject) {
        self.label.hidden = false
        commentText.text = ""
        commentText.becomeFirstResponder()
    }
    @IBAction func inputBtnAction(sender: AnyObject) {
        var inputString = commentText.text
        if inputString.isEmpty
        {
        
        }
        else
        {
            var nsInput : NSString = NSString(format: "%@", inputString)
            var lalaArr = nsInput.componentsSeparatedByString(" ")
            for one in lalaArr
            {
                var temp : String = one as! String
                if dataSelect.containsObject(temp)
                {
                
                }
                else
                {
                    dataSelect.addObject(temp)
                }
            }
        }
        commentText.resignFirstResponder()
        self.resetTagV()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var pathString = ZXY_DataProviderHelper.tagListFilePath()
        dataForTable = NSMutableDictionary(contentsOfFile: pathString)!
        dataArrHis   = dataForTable["history"] as! NSMutableArray
        dataArrThe   = dataForTable["theme"] as! NSMutableArray
        dataArrCo   = dataForTable["color"] as! NSMutableArray
        addBtn.layer.cornerRadius = 5
        addBtn.layer.masksToBounds = true
        addBtn.layer.borderWidth = 1
        addBtn.layer.borderColor = UIColor.NailRedColor().CGColor
        currentTagLbl.lineWidth = UIScreen.mainScreen().bounds.width - 120
        commentView.frame = CGRectMake(0, screenSize.height , screenSize.width , 70)
        currentTagLbl.canClick = true
        currentTagLbl.delegate = self
        self.view.addSubview(commentView)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoardShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoradFrameChange:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyBoardHide:"), name: UIKeyboardWillHideNotification, object: nil)

        self.label = UILabel(frame: CGRectMake(5, 7, 200, 20))
        self.label.enabled = false
        self.label.text = "不同样式之间请输入空格..."
        self.label.font = UIFont.systemFontOfSize(14)
        self.label.textColor = UIColor.NailGrayColor()
        self.commentText.addSubview(self.label)
        self.commentText.delegate = self
        
        self.sendBtn.layer.borderColor = UIColor.NailRedColor().CGColor
        self.sendBtn.layer.borderWidth = 1
        self.sendBtn.layer.masksToBounds = true
        
        self.backgroudImg.layer.cornerRadius = 4
        self.backgroudImg.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }

    func keyBoardShow(noty : NSNotification)
    {
        var keyBoardInfo = noty.userInfo
        if let key = keyBoardInfo
        {
            var keyBoardValue : NSValue = key[UIKeyboardFrameEndUserInfoKey] as! NSValue
            var keyBoardHeight          = keyBoardValue.CGRectValue().origin.y
            var keyBoardShowDuration    = key[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            UIView.animateWithDuration(keyBoardShowDuration.doubleValue, animations: { [weak self]() -> Void in
                if let s = self
                {
                    self?.commentView.frame = CGRectMake(0,  keyBoardHeight - 154, s.screenSize.width, 70)
                }
                
                })
        }
        
    }
    
    func keyBoradFrameChange(noty: NSNotification)
    {
        var keyBoardInfo = noty.userInfo
        if let key = keyBoardInfo
        {
            var keyBoardValue : NSValue = key[UIKeyboardFrameEndUserInfoKey] as! NSValue
            var keyBoardHeight          = keyBoardValue.CGRectValue().origin.y
            var keyBoardShowDuration    = key[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
            UIView.animateWithDuration(keyBoardShowDuration.doubleValue, animations: { [weak self]() -> Void in
                if let s = self
                {
                    self?.commentView.frame = CGRectMake(0,  keyBoardHeight - 154, s.screenSize.width, 70)
                }
                
                })
        }
        
    }
    
    func keyBoardHide(noty : NSNotification)
    {
        UIView.animateWithDuration(0.5, animations: { [weak self]() -> Void in
            if let s = self
            {
                self?.commentView.frame = CGRectMake(0, s.screenSize.height, s.screenSize.width, 70)
            }
            
            })
        
    }

    
    func resetTagV()
    {
        var lala : [String] = []
        for var i = 0 ; i < dataSelect.count ; i++
        {
            var temp = dataSelect[i] as! String
            lala.append(temp)
        }
        currentTagLbl.setAllTagArr(lala)
        var height = currentTagLbl.getCellHeight()
        if height < 57
        {
            height = 57
        }
        heightOfTag.constant = height
        currentTagLbl.startLoadTag()
        currentTable.reloadData()
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

extension ZXY_AddTagVC : UITableViewDelegate , UITableViewDataSource , ZXY_TagLabelViewDelegate
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var section = indexPath.section
        var row     = indexPath.row
        let cell = tableView.dequeueReusableCellWithIdentifier(ZXY_SelectTagCell.cellID) as! ZXY_SelectTagCell
        var currentData : String = ""
        if dataArrHis.count == 0
        {
            if section == 0
            {
                currentData = dataArrThe[row] as! String
            }
            else
            {
                currentData = dataArrCo[row] as! String
            }
        }
        else
        {
            if section == 0
            {
                currentData = dataArrHis[row] as! String
            }
            else if section == 1
            {
                currentData = dataArrThe[row] as! String
            }
            else
            {
                currentData = dataArrCo[row] as! String
            }
        }
        cell.titleLbl.text = currentData
        if dataSelect.containsObject(currentData)
        {
            cell.selectBtn.selected = true
        }
        else
        {
            cell.selectBtn.selected = false
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArrHis.count == 0
        {
            if section == 0
            {
                return dataArrThe.count
            }
            else
            {
                return dataArrCo.count
            }
        }
        else
        {
            if section == 0
            {
                return dataArrHis.count
            }
            else if section == 1
            {
                return dataArrThe.count
            }
            else
            {
                return dataArrCo.count
            }

        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if dataArrHis.count == 0
        {
            return 2
        }
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame : CGRectMake(0 , 0 , UIScreen.mainScreen().bounds.width , 60))
        headerView.backgroundColor = UIColor.whiteColor()
        var labelV     = UILabel(frame : CGRectMake(20, 10, UIScreen.mainScreen().bounds.width - 40, 30))
        labelV.font = UIFont.systemFontOfSize(25)
        labelV.textColor = UIColor.NailRedColor()
        headerView.addSubview(labelV)
        if dataArrHis.count == 0
        {
            if section == 0
            {
                labelV.text = "主题"
            }
            else
            {
                labelV.text = "颜色"
            }
        }
        else
        {
            if section == 0
            {
                labelV.text = "历史"
            }
            else if section == 1
            {
                labelV.text = "主题"
            }
            else
            {
                labelV.text = "颜色"
            }
            
        }
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as! ZXY_SelectTagCell
        var tagString = cell.titleLbl.text!
        if dataSelect.containsObject(tagString)
        {
            dataSelect.removeObject(tagString)
        }
        else
        {
            dataSelect.addObject(tagString)
        }
        tableView.reloadData()
        self.resetTagV()
    }
    
    func clickTag(tagString: String) {
        if dataSelect.containsObject(tagString)
        {
            dataSelect.removeObject(tagString)
            currentTable.reloadData()
            self.resetTagV()
        }
    }
}

extension ZXY_AddTagVC : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if commentText.text.isEmpty {
            self.label.hidden = false
        }
        else {
            self.label.hidden = true
        }
    }
}
