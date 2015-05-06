//
//  SR_ChangeOrderInfo.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/6.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_ChangeOrderInfoProtocol : class
{
    func changeNickName(nickName : String)
    func changeTel(tel : String)
    func changeAddress(address : String)
}

class SR_ChangeOrderInfo: UIViewController {

    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var changeInfoText: UITextField!
    
    var changeInfo : String?
    var changeType : Int!
    var delegate : SR_ChangeOrderInfoProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBarView.backgroundColor = UIColor.NailRedColor()
        changeInfoText.text = changeInfo
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        self.changeInfo = self.changeInfoText.text
        switch changeType {
        case 0:
            if let de = delegate
            {
                de.changeNickName(changeInfo!)
            }

        case 1:
            if let de = delegate
            {
                de.changeTel(changeInfo!)
            }
        case 2:
            if let de = delegate
            {
                de.changeAddress(changeInfo!)
            }
        default:
            ""
        }
        self.navigationController?.popViewControllerAnimated(true)
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

