//
//  SR_attentionVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/25.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_attentionVC: UIViewController {
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var attentionSegument: UISegmentedControl!
    @IBOutlet weak var attentionScrollView: UIScrollView!
    
    @IBOutlet weak var topBarView: UIView!
    var userID : String?
    
    var attentionVC : SR_attentionTableVC =  UIStoryboard(name: "SR_MIMainStory", bundle: nil).instantiateViewControllerWithIdentifier("SR_attentionID") as SR_attentionTableVC
    var fansVC : SR_fansTableVC =  UIStoryboard(name: "SR_MIMainStory", bundle: nil).instantiateViewControllerWithIdentifier("SR_fansID") as SR_fansTableVC

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        attentionScrollView.contentSize.width = 2 * screenWidth
        self.addChildViewController(attentionVC)
        self.addChildViewController(fansVC)
        attentionVC.tableView.frame = CGRectMake(0, 0, screenWidth, attentionScrollView.frame.size.height)
        fansVC.tableView.frame = CGRectMake(screenWidth, 0,screenWidth, attentionScrollView.frame.size.height)
        self.attentionScrollView.addSubview(attentionVC.tableView)
        self.attentionScrollView.addSubview(fansVC.tableView)
        attentionScrollView.delegate = self

    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden = true
        self.topBarView.backgroundColor = UIColor.NailRedColor()
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
    @IBAction func backAction(sender: AnyObject)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func registChange(sender: AnyObject) {
        var seg = sender as UISegmentedControl
        if seg.selectedSegmentIndex == 0
        {
            attentionScrollView.setContentOffset(CGPointMake(0, attentionScrollView.contentOffset.y), animated: true)
        }
        else
        {
            attentionScrollView.setContentOffset(CGPointMake(screenWidth, attentionScrollView.contentOffset.y), animated: true)
        }
    }

}

extension SR_attentionVC : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x < screenWidth
        {
            attentionSegument.selectedSegmentIndex = 0
        }
        else
        {
            attentionSegument.selectedSegmentIndex = 1
        }
        
    }
}