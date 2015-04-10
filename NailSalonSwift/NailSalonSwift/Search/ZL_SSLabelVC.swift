//
//  ZL_SSLabelVC.swift
//  NailSalonSwift
//
//  Created by 赵磊 on 15/4/10.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZL_SSLabelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var searchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 30))
        searchBar.placeholder = "请输入标签"
        //self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        var testString = NSMutableAttributedString(string: "Hello word")
        var range  = NSMakeRange(1, 3)
        testString.setAttributes([NSForegroundColorAttributeName : UIColor.blueColor()], range: range)
        
        var label = UILabel(frame: CGRectMake(0, 0, 200, 40))
        label.attributedText = testString
        self.navigationItem.titleView = label
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
extension ZL_SSLabelVC :UISearchBarDelegate , UITableViewDelegate ,  UITableViewDataSource {
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        print(searchText)
        
    }
    
    /* 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发*/
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        print(searchBar.text)
    searchBar.resignFirstResponder()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var labelCell = tableView.dequeueReusableCellWithIdentifier(ZL_SSLabelCell.cellID()) as ZL_SSLabelCell
        
        labelCell.imgName.image = UIImage(named: "headerHolder")
        labelCell.titleLabel.text = "爱国者就做爱过美甲"
        labelCell.nameLabel.text = "小米爆米花"
        
        
        return labelCell
    }
    
    
    func nameLabelChange(oldText : String) ->String{
        var newText = "哈哈"
        
        
        return ""
    }
    
    
    
    
    
}









