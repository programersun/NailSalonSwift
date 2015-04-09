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
    private var courseVC : ZXY_ORCourseVC?
    private let screenSize : CGFloat = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var contentScroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentScroll.contentSize.width = 2 * screenSize
        self.startInitSegmentControl()
        self.startInitCourseVC()
        self.addVCAndVForCourse()
        self.startInitSqureVC()
        self.addVCAndVForSqure()
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func startAddConstraint(subView : UIView, supView : UIView)
    {
        supView.addConstraint(NSLayoutConstraint(item: supView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: subView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        supView.addConstraint(NSLayoutConstraint(item: supView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: subView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        supView.addConstraint(NSLayoutConstraint(item: supView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: subView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        supView.addConstraint(NSLayoutConstraint(item: supView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: subView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func startInitSegmentControl()
    {
        segV = ZXY_SegBtnVC()
        var nib = UINib(nibName: "ZXY_SegBtnVC", bundle: nil)
        var view = nib.instantiateWithOwner(segV, options: nil)[0] as UIView
        segV?.segFirstItem.setTitle("广场", forState: UIControlState.Normal)
        segV?.segSecondItem.setTitle("教程", forState: UIControlState.Normal)
        segV?.firstItemAction = {[weak self]() -> Void in
            self?.contentScroll.setContentOffset(CGPointMake(0, self!.contentScroll.contentOffset.y), animated: true)
            ""
        }

        segV?.secondItemAction = {[weak self] () -> Void in
            self?.contentScroll.setContentOffset(CGPointMake(self!.screenSize, self!.contentScroll.contentOffset.y), animated: true)
            ""
        }

        self.navigationItem.titleView = view
    }
    
    
    /**
    以下六个方法用来切换教程和广场页面，请在add前进行init
    */
    private func startInitSqureVC()
    {
        if(squreVC != nil)
        {
            return
        }
        squreVC = UIStoryboard(name: "OriginPageStory", bundle: nil).instantiateViewControllerWithIdentifier("orSqureID") as? ZXY_ORSqureVC
    }
    
    private func addVCAndVForSqure()
    {
        self.addChildViewController(squreVC!)
        squreVC?.view.frame = CGRectMake(0, 0, contentScroll.frame.width, contentScroll.frame.height)
        self.contentScroll.addSubview(squreVC!.view)
    }
    
    private func removeVCAndVForSqure()
    {
        squreVC?.view.removeFromSuperview()
        squreVC?.removeFromParentViewController()
        squreVC = nil
    }
    
    private func startInitCourseVC()
    {
        if(courseVC != nil)
        {
            return
        }
        courseVC = UIStoryboard(name: "OriginPageStory", bundle: nil).instantiateViewControllerWithIdentifier("courseVCID") as? ZXY_ORCourseVC
       // self.startAddConstraint(courseVC!.currentTable , supView: courseVC!.view)
    }
    
    private func addVCAndVForCourse()
    {
        self.addChildViewController(courseVC!)
        courseVC?.view.frame = CGRectMake(screenSize, 0, contentScroll.frame.width, contentScroll.frame.height)
        self.contentScroll.addSubview(courseVC!.view)
    }
    
    private func removeVCAndVForCourse()
    {
        courseVC?.view.removeFromSuperview()
        courseVC?.removeFromParentViewController()
        courseVC = nil
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

extension ZXY_ORMainVC : UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(scrollView.contentOffset.x == 0)
        {
            segV?.hideSecondImg()
        }
        
        if(scrollView.contentOffset.x == screenSize)
        {
            segV?.hideFirstImg()
        }
    }
}
