//
//  ZXY_DFPArtDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtDetailVC: UIViewController {

    var dataForComment : [AnyObject]?
    var dataForTag : [AnyObject]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension ZXY_DFPArtDetailVC : UITableViewDelegate , UITableViewDataSource
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var imgContentCell = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADImgContainerCell.cellID()) as ZXY_DFPADImgContainerCell
        var tagCell        = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADTagCell.cellID()) as ZXY_DFPADTagCell
        var commentCell    = tableView.dequeueReusableCellWithIdentifier(ZXY_DFPADCommentCell.cellID()) as
            ZXY_DFPADCommentCell
        
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        
        switch currentSection
        {
        case 0:
            return imgContentCell
        case 1:
            return tagCell
        case 2:
            return commentCell
        default :
            return imgContentCell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var currentSection = indexPath.section
        var currentRow     = indexPath.row
        switch currentSection
        {
        case 0:
            return 259
        case 1 :
            return 88
        case 2:
            return 80
        default:
            return 80
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
        case 0:
            return 1
        case 1:
            return 1
        case 2 where dataForComment != nil:
            return dataForComment!.count
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
}

extension ZXY_DFPArtDetailVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("DFPADCCellID", forIndexPath: indexPath) as UICollectionViewCell
        var cellLbl = cell.viewWithTag(1111)
        cellLbl?.layer.cornerRadius = 5
        cellLbl?.backgroundColor = UIColor.NailRedColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = dataForTag
        {
            return items.count
        }
        else
        {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(30, 25)
    }
    
    
}
