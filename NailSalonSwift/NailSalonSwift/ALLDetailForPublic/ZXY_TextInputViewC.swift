//
//  ZXY_TextInputViewC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/13.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_TextInputViewC: UIViewController {
    @IBOutlet weak var sendBtn: UIButton!

    @IBOutlet weak var commentText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendAction(sender: AnyObject) {
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
