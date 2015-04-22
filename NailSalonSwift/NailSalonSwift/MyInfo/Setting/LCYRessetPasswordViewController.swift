//
//  LCYRessetPasswordViewController.swift
//  KickYourAss
//
//  Created by sun on 15/4/21.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class LCYRessetPasswordViewController: UIViewController {
    
    @IBOutlet private weak var originalPasswordTextField: UITextField!
    @IBOutlet weak var originalPasswordLine: UIImageView!
    
    @IBOutlet private weak var newPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordLine: UIImageView!

    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLine: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func clearRedLines() {
        originalPasswordLine.image = UIImage(named: "textFieldBottomGray")
        newPasswordLine.image = UIImage(named: "textFieldBottomGray")
        confirmPasswordLine.image = UIImage(named: "textFieldBottomGray")
    }
    
    @IBAction func rightBtnClick(sender: AnyObject) {
        var oldPass = originalPasswordTextField.text
        var newPass = newPasswordTextField.text
        var newPass2 = confirmPasswordTextField.text
        func checkValid() -> Bool {
            if countElements(oldPass) == 0 {
                self.showAlertEasy("提示", messageContent: "请输入原始密码")
                return false
            }
            if countElements(oldPass) < 6 {
                self.showAlertEasy("提示", messageContent: "请输入6位以上的原始密码")
                return false
            }
            if countElements(newPass) == 0 {
                self.showAlertEasy("提示", messageContent: "请输入新密码")
                return false
            }
            if countElements(newPass) < 6 {
                self.showAlertEasy("提示", messageContent: "新密码至少要6位")
                return false
            }
            if newPass != newPass2 {
                self.showAlertEasy("提示", messageContent: "两次输入密码不一致")
                return false
            }
            return true
        }
        if checkValid() {
            var myUserID = ZXY_UserInfoDetail.sharedInstance.getUserID()
            var parameter : Dictionary<String , AnyObject> = [ "user_id" : myUserID! , "pass" : oldPass! , "rePass" : newPass! ]
            
            var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_ChangePassWordAPI
            ZXY_NetHelperOperate.sharedInstance.startGetDataPost(urlString, parameter: parameter, successBlock: { [weak self](returnDic) -> Void in
                var result = returnDic["result"] as Double
                if result == 1000 {
                    self?.showAlertEasy("提示", messageContent: "修改成功")
                    self?.navigationController?.popToRootViewControllerAnimated(true)
                } else {
                    var errorString = ZXY_ErrorMessageHandle.messageForErrorCode(result)
                    self?.showAlertEasy("提示", messageContent: errorString)
                }
                
            }, failBlock: { [weak self](error) -> Void in
                println(error)
                self?.showAlertEasy("提示", messageContent: "网络状况不好，请稍后重试")
            })
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
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

extension LCYRessetPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(textField: UITextField) {
        clearRedLines()
        if textField == originalPasswordTextField {
            originalPasswordLine.image = UIImage(named: "textFieldBottomRed")
        } else if textField == newPasswordTextField {
            newPasswordLine.image = UIImage(named: "textFieldBottomRed")
        } else if textField == confirmPasswordTextField {
            confirmPasswordLine.image = UIImage(named: "textFieldBottomRed")
        }
    }
}
