//
//  Contact.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 03.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Contact: Item {
    
    dynamic var phone: String?
    dynamic var pictureUrlString: String?
 
    convenience required init(json: JSON) {
        self.init()
        self.update(json: json)
    }
    
    override func update(json json: JSON) {
        super.update(json: json)
        phone = json["phone"].string
        pictureUrlString = json["pictureUrl"].string
    }
    
    // MARK: - Convenience attributes
    
    var pictureUrl: NSURL? {
        return pictureUrlString.flatMap { NSURL(string: $0) }
    }
}
