//
//  ZXY_DFPArtistDetailVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/4/14.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_DFPArtistDetailVC: UIViewController {
    @IBOutlet weak var contentScroll: UIScrollView!

    @IBOutlet weak var avaterAristImg: UIImageView!
    
    @IBOutlet weak var artistName: UILabel!
    
    @IBOutlet weak var isArtistImg: UIImageView!
    
    @IBOutlet weak var isAristLbl: UILabel!
    
    @IBOutlet weak var evalueateView: UIView!
    
    @IBOutlet weak var attensionBtn: UIButton!
    
    @IBOutlet weak var distanceLbl: UILabel!
    
    @IBOutlet weak var typeSegment: UISegmentedControl!
    
    @IBOutlet weak var headerV: UIView!
    
    
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
extension ZXY_DFPArtistDetailVC
{
    @IBAction func backAction(sender: AnyObject) {
    }
    
    @IBAction func attensionAction(sender: AnyObject) {
    }
    
    @IBAction func typeChange(sender: AnyObject) {
    }
    
    
}
