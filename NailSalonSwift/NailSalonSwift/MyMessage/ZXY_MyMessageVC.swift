//
//  ZXY_MyMessageVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/5/9.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MyMessageVC: UIViewController {

    @IBOutlet var filterSeg: UISegmentedControl!
    
    @IBAction func filterAction(sender: AnyObject) {
        if contentScroll.contentOffset.x == 0
        {
            contentScroll.contentOffset.x = screenW
        }
        else
        {
            contentScroll.contentOffset.x = 0
        }
    }
    
    
    var screenW = UIScreen.mainScreen().bounds.width
    @IBOutlet weak var contentScroll: UIScrollView!
    var allAttension : ZXY_MMAttensionList!
    var isShow = false
    var chatList     : ChatListViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        contentScroll.contentSize.width = 2 * UIScreen.mainScreen().bounds.width
        self.navigationItem.titleView = filterSeg
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !isShow
        {
            self.startInitAttensionList()
            self.startInitChatList()
            isShow = true
        }
    }
    
    private func startInitAttensionList()
    {
        allAttension = UIStoryboard(name: "MyMessageStory", bundle: nil).instantiateViewControllerWithIdentifier("attenID") as! ZXY_MMAttensionList
        self.addChildViewController(allAttension)
        allAttension.view.frame = CGRectMake(0, 0, screenW, contentScroll.bounds.height)
        contentScroll.addSubview(allAttension.view)
    }
    
    private func startInitChatList()
    {
        chatList = ChatListViewController()
        self.addChildViewController(chatList)
        chatList.view.frame = CGRectMake(screenW, 0, screenW, contentScroll.bounds.height)
        contentScroll.addSubview(chatList.view)
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
