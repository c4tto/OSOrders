//
//  Order.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 03.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Order: Item {
    
    dynamic var count: Int = 0
    
    override func update(json json: JSON) {
        super.update(json: json)
        count = json["count"].intValue
    }
}
