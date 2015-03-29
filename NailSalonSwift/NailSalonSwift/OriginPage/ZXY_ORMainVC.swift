//
//  ZXY_ORMainVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORMainVC: UIViewController {
    private var segV : ZXY_SegBtnVC?
    private var squreVC : ZXY_ORSqureVC?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startInitSegmentControl()
        self.startInitSqureVC()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func startInitSegmentControl()
    {
        segV = ZXY_SegBtnVC()
        var nib = UINib(nibName: "ZXY_SegBtnVC", bundle: nil)
        var view = nib.instantiateWithOwner(segV, options: nil)[0] as UIView
        segV?.segFirstItem.setTitle("广场", forState: UIControlState.Normal)
        segV?.segSecondItem.setTitle("教程", forState: UIControlState.Normal)
        segV?.firstItemAction = {() -> Void in
            println("1")
        }

        segV?.secondItemAction = {() -> Void in
            println("2")
        }

        self.navigationItem.titleView = view
    }
    
    private func startInitSqureVC()
    {
        squreVC = UIStoryboard(name: "OriginPageStory", bundle: nil).instantiateViewControllerWithIdentifier("orSqureID") as? ZXY_ORSqureVC
        self.addChildViewController(squreVC!)
        self.view.addSubview(squreVC!.view)
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
