//
//  OrderCell.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = nil
        countLabel.text = nil
    }
}
