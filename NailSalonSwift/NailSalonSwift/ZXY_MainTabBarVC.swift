//
//  ZXY_MainTabBarVC.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_MainTabBarVC: UITabBarController {

    var picker : UIImagePickerController! = UIImagePickerController()
    enum MainTabImage : String
    {
        case originImage       = "originItem"
        case originImageSelect = "originItemD"
        case originTitle       = "图集"
        case artistImage       = "artistItem"
        case artistImageSelect = "artistItemD"
        case artistTitle       = "美甲师"
        case takeImage         = "photoItem"
        case takeImageSelect   = "photoItemD"
        case searchImage       = "searchItem"
        case searchImageSelect = "searchItemD"
        case searchTitle       = "搜索"
        case userImage         = "userItem"
        case userImageSelect   = "userItemD"
        case userTitle         = "我"
        
        func giveMeItemImage(itemIndex : Int) -> (String , String , String)
        {
            switch itemIndex
            {
            case 0 :
                return (MainTabImage.originImageSelect.rawValue , MainTabImage.originImage.rawValue ,MainTabImage.originTitle.rawValue)
            case 1 :
                return (MainTabImage.artistImageSelect.rawValue , MainTabImage.artistImage.rawValue, MainTabImage.artistTitle.rawValue)
            case 2 :
                return (MainTabImage.takeImage.rawValue , MainTabImage.takeImageSelect.rawValue ,"")
            case 3 :
                return (MainTabImage.searchImageSelect.rawValue , MainTabImage.searchImage.rawValue, MainTabImage.searchTitle.rawValue)
            case 4 :
                return (MainTabImage.userImageSelect.rawValue , MainTabImage.userImage.rawValue , MainTabImage.userTitle.rawValue)
            default :
                return (MainTabImage.originImageSelect.rawValue , MainTabImage.originImage.rawValue, MainTabImage.originTitle.rawValue)
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var orStory = UIStoryboard(name: "OriginPageStory", bundle: nil)
        var orVC    = orStory.instantiateInitialViewController() as! UINavigationController
        var arStory = UIStoryboard(name: "ArtistStory", bundle: nil)
        var arVC    = arStory.instantiateInitialViewController() as! UINavigationController
        var miStory = UIStoryboard(name: "MyInfoStory", bundle: nil)
        var miVC    = miStory.instantiateInitialViewController() as! UINavigationController
        var seStory = UIStoryboard(name: "SearchStory", bundle: nil)
        var seVC    = seStory.instantiateInitialViewController() as! UINavigationController
        var tpVC    = UIStoryboard(name: "takePhotoStory", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        self.setViewControllers([orVC, arVC , tpVC ,seVC, miVC ], animated: true)
        self.tabBar.selectedImageTintColor = UIColor.NailRedColor()
        for var i = 0 ; i < self.tabBar.items?.count ; i++
        {
            var item           = self.tabBar.items![i] as! UITabBarItem
            var desImage       = MainTabImage(rawValue: MainTabImage.originImage.rawValue)?.giveMeItemImage(i)
            item.image         = UIImage(named: desImage!.0)
            item.selectedImage = UIImage(named: desImage!.1)
            if(i == 2)
            {
                var insets = item.imageInsets
                item.imageInsets = UIEdgeInsetsMake(item.imageInsets.top + 5, insets.left, insets.bottom - 5, insets.right)
            }
            item.title         = desImage!.2
            item.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.NailRedColor()], forState: UIControlState.Selected)
        }
        self.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("loginOtherDevices"), name: "loginOtherDevices", object: nil)
        
        // Do any additional setup after loading the view.
    }
    
    func loginOtherDevices()
    {
        var currentVC: UINavigationController = self.viewControllers![self.selectedIndex] as! UINavigationController
        var story = UIStoryboard(name: "MyInfoStory", bundle: nil)
        var login = story.instantiateViewControllerWithIdentifier("loginVCID") as! ZXY_LoginRegistVC
        login.delegate = self
        currentVC.pushViewController(login, animated: true)
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

extension ZXY_MainTabBarVC : UITabBarControllerDelegate , ZXY_PictureTakeDelegate , ZXY_ImagePickerDelegate , UINavigationControllerDelegate,UIImagePickerControllerDelegate , ZXY_ImgFilterVCDelegate ,ZXY_LoginRegistVCProtocol
{
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if(viewController == (tabBarController.viewControllers![2] as! UIViewController))
        {
            var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
            var vc    = story.instantiateInitialViewController() as! ZXY_PictureTakeVC
            vc.delegate = self
            vc.presentView()
            return false
        }
        else
        {
            return true
        }
    }
    
    func clickChoosePictureBtn() {
        var currentVC: UIViewController = self.viewControllers![self.selectedIndex] as! UIViewController
        
        var zxy_imgPick = ZXY_ImagePickerTableVC()
        zxy_imgPick.setMaxNumOfSelects(1)
        zxy_imgPick.delegate = self
        zxy_imgPick.presentZXYImagePicker(currentVC)
    }
    
    func clickTakePhotoBtn() {
        var currentVC: UIViewController = self.viewControllers![self.selectedIndex] as! UIViewController
        var photoPicker = UIImagePickerController()
        photoPicker.sourceType = UIImagePickerControllerSourceType.Camera
        photoPicker.delegate = self
        currentVC.presentViewController(photoPicker, animated: true) { () -> Void in
            
        }
    }
    
    func ZXY_ImagePicker(imagePicker: ZXY_ImagePickerTableVC, didFinishPicker assetArr: [ALAsset]) {
        //        var currentVC: UINavigationController = self.viewControllers![self.selectedIndex] as UINavigationController
        //        var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
        //        var vc    = story.instantiateViewControllerWithIdentifier("ZXY_AfterPickImgVCID") as ZXY_AfterPickImgVC
        //        vc.setAssetArr(assetArr)
        //        //currentVC.presentViewController(vc, animated: true) { () -> Void in
        //        currentVC.pushViewController(vc, animated: true)
        //}
        self.showFilter(self.AlssetToUIImage(assetArr[0]))
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            //            var currentVC: UINavigationController = self.viewControllers![self.selectedIndex] as UINavigationController
            //            var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
            //            var vc    = story.instantiateViewControllerWithIdentifier("ZXY_AfterPickImgVCID") as ZXY_AfterPickImgVC
            //            vc.setPhoto([image])
            //            currentVC.pushViewController(vc, animated: true)
            self.showFilter(image)
            
        })
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func showFilter(filterImage : UIImage)
    {
        var scaleImg =  UIImage(image: filterImage, scaledToFitToSize: CGSizeMake(400, 800))
        var currentVC: UIViewController = self.viewControllers![self.selectedIndex] as! UIViewController
        var filterVC = ZXY_ImgFilterVC()
        filterVC.delegate = self
        filterVC.originalImage = scaleImg
        filterVC.presentZXYImageFilter(currentVC)
    }
    
    func clickFinishBtn(filterImg: UIImage) {
        var currentVC: UINavigationController = self.viewControllers![self.selectedIndex] as! UINavigationController
        var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
        var vc    = story.instantiateViewControllerWithIdentifier("ZXY_AfterPickImgVCID") as! ZXY_AfterPickImgVC
        vc.setPhoto([filterImg])
        currentVC.pushViewController(vc, animated: true)
    }
    
    func userLoginSuccess() {
        
    }
}
