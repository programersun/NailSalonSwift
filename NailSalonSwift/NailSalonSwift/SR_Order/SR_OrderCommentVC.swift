//
//  SR_OrderCommentVC.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_OrderCommentVC: UIViewController {
    
    
    @IBOutlet weak var commentBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        commentBtn.layer.borderColor = UIColor.NailBackGrayColor().CGColor
        commentBtn.layer.borderWidth = 0.5
        commentBtn.layer.masksToBounds = true
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
    
    
    @IBAction func commentBtnClick(sender: AnyObject) {
        
    }
}

extension SR_OrderCommentVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 1:
            return 160
        case 2:
            return 50
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var firstCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderCommentFirstCell.cellID()) as! SR_OrderCommentFirstCell
        var secondCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderCommentSecondCell.cellID()) as! SR_OrderCommentSecondCell
        var thirdCell = tableView.dequeueReusableCellWithIdentifier(SR_OrderCommentThirdCell.cellID()) as! SR_OrderCommentThirdCell
        switch indexPath.row {
        case 0:
            return firstCell
        case 1:
            secondCell.delegate = self
            return secondCell
        case 2:
            return thirdCell
        default:
            return firstCell
        }
    }
}
extension SR_OrderCommentVC : SR_OrderCommentSecondCellProtocol {
    func clickImg() {
        println("hello")
    }
}
