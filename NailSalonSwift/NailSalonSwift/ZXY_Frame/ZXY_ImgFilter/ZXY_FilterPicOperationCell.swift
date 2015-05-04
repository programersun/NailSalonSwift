//
//  ZXY_FilterPicOperationCell.swift
//  GPUImageDemo
//
//  Created by 宇周 on 15/2/27.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit
let ZXY_FilterPicOperationCellID = "ZXY_FilterPicOperationCellID"

protocol ZXY_FilterPicOperationCellDelegate : class
{
    func clickItemForTag(itemTag : ZXY_FilterImgType) -> Void
}

class ZXY_FilterPicOperationCell: UITableViewCell {

    
    private var filterScrollV : UIScrollView!
    private var filterImgV    : [UIView]!
    private var filterTitle   : [String]! = ["原图" , "对比" , "亮度" , "饱和度" , "光晕" , "复古" , "灰色"]
    private var originalImage : UIImage?
    
    weak var delegate : ZXY_FilterPicOperationCellDelegate?
    var filterImg : UIImage?
   // private var filterContentV : UIView!
    
    convenience init(frame: CGRect) {
        self.init(frame: frame)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init() {
        self.init(style: UITableViewCellStyle.Default, reuseIdentifier: ZXY_FilterPicOperationCellID)
       self.selectionStyle = UITableViewCellSelectionStyle.None
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
         self.backgroundColor = UIColor.clearColor()
        if(filterScrollV == nil)
        {
            filterScrollV  = UIScrollView()
            filterScrollV.contentSize = CGSizeMake(80 * 7 + 140, 115)
            filterScrollV.backgroundColor = UIColor.clearColor()
            filterScrollV.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.addSubview(filterScrollV)
            self.addScrollCons()
            if(filterImgV == nil)
            {
                filterImgV = []
                for var i = 0 ; i < 7 ; i++
                {
                    if(i == 0)
                    {
                        var firstView = UIView(frame: CGRectMake(10, 0, 80, 115))
                        firstView.tag = i
                        var firstImg  = UIImageView(frame: CGRectMake(0, 0, 80, 115))
                        var firstLbl  = UILabel(frame: CGRectMake(0, 115 - 25, 80, 20))
                        firstLbl.textAlignment = NSTextAlignment.Center
                        firstLbl.tag = 1001
                        firstLbl.text = filterTitle[i]
                        firstLbl.textColor = UIColor.whiteColor()
                        firstImg.tag = 1000
                        firstView.addSubview(firstImg)
                        firstView.addSubview(firstLbl)
                        firstView.clipsToBounds = true
                        firstImg.contentMode = UIViewContentMode.ScaleAspectFill
                        if(filterImg != nil)
                        {
                            firstImg.image = filterImg
                        }
                        filterImgV.append(firstView)
                    }
                    else
                    {
                        var commonSapce = 10 + 100 * i
                        var commonView = UIView(frame: CGRectMake(CGFloat(commonSapce), 0, 80, 115))
                        commonView.clipsToBounds = true
                        commonView.tag = i
                        var commonImg  = UIImageView(frame: CGRectMake(0, 0, 80, 115))
                        commonImg.tag = 1000 + i
                        commonImg.contentMode = UIViewContentMode.ScaleAspectFill
                        if(filterImg != nil)
                        {
                            //commonImg.image = filterImg
                            switch i
                            {
                            case 1:
                                commonImg.image = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(ZXY_FilterImgType.FilterImgContrast, originImage: filterImg!, valueO: 0.5)
                            case 2:
                                commonImg.image = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(ZXY_FilterImgType.FilterImgBrightness, originImage: filterImg!, valueO: -0.5)
                            case 3:
                                commonImg.image = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(ZXY_FilterImgType.FilterImgSaturation, originImage: filterImg!, valueO: 0.5)
                            case 4:
                                commonImg.image = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(ZXY_FilterImgType.FilterImgVignette, originImage: filterImg!, valueO: nil)
                            case 5:
                                commonImg.image = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(ZXY_FilterImgType.FilterImgMonochrome, originImage: filterImg!, valueO: 0.5)
                            case 6:
                                commonImg.image = ZXY_GPUImageFilterHelper.sharedInstance.filterImageWithFilterType(ZXY_FilterImgType.FilterImggrayscale, originImage: filterImg!, valueO: nil)
                            default:
                                commonImg.image = filterImg
                            }
                        }
                        
                        var firstLbl  = UILabel(frame: CGRectMake(0, 115 - 25, 80, 20))
                        firstLbl.textAlignment = NSTextAlignment.Center
                        firstLbl.tag = 1001
                        firstLbl.text = filterTitle[i]
                        firstLbl.textColor = UIColor.whiteColor()
                        commonView.addSubview(commonImg)
                        commonView.addSubview(firstLbl)
                        filterImgV.append(commonView)
                    }
                }
                
            }
            
            filterImgV.map({ [weak self](currentImg) -> Void in
                
                currentImg.backgroundColor = UIColor.clearColor()
                self?.filterScrollV.addSubview(currentImg)
                currentImg.userInteractionEnabled = true
                var tap = UITapGestureRecognizer(target: self!, action: Selector("userClickItem:"))
                currentImg.addGestureRecognizer(tap)
            })
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func userClickItem(tap : UITapGestureRecognizer)
    {
        //println("tap is \(tap.view?.tag)")
        var tagFlag = tap.view?.tag
        tagFlag     = tagFlag ?? 0
        var currentFilterType : ZXY_FilterImgType = ZXY_FilterImgType.FilterImgOrigin.typeWithInt(tagFlag!)
        self.delegate?.clickItemForTag(currentFilterType)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func addScrollCons()
    {
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: filterScrollV, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: -5))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: filterScrollV, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: filterScrollV, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: filterScrollV, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0))
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
