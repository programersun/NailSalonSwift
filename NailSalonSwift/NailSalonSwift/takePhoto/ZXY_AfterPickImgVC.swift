//
//  ZXY_AfterPickImgVC.swift
//  KickYourAss
//
//  Created by 宇周 on 15/2/5.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

import UIKit

class ZXY_AfterPickImgVC: UIViewController {

    let maxNumOfPhoto = 6
    @IBOutlet weak var currentCollectionV: UICollectionView!
    var isBarHidden = false
    var isPhoto     = false
    var desTxt      : UITextView?
    var photoImg  : [UIImage]? = []
    //private var currentProgress : MBProgressHUD!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.navigationController!.navigationBar.hidden)
        {
            isBarHidden = true
        }
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("submitAction"))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func leftNaviButtonAction() {
        if(isBarHidden)
        {
            self.navigationController?.navigationBar.hidden = true
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func submitAction()
    {
        if(desTxt?.text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0)
        {
            self.showAlertEasy("提示", messageContent: "介绍不能为空")
            return
        }
        
        if(self.photoImg?.count == 0)
        {
            self.showAlertEasy("提示", messageContent: "您未选择照片")
            return
        }
        
        var urlString = ZXY_ALLApi.ZXY_MainAPI + ZXY_ALLApi.ZXY_SubmitAlbumAPI
        
        var userID    = ZXY_UserInfoDetail.sharedInstance.getUserID()
        
        if(userID == nil)
        {
            var story  = UIStoryboard(name: "AboutMe", bundle: nil)
            var vc     = story.instantiateViewControllerWithIdentifier("login") as UIViewController
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        var dataArr : [NSData] = []
        photoImg!.map({(tempImg : UIImage) -> Void in
            var scaleImg = UIImage(image: tempImg, scaledToFitToSize: CGSizeMake(400, 800))
            var imgData = UIImageJPEGRepresentation(scaleImg, 0.8)
            dataArr.append(imgData)
            return
        })
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        var parameter : Dictionary<String , AnyObject> = ["user_id": userID! , "description" : desTxt!.text ]
        ZXY_NetHelperOperate().startPostImg(urlString, parameter: parameter, imgData: dataArr, fileKey: "Filedata[]", success: {[weak self] (returnDic) -> Void in
            
            MBProgressHUD.hideHUDForView(self?.view, animated: true)
            self?.leftNaviButtonAction()
            return
        }) { [weak self](failError) -> Void in
            println(failError)
            MBProgressHUD.hideHUDForView(self?.view, animated: true)
        }
    }
    
    
    
    func setPhoto(img : [UIImage])
    {
        photoImg = img
        
    }
    
    func setAssetArr(assArr : [ALAsset]!)
    {
        for (index , value) in enumerate(assArr)
        {
            var tempImg = self.AlssetToUIImage(value)
            photoImg?.append(tempImg)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
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

extension ZXY_AfterPickImgVC : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var currentRow = indexPath.row
        var currentSection = indexPath.section
        if currentSection == 0
        {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_PicTakeImgCellID, forIndexPath: indexPath) as ZXY_PicTakeImgCell
            
            if(self.photoImg != nil)
            {
                if(currentRow < self.photoImg!.count)
                {
                    var currentAsset = self.photoImg![currentRow]
                    
                    cell.cellImg.image = currentAsset
                }
                else
                {
                    
                    cell.cellImg.image = UIImage(named: "rectangleAdd")
                }
                
            }
            else
            {
                cell.cellImg.image = UIImage(named: "rectangleAdd")
            }
            return cell
        }
        else
        {
            var cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZXY_SendMessageAddInfoCoCell.cellID, forIndexPath: indexPath) as ZXY_SendMessageAddInfoCoCell
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
//        if indexPath.section == 0
//        {
            var cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "PicTakeInputCell", forIndexPath: indexPath) as ZXY_PicTakeInputCell
            cell.inputText.layer.cornerRadius = 4
            cell.inputText.layer.borderWidth  = 1
            cell.inputText.layer.masksToBounds = true
            cell.inputText.layer.borderColor  = ZXY_AllColor.SEARCH_RED_COLOR.CGColor
            desTxt = cell.inputText
            return cell
//        }
//        else
//        {
//            var cell = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ZXY_SendMessageAddInfoCoCell.cellID, forIndexPath: indexPath) as ZXY_SendMessageAddInfoCoCell
//            return cell
//            
//        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0
        {
            if(isPhoto)
            {
                return 2
            }
            if(self.photoImg != nil)
            {
                return self.photoImg!.count + 1
            }
            else
            {
                return 1
            }
        }
        else
        {
            return 1
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0
        {
            var width = (self.view.frame.size.width - 40 )/4
            return CGSizeMake(width, width)
        }
        else
        {
            var width = (self.view.frame.size.width )
            return CGSizeMake(width, 99)
        }

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if section == 0
        {
            return UIEdgeInsetsMake(5, 5, 5, 5)
        }
        else
        {
            return UIEdgeInsetsMake(25, 0, 0, 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0
        {
            return CGSize(width: UIScreen.mainScreen().bounds.width, height: 130)
        }
        else
        {
            return CGSize(width: UIScreen.mainScreen().bounds.width, height: 0)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        var currentRow = indexPath.row
        var currentSection = indexPath.section
        if currentSection == 0
        {
            if(self.photoImg != nil)
            {
                if(currentRow == self.photoImg?.count)
                {
                    if(self.photoImg?.count == maxNumOfPhoto)
                    {
                        self.showAlertEasy("提示", messageContent: "最多只能选择一张图片")
                    }
                    else
                    {
                        var story = UIStoryboard(name: "ZXYTakePic", bundle: nil)
                        var vc    = story.instantiateInitialViewController() as ZXY_PictureTakeVC
                        vc.delegate = self
                        vc.presentView()
                    }
                }
                else
                {
                    var currentAsset = self.photoImg![currentRow]
                    //var img = self.AlssetToUIImage(currentAsset)
                    self.showItemInMain(currentAsset , andRow: currentRow)
                }
            }
            else
            {
                
            }
        }
        else
        {
            
        }

    }
    
    func showItemInMain(img : UIImage , andRow : Int)
    {
        var story : UIStoryboard = UIStoryboard(name: "ZXYTakePic", bundle: nil)
        var vc    : ZXY_PickImgPictureVC = story.instantiateViewControllerWithIdentifier("pictureVCID") as ZXY_PickImgPictureVC
        vc.delegate = self
        vc.setCurrentImage(img, andRow: andRow)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ZXY_AfterPickImgVC : ZXY_PickImgPictureVCDelegate , ZXY_ImagePickerDelegate , ZXY_PictureTakeDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , ZXY_ImgFilterVCDelegate
{
    func deletePhoto(img: UIImage, row: Int) {
        self.photoImg?.removeAtIndex(row)
        currentCollectionV.reloadData()
    }
        
    func clickChoosePictureBtn() {
        
        
        var zxy_imgPick = ZXY_ImagePickerTableVC()
        zxy_imgPick.setMaxNumOfSelect(1)
        zxy_imgPick.delegate = self
        zxy_imgPick.presentZXYImagePicker(self)
    }
    
    func clickTakePhotoBtn() {
        var photoPicker = UIImagePickerController()
        photoPicker.sourceType = UIImagePickerControllerSourceType.Camera
        photoPicker.delegate = self
        self.presentViewController(photoPicker, animated: true) { () -> Void in
            
        }

    }
    
    func ZXY_ImagePicker(imagePicker: ZXY_ImagePickerTableVC, didFinishPicker assetArr: [ALAsset]) {
        
//       for (index , value) in enumerate(assetArr)
//       {
//            var tempImg = self.AlssetToUIImage(value)
//            photoImg?.append(tempImg)
//
//       }
        if(assetArr.count > 0)
        {
            var tempImg = self.AlssetToUIImage(assetArr[0])
            self.showFilter(tempImg)
        }
        //self.currentCollectionV.reloadData()
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        picker.dismissViewControllerAnimated(true, completion: {[weak self] () -> Void in
            self?.showFilter(image)
            ""
            //self?.currentCollectionV.reloadData()
            
        })
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    func showFilter(filterImage : UIImage)
    {
        var scaleImg =  UIImage(image: filterImage, scaledToFitToSize: CGSizeMake(400, 800))
        var filterVC = ZXY_ImgFilterVC()
        filterVC.delegate = self
        filterVC.originalImage = scaleImg
        filterVC.presentZXYImageFilter(self)
    }
    
    func clickFinishBtn(filterImg: UIImage) {
        
        self.photoImg?.append(filterImg)
        self.currentCollectionV.reloadData()
    }


}
