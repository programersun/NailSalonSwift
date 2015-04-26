//
//  SR_protocolVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/13.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_protocolVC: UIViewController {
    
    @IBOutlet weak var protocolWebView: UIWebView!
    @IBOutlet weak var topBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBarView.backgroundColor = UIColor.NailRedColor()
        let fileURL = NSBundle.mainBundle().URLForResource("register_help", withExtension: "html")!
        let data = NSData(contentsOfURL: fileURL)
        protocolWebView.loadData(data, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: nil)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backAction(sender: AnyObject) {
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
