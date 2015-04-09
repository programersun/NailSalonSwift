//
//  ZXY_LoginRegistVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/2.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_LoginRegistVCProtocol : class
{
    func userLoginSuccess() -> Void
}

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
    
    weak var delegate : ZXY_LoginRegistVCProtocol?
    private var parameter : Dictionary<String , String> = Dictionary<String , String>()
    let zxyW : ZXY_WaitProgressVC! = ZXY_WaitProgressVC()
    var userInfo : ZXY_UserInfoBase?
    
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
        if let dele = delegate
        {
            dele.userLoginSuccess()
        }
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
        zxyW.startProgress(self.view)
        var loginURL  = ZXY_NailNetAPI.ZXY_MyInfoAPI(ZXY_MyInfoAPIType.MI_Login)
        var parameter = ["user_name" : userNameText.text , "password": userPassText.text]
        ZXY_NetHelperOperate().startGetDataPost(loginURL, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.userInfo = ZXY_UserInfoBase(dictionary: returnDic)
            var result = self?.userInfo?.result
            if(result == 1000 || result == 1008)
            {
                self?.loginEaseMob()
                
            }
            else
            {
                if let s = self
                {
                    s.zxyW.hideProgress(s.view)
                }
                if(result == nil)
                {
                    return
                }
                var errorMessage = ZXY_ErrorMessageHandle.messageForErrorCode(result!)
                self?.showAlertEasy("提示", messageContent: errorMessage)
            }
        }) {[weak self] (error) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
            }
        }
    }
    
    private func loginEaseMob() -> Void
    {
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(userInfo!.data.userId, password: "123456", completion: { [weak self](object, error) -> Void in
            if let s = self
            {
                s.zxyW.hideProgress(s.view)
                var userId = s.userInfo?.data.userId
                ZXY_UserInfoDetail.sharedInstance.saveUserID(userId!)
                ZXY_UserInfoDetail.sharedInstance.saveMeiJiaUser(s.userInfo!)
                
            }
            self?.navigationController?.popViewControllerAnimated(true)
        }, onQueue: nil)
    }
    
    @IBAction func registAction(sender: AnyObject)
    {
        self.performSegueWithIdentifier("toRegistVC", sender: nil)
    }
    
    @IBAction func tencentLoginAction(sender: AnyObject)
    {
        UMSocialQQHandler.setQQWithAppId(ZXY_ConstValue.QQAPPID.rawValue, appKey: ZXY_ConstValue.QQAPPKEY.rawValue, url: "http://www.umeng.com/social")
        var platForm = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
        platForm.loginClickHandler(self ,UMSocialControllerService.defaultControllerService() ,true ,{(responses) -> Void in
            var res : UMSocialResponseEntity = responses as UMSocialResponseEntity
            var resCode : UMSResponseCode = res.responseCode as UMSResponseCode
            
            if(resCode.value == UMSResponseCodeSuccess.value)
            {
                var userEntity: UMSocialAccountEntity? = UMSocialAccountManager.socialAccountDictionary()[UMShareToSina] as? UMSocialAccountEntity
                if let userMust = userEntity
                {
                    self.authSuccessMethod(userMust , platformName: "qq")
                }

            }
            else
            {
                println("\(resCode)")
            }
        })
        
    }
    
    @IBAction func weiBoLoginAction(sender: AnyObject)
    {
        var platForm = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina)
        platForm.loginClickHandler(self ,UMSocialControllerService.defaultControllerService() ,true ,{(responses) -> Void in
            var res : UMSocialResponseEntity = responses as UMSocialResponseEntity
            var resCode : UMSResponseCode = res.responseCode as UMSResponseCode
            
            if(resCode.value == UMSResponseCodeSuccess.value)
            {
                var userEntity: UMSocialAccountEntity? = UMSocialAccountManager.socialAccountDictionary()[UMShareToSina] as? UMSocialAccountEntity
                if let userMust = userEntity
                {
                    self.authSuccessMethod(userMust , platformName: "sina")
                }
            }
            else
            {
                println("\(resCode)")
            }
        })

    }
    
    private func authSuccessMethod(entity : UMSocialAccountEntity , platformName : String)
    {
        var userID                  = entity.usid
        var userName                = entity.userName
        var userHeadImg : String?   = entity.iconURL
        var platName                = platformName
        parameter["uid"]            = userID
        parameter["nick_name"]      = userName
        parameter["head_image"]     = userHeadImg ?? ""
        parameter["sex"]            = "0"
        parameter["third_name"]     = platformName
        var alertSex = UIAlertView(title: "", message: "选择角色", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "普通用户","美甲师")
        alertSex.show()
        
    }
    
    @IBAction func backAction(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
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
}

extension ZXY_LoginRegistVC: UIAlertViewDelegate
{
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        println("\(buttonIndex)")
        if(buttonIndex == 0)
        {
            parameter["role"] = "1"
        }
        else
        {
            parameter["role"] = "2"
        }
        self.zxyW.startProgress(self.view)
        var urlString = ZXY_NailNetAPI.ZXY_MyInfoAPI(ZXY_MyInfoAPIType.MI_ThirdLogin)
        ZXY_NetHelperOperate().startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
            self?.userInfo = ZXY_UserInfoBase(dictionary: returnDic)
            var result = self?.userInfo?.result
            if(result == 1000 || result == 2040)
            {
                self?.loginEaseMob()
                
            }
            else
            {
                if let s = self
                {
                    s.zxyW.hideProgress(s.view)
                }
                if(result == nil)
                {
                    return
                }
                var errorMessage = ZXY_ErrorMessageHandle.messageForErrorCode(result!)
                self?.showAlertEasy("提示", messageContent: errorMessage)
            }

        }) { [weak self](error) -> Void in
            ""
            ""
            if let se = self
            {
                se.zxyW.hideProgress(se.view)
            }
        }
    }
}

extension ZXY_UserInfoDetail
{
    func saveMeiJiaUser(user : ZXY_UserInfoBase)
    {
        NSUserDefaults.standardUserDefaults().setObject(user, forKey: "userInfo")
    }
    
    func getMeiJiaUser() -> ZXY_UserInfoBase?
    {
        var users: ZXY_UserInfoBase? = NSUserDefaults.standardUserDefaults().objectForKey("userInfo") as? ZXY_UserInfoBase
        return users
    }
}
