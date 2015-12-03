//
//  ApiCommunicator.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 03.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import AFNetworking
import PromiseKit
import SwiftyJSON

class ApiCommunicator: NSObject {
    
    let baseUrl = NSURL(string: "https://inloop-contacts.appspot.com/")
    let contactPath = "_ah/api/contactendpoint/v1/contact"
    let orderPath = "_ah/api/orderendpoint/v1/order/"
    
    lazy var requestOperationManager: AFHTTPRequestOperationManager = {
        let manager = AFHTTPRequestOperationManager(baseURL: self.baseUrl)
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        return manager
    }()
    
    func loadContacts() -> Promise<JSON> {
        return self.requestOperationManager.GET(self.contactPath, parameters: nil)
            .then { response -> Promise<JSON> in
                return Promise(JSON(response))
            }
    }
    
    func loadOrdersForContact(contactId: String) -> Promise<JSON> {
        return self.requestOperationManager.GET(self.orderPath + contactId, parameters: nil)
            .then { response -> Promise<JSON> in
                return Promise(JSON(response))
            }
    }
    
    func addContact(name name: String, phone: String) -> Promise<JSON> {
        return self.requestOperationManager.POST(self.contactPath, parameters: [
            "name": name,
            "phone": phone,
        ]).then({ response -> Promise<JSON> in
            return Promise(JSON(response))
        })
    }
}
