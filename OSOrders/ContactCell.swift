//
//  ContactCell.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = nil
        phoneLabel.text = nil
    }
    
    weak var contact: Contact? {
        didSet {
            nameLabel.text = contact?.name
            phoneLabel.text = contact?.phone
            pictureImageView.image = UIImage(named: "contact-default")
            if let pictureUrl = contact?.pictureUrl {
                pictureImageView.setImageWithURL(pictureUrl, placeholderImage: pictureImageView.image)
            }
        }
    }
}
