//
//  ZXY_ARMainVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ARMainVC: UIViewController {
    
    //热门
    var rightButtonSelect = true

    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var HotView: UIView!
    @IBOutlet weak var backgroudView: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "美甲师"
        rightButton.titleEdgeInsets.left = -50
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        HotView.hidden = true
        backgroudView.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        arrowUp()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //点击背景
    @IBAction func backgroundTouch(sender: AnyObject) {
        arrowUp()
    }
    //点击rightButtonItem按钮
    @IBAction func rightButtonItemClick(sender: AnyObject) {
        if rightButtonSelect {
            arrowDown()
        }
        else{
            arrowUp()
        }
    }
    //热门下拉
    func arrowDown(){
        rightButton.setImage(UIImage(named: "arrowDown"), forState: UIControlState())
        HotView.hidden = false
        rightButtonSelect = false
        backgroudView.hidden = false
        backgroudView.alpha = 0.8
        backgroudView.layer.addAnimation(SR_Animation.animationForAlpha(0, to: 0.8), forKey: "alpha")
        HotView.layer.addAnimation(SR_Animation.animationDown(), forKey: "down")
        HotView.layer.position = CGPointMake(self.view.bounds.width - 40, 70)
        HotView.layer.anchorPoint = CGPointMake(0.7,0)
    }
    //热门推出
    func arrowUp(){
        rightButton.setImage(UIImage(named: "arrowUp"), forState: UIControlState())
        rightButtonSelect = true
        HotView.layer.addAnimation(SR_Animation().animationUp({[weak self](finish) -> Void in
            self?.HotView.hidden = true
            ""
            }), forKey: "up")
        HotView.layer.position = CGPointMake(self.view.bounds.width - 40, 70)
        HotView.layer.anchorPoint = CGPointMake(0.7,0)
        backgroudView.alpha = 0.0
        backgroudView.layer.addAnimation(SR_Animation().animationForAlpha(0.8, to: 0, finishBlock: { [weak self](finish) -> Void in
            self?.backgroudView.hidden = true
            ""
        }), forKey: "alpha")
    }

    
    @IBAction func hotButtonClick(sender: UIButton) {
        rightButton.titleLabel?.text = "热门"
        rightButton.setTitle("热门", forState: UIControlState.Normal)
    }

    @IBAction func nearbyButtonClick(sender: UIButton) {
        rightButton.titleLabel?.text = "附近"
    }
    
    @IBAction func commentsButtonClick(sender: UIButton) {

        rightButton.titleLabel?.text = "评论"
    }
    
    @IBAction func worksButtonClick(sender: UIButton) {
        rightButton.titleLabel?.text = "作品"
    }
}

extension ZXY_ARMainVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SR_ARTableViewCell.identifier) as SR_ARTableViewCell
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}