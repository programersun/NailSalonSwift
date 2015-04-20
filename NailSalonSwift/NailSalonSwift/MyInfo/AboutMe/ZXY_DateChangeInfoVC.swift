//
//  ZXY_DateChangeInfoVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/10.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

@objc protocol ZXY_DateChangeInfoVCDelegate : class
{
    func afterChange(sendKey : String , andValue sendValue: String)
    optional func changeSex(sexFlag : Int)
}


class ZXY_DateChangeInfoVC: UIViewController {


    
    @IBOutlet weak var currentTable: UITableView!
    private var infoText : UITextField?
    private var initTitle : String!
    private var initValue : AnyObject?
    
    
    weak var delegate : ZXY_DateChangeInfoVCDelegate?
    
    var currentDic : Dictionary<String , AnyObject?>?
    
    var isInput    : Bool = true
    
    var sexFlag    = 1
    
    var sexString  = "男"
    
    var isInputNum = false
    
    /**
    用来修改预约的页面
    
    :param: valueDic 包含title warn tag
    */
    func setCurrentTypeDic(valueDic : Dictionary<String , AnyObject?>)
    {
        currentDic = valueDic
    }
    
    func setIsInput(isInput : Bool)
    {
        self.isInput = isInput
    }
    
    func setIsInputNum(isInputNum : Bool)
    {
        self.isInputNum = isInputNum
    }
    
    func setInitValueAndTitle(initKey : String , initValue : AnyObject?)
    {
       self.initTitle = initKey
       self.initValue = initValue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTable.tableFooterView = UIView(frame: CGRectZero)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func rightNaviButtonAction() {
        var keyString : String?  = currentDic?["title"]? as? String
        if(keyString != nil)
        {
            if(self.delegate != nil)
            {
                if(isInput)
                {
                    self.delegate!.afterChange(keyString!, andValue: infoText!.text)
                }
                else
                {
                    self.delegate!.afterChange(keyString!, andValue:sexString)
                    self.delegate!.changeSex!(sexFlag)
                }
            }
            self.navigationController?.popViewControllerAnimated(true)
        }
        else
        {
            
            if(!isInput)
            {
                self.delegate!.afterChange(self.initTitle, andValue: "\(sexFlag)")
                self.delegate!.changeSex?(sexFlag)
            }
            else
            {
                self.delegate!.afterChange(self.initTitle, andValue: infoText!.text)
            }
            self.navigationController?.popViewControllerAnimated(true)
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
    @IBAction func backAction(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    @IBAction func doneAction(sender: AnyObject)
    {
        println("Hello")
        rightNaviButtonAction()
    }
    
    
}

extension ZXY_DateChangeInfoVC : UITableViewDelegate ,UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ChangeDateInfoCellID) as ZXY_ChangeDateInfoCell
            self.infoText = cell.infoText
            
            if(isInputNum)
            {
                self.infoText?.keyboardType = UIKeyboardType.NumberPad
            }

            return cell
        }
//        else
//        {
//            var cell = tableView.dequeueReusableCellWithIdentifier(ZXY_ChangeUserSexCellID) as ZXY_ChangeUserSexCell
//            cell.userSelectBoyOrGirlBlock = {[weak self](flag) -> Void in
//                self?.sexFlag = flag
//                if(flag == 2)
//                {
//                    self?.sexString = "女"
//                }
//                else
//                {
//                    self?.sexString = "男"
//                }
//                return
//            }
//            
//            return cell
//        }
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(isInput)
        {
            return 72
        }
        else
        {
            return 181
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
