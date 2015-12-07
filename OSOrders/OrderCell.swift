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
        
        self.nameLabel.text = nil
        self.countLabel.text = nil
    }
    
    weak var order: Order? {
        didSet {
            self.nameLabel.text = order?.name
            self.countLabel.text = (order?.count).flatMap { "\($0)x" }
        }
    }

}
