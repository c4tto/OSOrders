//
//  Order.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 03.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Order: Object {
    
    dynamic var id: String = ""
    dynamic var name: String?
    dynamic var count: Int = 0
    
    required init() {
        super.init()
    }
    
    convenience init(json: JSON) {
        self.init()
        
        id = json["id"].stringValue
        name = json["name"].string
        count = json["count"].intValue
    }

}
