//
//  ZXY_DFPArtistDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtistDetailVC: UIViewController {
    private var screenSize  = UIScreen.mainScreen().bounds
    @IBOutlet weak var contentScroll: UIScrollView!

    @IBOutlet weak var avaterAristImg: UIImageView!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var isArtistImg: UIImageView!
    
    @IBOutlet weak var isAristLbl: UILabel!
    
    @IBOutlet weak var evalueateView: UIView!
    
    @IBOutlet weak var attensionBtn: UIButton!
    
    @IBOutlet weak var distanceLbl: UILabel!
    
    @IBOutlet weak var filterSeg: UISegmentedControl!
    
    @IBOutlet weak var headerV: UIView!
    
    var isUp = true
    var previousYForCollect : CGFloat = 0
    var previousYForTable   : CGFloat = 0
    var firstCollectionVC : ZXY_DFPArtistCollectionVC!
    var secontTableVC     : ZXY_DFPArtistTableVC!
    
    @IBOutlet weak var toTopDistance: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentScroll.contentSize.width = 2 * screenSize.width
        self.startInitSeg()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startInitFirst()
        self.startInitSecond()
    }

    func startInitSeg()
    {
        filterSeg.selectedSegmentIndex = 0
        //filterSeg.frame = CGRectMake(0, filterSeg.frame.origin.y, filterSeg.frame.size.width, filterSeg.frame.size.height)
        filterSeg.setTitle("图集", forSegmentAtIndex: 0)
        filterSeg.setTitle("评价", forSegmentAtIndex: 1)
        filterSeg.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.NailRedColor()], forState: UIControlState.Selected)
        filterSeg.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.NailRedColor()], forState: UIControlState.Normal)
        
        filterSeg.setDividerImage(UIImage(named: "verticalGray"), forLeftSegmentState: UIControlState.Normal, rightSegmentState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        
        filterSeg.setDividerImage(UIImage(named: "verticalGray"), forLeftSegmentState: UIControlState.Selected, rightSegmentState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        
        filterSeg.setBackgroundImage(UIImage(named: "segBarSelect"), forState: UIControlState.Selected, barMetrics: UIBarMetrics.Default)
        filterSeg.setBackgroundImage(UIImage(named: "segBarNoSelect"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
    }

    
    func startInitFirst()
    {
        if firstCollectionVC == nil
        {
            firstCollectionVC = UIStoryboard(name: "PublicStory", bundle: nil).instantiateViewControllerWithIdentifier(ZXY_DFPArtistCollectionVC.vcID()) as ZXY_DFPArtistCollectionVC
            self.addChildViewController(firstCollectionVC)
            firstCollectionVC.delegatela = self
            firstCollectionVC.view.frame = CGRectMake(0, 0, screenSize.width,contentScroll.frame.size.height)
            self.contentScroll.addSubview(firstCollectionVC.view)
        }
    }
    
    func startInitSecond()
    {
        if secontTableVC == nil
        {
            secontTableVC = UIStoryboard(name: "PublicStory", bundle: nil).instantiateViewControllerWithIdentifier(ZXY_DFPArtistTableVC.vcID()) as ZXY_DFPArtistTableVC
            self.addChildViewController(secontTableVC)
            secontTableVC.delegateL = self
            secontTableVC.view.frame = CGRectMake(screenSize.width, 0, screenSize.width , contentScroll.frame.size.height)
            self.contentScroll.addSubview(secontTableVC.view)
        }
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
extension ZXY_DFPArtistDetailVC : ZXY_DFPArtistCollectionVCDelegate , ZXY_DFPArtistTableVCDelegate
{
    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func attensionAction(sender: AnyObject) {
    }
    
    @IBAction func typeChange(sender: AnyObject) {
    }
    
    func collectionDidScroll(contentOffSet: CGPoint) {
        var y = contentOffSet.y
        if y > previousYForCollect
        {
            isUp = true
        }
        else
        {
            isUp = false
        }
        previousYForCollect = y
        self.titleHeaderViewScroll(y)
    }
    
    func tableDidScroll(contentOffSet: CGPoint) {
        var y = contentOffSet.y
        if y > previousYForTable
        {
            isUp = true
        }
        else
        {
            isUp = false
        }
        previousYForTable = y

        //firstCollectionVC.currentCollection.contentOffset.y = y
        self.titleHeaderViewScroll(y)
    }
    
    func titleHeaderViewScroll(y : CGFloat)
    {
        if(toTopDistance.constant <= -110 && isUp)
        {
            toTopDistance.constant = -110
            return
        }
        
        if(toTopDistance.constant >= 0 && !isUp)
        {
            toTopDistance.constant = 0
        }
        
        if !isUp
        {
            if y <= 110
            {
                toTopDistance.constant = -y
            }
        }
        else
        {
            toTopDistance.constant = -y
        }
        
        
        
    }
    
}
