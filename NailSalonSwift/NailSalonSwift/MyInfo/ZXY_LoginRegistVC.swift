//
//  ZXY_LoginRegistVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_LoginRegistVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userPassText: UITextField!
    @IBOutlet weak var forgetPassBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registBtn: UIButton!
    @IBOutlet weak var miQQBtn: UIButton!
    @IBOutlet weak var miWBBtn: UIButton!
    @IBOutlet weak var miQQLbl: UILabel!
    @IBOutlet weak var miWBLbl: UILabel!
    var zxyW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startInitColor()
        self.startInitCorner()
        self.titleLbl.text = "登陆"
        // Do any additional setup after loading the view.
    }

    func startInitColor()
    {
        self.mainScroll.backgroundColor = UIColor.NailBackGrayColor()
        self.forgetPassBtn.setTitleColor(UIColor.NailGrayColor(), forState: UIControlState.Normal)
        miQQLbl.textColor = UIColor.NailGrayColor()
        miWBLbl.textColor = UIColor.NailGrayColor()
        loginBtn.backgroundColor = UIColor.NailRedColor()
        registBtn.backgroundColor = UIColor.NailOrange()
    }
    
    func startInitCorner()
    {
        self.loginBtn.layer.cornerRadius = 5
        self.registBtn.layer.cornerRadius = 5
        
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

extension ZXY_LoginRegistVC : UITextFieldDelegate
{
    
    @IBAction func forgetPassAction(sender: AnyObject)
    {
        zxyW.startProgress(self.view)
    }
    
    @IBAction func loginAction(sender: AnyObject)
    {
        if(self.userNameText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) != 11)
        {
            self.showAlertEasy("提示", messageContent: "请输入正确的手机号码")
            return
        }
        
        if(self.userPassText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
        {
            self.showAlertEasy("提示", messageContent: "请输入密码")
            return
        }
        
        var loginURL  = ZXY_NailNetAPI.ZXY_MyInfoAPI(ZXY_MyInfoAPIType.MI_Login)
        var parameter = ["user_name" : userNameText.text , "password": userPassText.text]
        ZXY_NetHelperOperate().startGetDataPost(loginURL, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            ""
            ""
        }) { (error) -> Void in
            ""
            ""
        }
    }
    
    @IBAction func registAction(sender: AnyObject)
    {
        
    }
    
    @IBAction func tencentLoginAction(sender: AnyObject)
    {
        
    }
    
    @IBAction func weiBoLoginAction(sender: AnyObject)
    {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var length = self.userNameText.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        if(length >= 11)
        {
            if(string == "")
            {
                return true
            }
            return false
        }
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        zxyW.hideProgress(self.view)
    }
    
}
