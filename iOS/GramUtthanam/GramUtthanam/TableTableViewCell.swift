//
//  TableTableViewCell.swift
//  GramUtthanam
//
//  Created by Prateek Sharma on 1/13/19.
//  Copyright © 2019 Prateek Sharma. All rights reserved.
//

import UIKit

class TableTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cropNameLbl: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    func setup(data: ItemBid) {
        let crops = CropCategory.availableCropTypes
        
        for crop in crops {
            if crop.id == data.cropTypeID {
                cropNameLbl.text = crop.name
                break
            }
        }
        
        quantity.text = "\(data.quantity) quintal"
        locationLbl.text = data.address
        statusLbl.text = data.status
        
        let greenColor = UIColor(hexValue: 0x0FA45A)
        let yellowColor = UIColor(hexValue: 0xF6AA42)
        
        if data.status == "In Process" {
            statusLbl.superview?.borderColor = yellowColor
            statusLbl.textColor = yellowColor
        } else if data.status == "Accepted" {
            statusLbl.superview?.borderColor = greenColor
            statusLbl.textColor = greenColor
        }
        
    }
    
}


extension UIColor {
    
    convenience init(hexValue: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hexValue & 0xFF0000) >> 16)/255.0
        let green = CGFloat((hexValue & 0xFF00) >> 8)/255.0
        let blue = CGFloat(hexValue & 0xFF)/255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
