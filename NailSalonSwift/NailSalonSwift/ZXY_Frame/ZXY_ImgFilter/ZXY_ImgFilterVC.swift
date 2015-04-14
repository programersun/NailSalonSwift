//
//  ZXY_ImgFilterVC.swift
//  GPUImageDemo
//
//  Created by 宇周 on 15/2/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_ImgFilterVCDelegate : class
{
    func clickFinishBtn(filterImg : UIImage)
}
class ZXY_ImgFilterVC: UIViewController {

    weak var delegate : ZXY_ImgFilterVCDelegate!
    private var slideBar : UISlider?
    var originalImage : UIImage?
    private var filterImage : UIImage?
    private var currentTableV : UITableView!
    private var currentFilterType : ZXY_FilterImgType! = ZXY_FilterImgType.FilterImgOrigin
    private var currentFilterValue : CGFloat? = 0.5
    private var currentVC : UIViewController!
    private var thisNavi     : UINavigationController?
    //private var filterImageV : UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        if(thisNavi == nil)
        {
            self.thisNavi = UINavigationController(rootViewController: self)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dissMissZXYImageFilter"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("finishFilterImg"))
        filterImage = originalImage?.copy() as? UIImage
        currentTableV = UITableView()
        currentTableV.delegate   = self
        currentTableV.dataSource = self
        self.view.addSubview(currentTableV)
        currentTableV.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.backgroundColor = UIColor.blackColor()
        currentTableV.backgroundColor = UIColor.clearColor()
        currentTableV.separatorStyle = UITableViewCellSeparatorStyle.None
        
        // Do any additional setup after loading the view.
    }

    func presentZXYImageFilter(vc : UIViewController)
    {
        currentVC = vc
        if(thisNavi == nil)
        {
            self.thisNavi = UINavigationController(rootViewController: self)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dissMissZXYImageFilter"))
        if(thisNavi == nil)
        {
            self.thisNavi = UINavigationController(rootViewController: self)
        }
        
        vc.presentViewController(self.thisNavi!, animated: true) {[weak self] () -> Void in
            
        }
    }
    
    func dissMissZXYImageFilter()
    {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    func finishFilterImg()
    {
        
        if(filterImage != nil)
        {
            self.dismissViewControllerAnimated(true, completion: {[weak self] () -> Void in
                if let hello = self?.filterImage
                {
                    self?.delegate.clickFinishBtn(hello)
                }
                
            })
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(ZXY_SystemReative().isIos7!)
        {
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        }

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if(ZXY_SystemReative().isIos8!)
        {
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentTableV, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSliderPresent()
    {
        if(slideBar == nil)
        {
            slideBar = UISlider()
            
            self.view.addSubview(slideBar!)
            slideBar?.setTranslatesAutoresizingMaskIntoConstraints(false)
            slideBar?.addTarget(self, action: Selector("slideValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            slideBar?.layer.setAffineTransform(CGAffineTransformMakeRotation(-CGFloat(M_PI) / 2.0))
            slideBar?.layer.anchorPoint = CGPointMake(0.5, 0.5)
        }
        
        switch currentFilterType!
        {
        case ZXY_FilterImgType.FilterImgOrigin :
            slideBar?.hidden = true
        case ZXY_FilterImgType.FilterImgContrast:
            slideBar?.hidden = false
            slideBar?.maximumValue = 4.0
            slideBar?.minimumValue = 0.0
            slideBar?.value = Float(0.5)
        case ZXY_FilterImgType.FilterImgBrightness:
            slideBar?.hidden = false
            slideBar?.maximumValue = 1.0
            slideBar?.minimumValue = -1.0
            slideBar?.value = Float(-0.5)
        case ZXY_FilterImgType.FilterImgSaturation:
            slideBar?.hidden = false
            slideBar?.maximumValue = 2.0
            slideBar?.minimumValue = 0.0
            slideBar?.value = Float(0.5)
        case ZXY_FilterImgType.FilterImgVignette:
            slideBar?.hidden = true
        case ZXY_FilterImgType.FilterImggrayscale:
            slideBar?.hidden = true
        case ZXY_FilterImgType.FilterImgMonochrome:
            slideBar?.hidden = false
            slideBar?.maximumValue = 1.0
            slideBar?.minimumValue = 0.0
            slideBar?.value = Float(0.5)
        default:
            slideBar?.hidden = true
        }
        
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: slideBar, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        if(ZXY_SystemReative().isIos7!)
        {
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: slideBar, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
            println("ios 7")
        }
        
        if(ZXY_SystemReative().isIos8!)
        {
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: slideBar, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: -70))
            println("ios 8")
        }
        
        slideBar!.addConstraint(NSLayoutConstraint(item: slideBar!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200))
        
        
    }

    func slideValueChanged(sender : AnyObject)
    {
        currentFilterValue = CGFloat(slideBar!.value)
        currentTableV.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
        
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



extension ZXY_ImgFilterVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var imgCell : ZXY_FilterPicCell? = tableView.dequeueReusableCellWithIdentifier(ZXY_FilterPicCellID) as? ZXY_FilterPicCell
        var operateCell : ZXY_FilterPicOperationCell? = tableView.dequeueReusableCellWithIdentifier(ZXY_FilterPicOperationCellID) as? ZXY_FilterPicOperationCell
        
        if(imgCell == nil)
        {
            imgCell = ZXY_FilterPicCell()
            tableView.registerClass(ZXY_FilterPicCell.self, forCellReuseIdentifier: ZXY_FilterPicCellID)
        }
        
        if(operateCell == nil)
        {
            operateCell = ZXY_FilterPicOperationCell()
            tableView.registerClass(ZXY_FilterPicOperationCell.self, forCellReuseIdentifier: ZXY_FilterPicOperationCellID)
        }
        
        if(indexPath.row == 0)
        {
            filterImage  = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(currentFilterType, originImage: originalImage!, valueO: currentFilterValue)
            imgCell?.imgView.image = filterImage
            //filterImageV = imgCell?.imageView
            return imgCell!
        }
        else
        {
            operateCell?.filterImg = UIImage(image: originalImage, scaledToFitToSize: CGSizeMake(300, 300))
            operateCell?.backgroundColor = UIColor.clearColor()
            operateCell?.delegate = self
            return operateCell!
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0)
        {
            return self.view.frame.size.height - 120
        }
        else
        {
            return 120
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

extension ZXY_ImgFilterVC : ZXY_FilterPicOperationCellDelegate
{
    func clickItemForTag(itemTag: ZXY_FilterImgType) {
        currentFilterType = itemTag
        self.setSliderPresent()
        weak var tempImg = filterImage!
        currentFilterValue = 0.5
        if(itemTag == ZXY_FilterImgType.FilterImgBrightness)
        {
            currentFilterValue = -0.5
        }
        currentTableV.reloadRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
    }
}
