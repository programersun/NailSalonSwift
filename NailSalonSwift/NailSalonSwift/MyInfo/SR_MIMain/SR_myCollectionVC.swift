//
//  SR_myCollectionVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/4/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_myCollectionVC: UIViewController {
    
    var screenWidth = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var collectionSegument: UISegmentedControl!
    @IBOutlet weak var collectionScrollView: UIScrollView!
    
    @IBOutlet weak var topBarView: UIView!
    var userID : String?
    
    var courseCollectionVC : SR_courseCollectionVC =  UIStoryboard(name: "SR_MIMainStory", bundle: nil).instantiateViewControllerWithIdentifier("SR_courseCollectionVCID") as! SR_courseCollectionVC
    var albumCollectionVC : SR_albumCollectionVC =  UIStoryboard(name: "SR_MIMainStory", bundle: nil).instantiateViewControllerWithIdentifier("SR_albumCollectionVCID") as! SR_albumCollectionVC


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionScrollView.contentSize.width = 2 * screenWidth
        self.addChildViewController(courseCollectionVC)
        self.addChildViewController(albumCollectionVC)
        albumCollectionVC.userID = self.userID
        courseCollectionVC.userID = self.userID
        courseCollectionVC.view.frame = CGRectMake(screenWidth, 0,screenWidth, collectionScrollView.frame.size.height)
        albumCollectionVC.view.frame = CGRectMake(0, 0, screenWidth, collectionScrollView.frame.size.height)

        self.collectionScrollView.addSubview(courseCollectionVC.view)
        self.collectionScrollView.addSubview(albumCollectionVC.view)
        collectionScrollView.delegate = self

        
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
    
    
    @IBAction func collectionChange(sender: AnyObject) {
        var seg = sender as! UISegmentedControl
        if seg.selectedSegmentIndex == 0
        {
            collectionScrollView.setContentOffset(CGPointMake(0, collectionScrollView.contentOffset.y), animated: true)
        }
        else
        {
            collectionScrollView.setContentOffset(CGPointMake(screenWidth, collectionScrollView.contentOffset.y), animated: true)
        }
    }
}


extension SR_myCollectionVC : UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.contentOffset.x < screenWidth
        {
            collectionSegument.selectedSegmentIndex = 0
        }
        else
        {
            collectionSegument.selectedSegmentIndex = 1
        }
        
    }
}
