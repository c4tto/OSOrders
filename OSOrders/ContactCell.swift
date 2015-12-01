//
//  ContactCell.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = nil
        phoneLabel.text = nil
    }
}
