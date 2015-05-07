//
//  SR_OrderTableCell.swift
//  NailSalonSwift
//
//  Created by sun on 15/5/4.
//  Copyright (c) 2015年 宇周. All rights reserved.
//

import UIKit

protocol SR_OrderTableCellProtocol : class {
    func orderDelete(orderId : String)
}

class SR_OrderTableCell: UITableViewCell {
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nickName: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderAddress: UILabel!
    @IBOutlet weak var orderAblum: UILabel!
    @IBOutlet weak var orderState: UILabel!
    @IBOutlet weak var orderDeleteBtn: UIButton!
    
    var delegate : SR_OrderTableCellProtocol?
    var orderID : String?
    
    class func cellID() -> String
    {
        return "SR_OrderTableCellID"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func orderDeleteBtnClick(sender: AnyObject) {
        
        var editAler = UIAlertView()
        editAler.message  = "您确定删除订单吗？"
        editAler.title    = "提示"
        editAler.addButtonWithTitle("取消")
        editAler.addButtonWithTitle("确定")
        editAler.delegate = self
        editAler.show()
        
    }
}
extension SR_OrderTableCell : UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            self.delegate?.orderDelete(self.orderID!)
        }
        else {
            return
        }
    }
}
