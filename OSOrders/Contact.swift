//
//  Contact.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 03.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Contact: Object {

    dynamic var id: String = ""
    dynamic var name: String?
    dynamic var phone: String?
    dynamic var pictureUrlString: String?
    
    required init() {
        super.init()
    }
    
    init(json: JSON) {
        super.init()
        
        id = json["id"].stringValue
        name = json["name"].string
        phone = json["phone"].string
        pictureUrlString = json["pictureUrl"].string
    }
    
    var pictureUrl: NSURL? {
        return pictureUrlString.flatMap { NSURL(string: $0) }
    }
}
