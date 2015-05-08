//
//  SR_OrderCommentFirstCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/7.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_OrderCommentFirstCellProtocol : class
{
    func commentTextChange(commentString : String)
}

class SR_OrderCommentFirstCell: UITableViewCell {
    
    var label : UILabel!
    weak var delegate : SR_OrderCommentFirstCellProtocol?
    @IBOutlet weak var commentText: UITextView!
    class func cellID() -> String
    {
        return "SR_OrderCommentFirstCellID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        label = UILabel(frame: CGRectMake(5, 7, 200, 20))
        label.enabled = false
        label.text = "对本次指尖之旅的评价..."
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.NailGrayColor()
        self.commentText.addSubview(label)
        commentText.delegate = self
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension SR_OrderCommentFirstCell : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        if commentText.text.isEmpty {
            self.label.hidden = false
        }
        else {
            self.label.hidden = true
        }
    }
    func textViewDidEndEditing(textView: UITextView) {
        self.delegate?.commentTextChange(commentText.text)
    }
}