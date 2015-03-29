//
//  ZXY_SegBtnVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_SegBtnVC: UIViewController {

    typealias ZXY_SegBtnVCBlock = () -> Void
    
    @IBOutlet weak var segFirstItem: UIButton!
    @IBOutlet weak var segSecondItem: UIButton!
    
    var firstItemAction : ZXY_SegBtnVCBlock?
    var secondItemAction : ZXY_SegBtnVCBlock?
    
    @IBOutlet weak var secondImg: UIImageView!
    
    @IBOutlet weak var firstImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func firstAction(sender: AnyObject) {
        if let first = firstItemAction
        {
            first()
        }
        firstImg.hidden  = false
        secondImg.hidden = true
    }

    @IBAction private func secondAction(sender: AnyObject) {
        if let second = secondItemAction
        {
            second()
        }
        firstImg.hidden  = true
        secondImg.hidden = false
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
