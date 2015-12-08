//
//  Item.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 07.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Item: Object {
    
    dynamic var id: String = ""
    dynamic var name: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required init() {
        super.init()
    }
    
    required init(json: JSON) {
        super.init()
        
        self.update(json: json)
    }
    
    func update(json json: JSON) {
        id = json["id"].stringValue
        name = json["name"].string
    }

}
