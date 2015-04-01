//
//  ZXY_ORCourseMainSecondCell.swift
//  NailSalonSwift
//
//  Created by 宇周 on 15/3/31.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

class ZXY_ORCourseMainSecondCell: UITableViewCell {

    
    @IBOutlet weak var headerImg: UIImageView!
    @IBOutlet weak var littleBar: UIImageView!
    @IBOutlet weak var headerTitleLbl: UILabel!
    @IBOutlet weak var headerSubTitle: UILabel!
    
    @IBOutlet var imgS: [UIImageView]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func cellID() -> String
    {
        return "ZXY_ORCourseMainSecondCellID"
    }
    
    func setImgs(courses : [ZXYCourseCourse]?)
    {
        if(courses == nil)
        {
            return
        }
        if(courses?.count <= imgS.count)
        {
            for (index , value) in enumerate(courses!)
            {
                var currentImg = imgS[index]
                if(index <= imgS.count - 1)
                {
                    var url : String? = value.imgPath
                    if let urlString = url
                    {
                        var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + urlString
                        currentImg.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "imgHolder"))
                    }
                    else
                    {
                        currentImg.image = UIImage(named: "imgHolder")
                    }
                }
            }
        }
        else
        {
            for (index , value) in enumerate(imgS)
            {
                var course = courses![index]
                var url: String?    = course.imgPath
                if let urlString = url
                {
                    var imgURL = ZXY_NailNetAPI.ZXY_MainAPIImage + urlString
                    value.setImageWithURL(NSURL(string: imgURL), placeholderImage: UIImage(named: "imgHolder"))
                }
            }
        }
    }

}
