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
    
    func loadContacts() -> Promise<[Contact]> {
        return self.requestOperationManager.GET(self.contactPath, parameters: nil)
            .then { response -> Promise<[Contact]> in
                print(response)
                let contacts = JSON(response)["items"].arrayValue.map { Contact(json: $0) }
                return Promise(contacts)
            }
    }
    
    func loadOrders(contactId contactId: String) -> Promise<[Order]> {
        return self.requestOperationManager.GET(self.orderPath + contactId, parameters: nil)
            .then { response -> Promise<[Order]> in
                print(response)
                let orders = JSON(response)["items"].arrayValue.map { Order(json: $0) }
                return Promise(orders)
            }
    }
    
    func addContact(name name: String, phone: String) -> Promise<Contact> {
        return self.requestOperationManager.POST(self.contactPath, parameters: [
            "name": name,
            "phone": phone,
        ]).then({ response -> Promise<Contact> in
            print(response)
            let contact = Contact(json: JSON(response))
            return Promise(contact)
        })
    }
}
