//
//  SR_WelcomeViewController.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/12.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class SR_WelcomeViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startPage = self.storyboard?.instantiateViewControllerWithIdentifier("SR_WelcomeViewID") as! SR_WelcomeView
        startPage.currentIndex = 0
        self.setViewControllers([startPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        self.dataSource = self

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

extension SR_WelcomeViewController : UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (self.viewControllers.first as! SR_WelcomeView).currentIndex!
        if currentIndex >= 2 {
            return nil
        } else {
            let nextPage = self.storyboard?.instantiateViewControllerWithIdentifier("SR_WelcomeViewID") as! SR_WelcomeView
            nextPage.currentIndex = currentIndex + 1
            return nextPage
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentIndex = (self.viewControllers.first as! SR_WelcomeView).currentIndex!
        if currentIndex <= 0 {
            return nil
        } else {
            let previousPage = self.storyboard?.instantiateViewControllerWithIdentifier("SR_WelcomeViewID") as! SR_WelcomeView
            previousPage.currentIndex = currentIndex - 1
            return previousPage
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
