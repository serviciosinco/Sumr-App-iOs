//
//  ViewControllerTableViewCell.swift
//  CRM SUMR
//
//  Created by Programador Master on 28/08/17.
//  Copyright © 2017 Servicios.in. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var _ec_img: UIImageView!
    @IBOutlet weak var _ec_tt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("aqui")
        // Configure the view for the selected state
    }

}
