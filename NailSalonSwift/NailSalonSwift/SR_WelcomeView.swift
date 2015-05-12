//
//  SR_WelcomeView.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/12.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_WelcomeView: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var experienceBtn: UIButton!
    var currentIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(currentIndex != nil)
        {
            if(currentIndex! < 2)
            {
                experienceBtn.hidden = true
            }
            else
            {
                experienceBtn.hidden = false
                experienceBtn.layer.cornerRadius = 4
                experienceBtn.layer.masksToBounds = true
            }
            self.imgView.image = UIImage(named: "welcome\(currentIndex!)")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func experienceBtnClick(sender: AnyObject) {
        ZXY_UserInfoDetail.sharedInstance.startFirstSuccess()
        var storyBoard = UIStoryboard(name: "Main" , bundle : nil)
        var tvc        = storyBoard.instantiateInitialViewController() as! ZXY_MainTabBarVC
        let dele       = UIApplication.sharedApplication().delegate
        dele!.window!?.rootViewController = tvc
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
