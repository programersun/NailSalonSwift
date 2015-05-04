//
//  ZXY_ImageBrowserVC.swift
//  ZXYImageBrowser
//
//  Created by ZXYStart on 15/1/23.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
@objc protocol ZXY_ImageBrowserVCDelegate : class
{
    /**
    sheet点击代理时间
    
    :param: sheetView 所创建的sheetView 实例
    :param: index     非负表示用户点击按钮 ，-1表示点击取消
    
    :returns: 返回空
    */

    func longPressClickActionSheetAt(indexPath : Int)
    
    /**
    sheet点击代理时间
    
    :param: sheetView 所创建的sheetView 实例
    :param: index     非负表示用户点击按钮 ，-1表示点击取消
    
    :returns: 返回空
    */

    optional func longPressClickActionSheetAtImage(indexPath : Int , withImage: UIImage)
}

class ZXY_ImageBrowserVC: UIViewController {
    private let tagForAdd = 1300
    weak var delegate : ZXY_ImageBrowserVCDelegate?
    private var screenSize = UIScreen.mainScreen().bounds
    private let edgeWidth = 15.0
    private var _currentIndex : Int = 0
    private var _currentScroll   : UIScrollView!
    private var _itemCellINUse   : NSMutableSet?
    private var _itemCellINDeuse : NSMutableSet?
    private var _isOriChange     : Bool = false
    private var _selectIndex : Int? = 0
    private var _titleView    : UIView  = UIView()
    private var _titleLbl     : UILabel = UILabel()
    private var _titleBtn     : UIButton = UIButton()
    private var _isTitleHide  : Bool    = false
    private var _currentImageForGive  : UIImage?
    private var actionSheet   : ZXY_SheetView?
    private var actionCancel   : String?
    private var actionList     : [String]?
    var photoItems : [ZXY_ImageItem]!
    var titleString      : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
       // self.startInitScrollView()
        // Do any additional setup after loading the view.
    }
    
    func addFooterView()
    {
        var height  = UIViewController.getCellHeightWith(textString: titleString, minHeight: 30, fontSize: UIFont.systemFontOfSize(15), constraintWidth: screenSize.width) + 20
        var footerV = UIView(frame: CGRectMake(0,screenSize.height , screenSize.width, height))
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.prefersStatusBarHidden()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startInitScrollView()
    }
    
    override func loadView() {
        self.view = UIView()
        self.view.frame = UIScreen.mainScreen().bounds
        self.view.backgroundColor = UIColor.blackColor()
    }

    func setLongPressActionInfo(cancelBtn: String?,andMessage messages : String...)
    {
        actionList = messages
        actionCancel = cancelBtn
    }
    
    func setSelectIndex(selectIndex : Int?)
    {
        self._selectIndex = selectIndex
        _currentIndex = selectIndex!
        for var i = 0 ;i < photoItems.count ; i++
        {
            var tempItem = photoItems[i]
            tempItem.itemIndex = i
            tempItem.isFistShow = i == _selectIndex
            
        }
        
        if(self.isViewLoaded())
        {
            var frame: CGRect = self.view.bounds
            if(_currentScroll == nil)
            {
                self.startInitScrollView()
            }
             _currentScroll.contentOffset = CGPointMake(frame.size.width * CGFloat(_selectIndex!), 0.0)
            self.showPhotos()
        }
        
    }
    
    func presentShow()
    {
        var window : UIWindow = UIApplication.sharedApplication().keyWindow!
        self.view.alpha = 0
        window.addSubview(self.view)
        window.rootViewController?.addChildViewController(self)
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.alpha = 1
        }) { [weak self](isDown) -> Void in
            if(self?._selectIndex == 0)
            {
                self?.showPhotos()
            }

        }
    }
    
    private func startInitScrollView() -> Void
    {
        var frame: CGRect = self.view.bounds
        //self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        frame.origin.x -= CGFloat(edgeWidth)
        frame.size.width += CGFloat(2 * edgeWidth)
        if(_currentScroll == nil)
        {
            _currentScroll = UIScrollView(frame: frame)
            self.view.addSubview(_currentScroll)
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: _currentScroll, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 15.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: _currentScroll, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: -15.0))
            
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: _currentScroll, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: _currentScroll, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
            
            _titleView.frame = CGRectMake(0, 0, frame.size.width, 70)
            _titleView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)
            _titleLbl.frame  = CGRectMake(frame.size.width/2 - 60, 30, 100, 20)
            _titleLbl.textAlignment = NSTextAlignment.Center
            _titleLbl.font = UIFont.systemFontOfSize(15)
            _titleBtn.frame = CGRectMake(5, 25, 50, 30)
            _titleBtn.setTitle("返回", forState: UIControlState.Normal)
            _titleBtn.setTitleColor(UIColor(red: 3/255.0, green: 144/255.0, blue: 252/255.0, alpha: 1), forState: UIControlState.Normal)
            _titleBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
            _titleBtn.addTarget(self, action: Selector("hideBrowser"), forControlEvents: UIControlEvents.TouchUpInside)
            _titleView.addSubview(_titleLbl)
            _titleView.addSubview(_titleBtn)
            self.view.addSubview(_titleView)
            
        }
        else
        {
            _titleView.frame = CGRectMake(0, _titleView.frame.origin.y, frame.size.width, 70)
            _titleLbl.frame  = CGRectMake(frame.size.width/2 - 60, 30, 100, 20)
            _currentScroll.frame = frame
        }
        _currentScroll.delegate = self
        _currentScroll.pagingEnabled = true
        _currentScroll.backgroundColor = UIColor.clearColor()
        _currentScroll.showsHorizontalScrollIndicator = false
        _currentScroll.showsVerticalScrollIndicator = true
        var contentWidth : CGFloat = frame.size.width * CGFloat(photoItems.count)
        _currentScroll.contentSize = CGSizeMake(contentWidth, frame.height)
        _currentScroll.contentOffset = CGPointMake(frame.size.width * CGFloat(_currentIndex), 0.0)
        _titleLbl.text = "\(_currentIndex + 1) / \(photoItems.count) "
        _currentScroll.setTranslatesAutoresizingMaskIntoConstraints(false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPhotos(photos : [ZXY_ImageItem])
    {
        self.photoItems = photos
        if(self.photoItems.count > 1)
        {
            _itemCellINDeuse = NSMutableSet()
            _itemCellINUse   = NSMutableSet()
        }
        for var i = 0 ;i < photoItems.count ;i++
        {
            var photo : ZXY_ImageItem = photoItems[i]
            photo.itemIndex = i
            photo.isFistShow = i == _selectIndex
           
        }
        if(_currentScroll != nil)
        {
            _currentScroll.removeFromSuperview()
            _currentScroll = nil
            //            var frame: CGRect = self.view.bounds
            //            //self.view.setTranslatesAutoresizingMaskIntoConstraints(false)
            //            frame.origin.x -= CGFloat(edgeWidth)
            //            frame.size.width += CGFloat(2 * edgeWidth)
            //            var contentWidth : CGFloat = frame.size.width * CGFloat(photoItems.count)
            //            _currentScroll.contentSize = CGSizeMake(contentWidth, frame.height)
            //            _currentScroll.contentOffset = CGPointMake(frame.size.width * CGFloat(_currentIndex), 0.0)
            //            _titleLbl.text = "\(_currentIndex + 1) / \(photoItems.count) "
            //            _currentScroll.setTranslatesAutoresizingMaskIntoConstraints(false)
            
        }


    }
    
    private func getTagFromIndex(index : Int) -> Int
    {
        return index + tagForAdd
    }
    
    private func getIndexFromTag(tag : Int) ->Int
    {
        return tag - tagForAdd
    }
    
    
    
    private func showPhotos()
    {
        if(photoItems.count == 1)
        {
            self.showItemAtIndex(0)
            return
        }
        var currentBounds = _currentScroll.bounds
        var begainIndex = Int(floorf(Float((CGRectGetMinX(currentBounds) + CGFloat(2 * edgeWidth)) / CGRectGetWidth(currentBounds))))
        var endIndex    = Int(floorf(Float((CGRectGetMaxX(currentBounds) - CGFloat(2 * edgeWidth) - 1.0) / CGRectGetWidth(currentBounds))))
        
        if(begainIndex < 0)
        {
            begainIndex = 0
        }
        
        if(begainIndex >= photoItems.count)
        {
            begainIndex = photoItems.count - 1
        }
        
        if (endIndex < 0)
        {
            endIndex = 0
        }
        
        if(endIndex >= photoItems.count)
        {
            endIndex = photoItems.count - 1
        }
        
        for  var i = 0 ;i < _itemCellINUse?.count ; i++
        {
            var tempItemV : ZXY_ImageItemView = _itemCellINUse?.allObjects[i] as! ZXY_ImageItemView
            var index = self.getIndexFromTag(tempItemV.tag)
            if(index < begainIndex || index > endIndex)
            {
                tempItemV.removeFromSuperview()
                _itemCellINUse?.removeObject(tempItemV)
            }
        }
        _itemCellINUse?.minusSet(_itemCellINDeuse as Set<NSObject>!)
        if(_itemCellINDeuse?.count > 2)
        {
            _itemCellINDeuse?.removeObject(_itemCellINDeuse!.anyObject()!)
        }
        
        for var j = begainIndex ; j <= endIndex ; j++
        {
            if(!isViewShowing(j))
            {
                self.showItemAtIndex(j)
            }
        }
        
    }
    
    func removeShowView()
    {
        var currentBounds = _currentScroll.bounds
        var begainIndex = Int(floorf(Float((CGRectGetMinX(currentBounds) + CGFloat(2 * edgeWidth)) / CGRectGetWidth(currentBounds))))
        var endIndex    = Int(floorf(Float((CGRectGetMaxX(currentBounds) - CGFloat(2 * edgeWidth) - 1.0) / CGRectGetWidth(currentBounds))))
        
        if(begainIndex < 0)
        {
            begainIndex = 0
        }
        
        if(begainIndex >= photoItems.count)
        {
            begainIndex = photoItems.count - 1
        }
        
        if (endIndex < 0)
        {
            endIndex = 0
        }
        
        if(endIndex >= photoItems.count)
        {
            endIndex = photoItems.count - 1
        }
        
        for  var i = 0 ;i < _itemCellINUse?.count ; i++
        {
            var tempItemV : ZXY_ImageItemView = _itemCellINUse?.allObjects[i] as! ZXY_ImageItemView
            var index = self.getIndexFromTag(tempItemV.tag)
            if(index < begainIndex || index > endIndex)
            {
                tempItemV.removeFromSuperview()
                _itemCellINUse?.removeObject(tempItemV)
            }
        }
        _itemCellINUse?.minusSet(_itemCellINDeuse! as Set<NSObject>)
        if(_itemCellINDeuse?.count > 2)
        {
            _itemCellINDeuse?.removeObject(_itemCellINDeuse!.anyObject()!)
        }
        
        for var j = begainIndex ; j <= endIndex ; j++
        {
            for  var i = 0 ;i < _itemCellINUse?.count ; i++
            {
                var tempItemV : ZXY_ImageItemView = _itemCellINUse?.allObjects[i] as! ZXY_ImageItemView
                var indexs = self.getIndexFromTag(tempItemV.tag)
                if(indexs == j)
                {
                    //tempItemV.setZoomScale(1, animated: true)
                    tempItemV.removeFromSuperview()
                    _itemCellINUse?.removeObject(tempItemV)
                }
            }
        }

    }
    
    private func getItemViewFromDeuser() -> ZXY_ImageItemView?
    {
        var tempItemView: ZXY_ImageItemView? = _itemCellINDeuse?.anyObject() as? ZXY_ImageItemView
        if(tempItemView != nil)
        {
            _itemCellINDeuse?.removeObject(tempItemView!)
        }
        return tempItemView
    }
    
    private func isViewShowing(index : Int) -> Bool
    {
        for  var i = 0 ;i < _itemCellINUse?.count ; i++
        {
            var tempItemV : ZXY_ImageItemView = _itemCellINUse?.allObjects[i] as! ZXY_ImageItemView
            var indexs = self.getIndexFromTag(tempItemV.tag)
            if(indexs == index)
            {
                //tempItemV.setZoomScale(1, animated: true)
                return true
            }
        }
        return false

    }
    
    private func showItemAtIndex(index: Int)
    {
        var tempImageView = self.getItemViewFromDeuser()
        if(tempImageView == nil)
        {
            var frame : CGRect = _currentScroll.bounds
            tempImageView = ZXY_ImageItemView(frame: CGRectMake(CGFloat(index) * frame.size.width + CGFloat(edgeWidth), 0, frame.size.width - CGFloat(2 * edgeWidth), frame.size.height))
        }
        else
        {
            var frame : CGRect = _currentScroll.bounds
           tempImageView?.frame = CGRectMake(CGFloat(index) * frame.size.width + CGFloat(edgeWidth), 0, frame.size.width - CGFloat(2 * edgeWidth), frame.size.height)
        }
        tempImageView?.delegateOfItem = self
        //tempImageView?.setTranslatesAutoresizingMaskIntoConstraints(false)
       
        //_titleLbl.text = "\(_currentIndex + 1) / \(photoItems.count) "
        //tempImageView?.setZoomScale(1, animated: true)
        tempImageView?.setCurrentItem(photoItems[index])
        tempImageView?.tag = self.getTagFromIndex(index)
        _currentScroll.addSubview(tempImageView!)
        _itemCellINUse?.addObject(tempImageView!)
        
        
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        //println("width is \(UIScreen.mainScreen().bounds.size.width)  height is \(UIScreen.mainScreen().bounds.size.height)")
        _isOriChange = true
        self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        self.removeShowView()
        self.startInitScrollView()
        self.showItemAtIndex(_currentIndex)
        _isOriChange = false
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        actionSheet?.hideSheet(self.view)
        actionSheet?.delegate = nil
        if(actionSheet != nil)
        {
            actionSheet = nil
        }
        _isOriChange = true
        self.view.frame = CGRectMake(0, 0, size.width, size.height)
        self.removeShowView()
        self.startInitScrollView()
        self.showItemAtIndex(_currentIndex)
        _isOriChange = false
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

}

extension ZXY_ImageBrowserVC : UIScrollViewDelegate
{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if(_isOriChange)
        {
            return
        }
        self.showPhotos()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var currentIndexs = scrollView.contentOffset.x / scrollView.frame.size.width
        _titleLbl.text = "\(Int(currentIndexs) + 1) / \(photoItems.count) "
         _currentIndex = Int(currentIndexs)
        
    }
}

// MARK: 单击事件
extension ZXY_ImageBrowserVC : ZXY_ImageItemViewDelegate , ZXY_SheetViewDelegate
{
    func longPressItemAtIndexPath(indexPath: Int, giveYouImage: UIImage) {
        if(self.delegate == nil)
        {
            return
        }
        
        if((self.view) != nil)
        {
            if(actionList != nil )
            {
                actionSheet = ZXY_SheetView(zxyTitle: nil, cancelBtn: actionCancel, andMessage: actionList!)
                actionSheet?.delegate = self
                actionSheet?.showSheet(self.view)
                _currentImageForGive = giveYouImage
            }
            
        }
    }
    
    func clickItemAtIndex(sheetView: ZXY_SheetView, index: Int) {
        if(self.delegate != nil)
        {
            if((self.delegate?.longPressClickActionSheetAtImage?(index, withImage: _currentImageForGive!)) != nil)
            {
                //println("实现了")
            }
            
            self.delegate?.longPressClickActionSheetAt(index)
        }
    }
    
    
    func clickItemAtIndexPath(indexPath: Int) {
        
        UIView.animateWithDuration(0.2, animations: { [weak self] () -> Void in
            
            if( self?._isTitleHide == true )
            {
                self?._isTitleHide = false
                var frames  = self?._titleView.frame as CGRect!
                self?._titleView.frame = CGRectMake(0, 0 , frames.size.width , frames.size.height)
                self?._titleView.alpha = 1

            }
            else
            {
                var frames  = self?._titleView.frame as CGRect!
                self?._isTitleHide = true
                self?._titleView.frame = CGRectMake(0, 0 - frames.size.height, frames.size.width , frames.size.height)
                self?._titleView.alpha = 0
                return
            }
        })
    }
    
    func hideBrowser()
    {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.view.alpha = 0
        }) { [weak self ](isDown) -> Void in
            //self?._itemCellINDeuse = nil
            //self?._itemCellINUse   = nil
            self?.view.removeFromSuperview()
            self?.removeFromParentViewController()
            
        }
    }
}
