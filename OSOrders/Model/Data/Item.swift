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
    
    convenience required init(json: JSON) {
        self.init()
        self.update(json: json)
    }
    
    func update(json json: JSON) {
        id = json["id"].stringValue
        name = json["name"].string
    }

    // MARK: - Static Methods
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
