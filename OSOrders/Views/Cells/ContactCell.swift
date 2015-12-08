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
        self.nameLabel.text = nil
        self.phoneLabel.text = nil
    }
    
    weak var contact: Contact? {
        didSet {
            self.nameLabel.text = contact?.name
            self.phoneLabel.text = contact?.phone
            self.pictureImageView.image = UIImage(named: "contact-default")
            if let pictureUrl = contact?.pictureUrl {
                self.pictureImageView.setImageWithURL(pictureUrl, placeholderImage: pictureImageView.image)
            }
        }
    }
}
