//
//  ZXY_ImagePickerTableVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/3.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
protocol ZXY_ImagePickerDelegate : class
{
    func ZXY_ImagePicker(imagePicker : ZXY_ImagePickerTableVC , didFinishPicker assetArr:[ALAsset]) -> Void
}
class ZXY_ImagePickerTableVC: UIViewController {

    var currentTable : UITableView = UITableView()
    var assetGroup   : [ALAssetsGroup]? = []
    var assetLibrary : ALAssetsLibrary? 
    var thisNavi     : UINavigationController?
    var currentVC    : UIViewController!
    var maxNumOfSelect : Int = 1
    weak var delegate : ZXY_ImagePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(thisNavi == nil)
        {
            self.thisNavi = UINavigationController(rootViewController: self)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dissMissZXYImagePicker"))
        self.startInitTableView()
        self.startGetAsset()
        // Do any additional setup after loading the view.
    }

    func setMaxNumOfSelects(maxNum : Int)
    {
        self.maxNumOfSelect = maxNum
    }
    
    func presentZXYImagePicker(vc : UIViewController)
    {
        currentVC = vc
        if(thisNavi == nil)
        {
            self.thisNavi = UINavigationController(rootViewController: self)
        }

        vc.presentViewController(self.thisNavi!, animated: true) {[weak self] () -> Void in
            
        }
    }
    
    func dissMissZXYImagePicker()
    {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func startInitTableView()
    {
        self.view.addSubview(currentTable)
        currentTable.delegate = self
        currentTable.dataSource = self
        currentTable.separatorStyle = UITableViewCellSeparatorStyle.None
        currentTable.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: currentTable, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: currentTable, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: currentTable, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: currentTable, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
    }
    
    func startGetAsset()
    {
        assetLibrary = ALAssetsLibrary()
        var failureBlock : ALAssetsLibraryAccessFailureBlock = {[weak self] (error) -> Void in
            self?.showAlertEasy("提示", messageContent: "获取相册失败，请更改权限")
            ""
        }
        
        var successBlock : ALAssetsLibraryGroupsEnumerationResultsBlock = {[weak self] (group, stop) -> Void in
            if(group != nil)
            {
                var filter : ALAssetsFilter = ALAssetsFilter.allPhotos()
                group?.setAssetsFilter(filter)
                //print("numOfAsset  \(group.numberOfAssets())")
                if(group.numberOfAssets() > 0)
                {
                    self?.assetGroup?.append(group)
                    dispatch_async(dispatch_get_main_queue(), { [weak self]() -> Void in
                        self?.currentTable.reloadData()
                        ""
                    })
                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), { [weak self]() -> Void in
                        self?.currentTable.reloadData()
                        ""
                    })
                }
            }
        }
        
        var types  = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupFaces | ALAssetsGroupSavedPhotos
        var typeInt = Int(types)
        assetLibrary?.enumerateGroupsWithTypes(typeInt, usingBlock: successBlock, failureBlock: failureBlock)
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

extension ZXY_ImagePickerTableVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("zxy_imagePicker") as? UITableViewCell
        if(cell == nil)
        {
            //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "zxy_imagePicker")
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "zxy_imagePicker") as UITableViewCell
        }
        var currentGroup = assetGroup![indexPath.row]
        var cgImagea  = currentGroup.posterImage()
        var images = UIImage(CGImage: cgImagea.takeUnretainedValue())
        var titleName = currentGroup.valueForProperty(ALAssetsGroupPropertyName) as! String
        cell?.imageView?.image = images
        cell?.textLabel?.text  = titleName
        // 图库组的系统名称
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(assetGroup != nil)
        {
            return assetGroup!.count
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var currentGroup = assetGroup![indexPath.row]
        var coVc = ZXY_ImagePickerCollectionVC()
        coVc.delegate = self
        coVc.setAssetsArrs(currentGroup)
        coVc.setMaxNumOfSelects(maxNumOfSelect)
        self.navigationController?.pushViewController(coVc, animated: true)
    }
}

extension ZXY_ImagePickerTableVC :ZXY_ImagePickerCollectionVCDelegate
{
    func selectFinish(allPickImgURL: [ALAsset]) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            if(self.delegate != nil)
            {
                self.delegate?.ZXY_ImagePicker(self, didFinishPicker: allPickImgURL)
            }

        })
    }
}
