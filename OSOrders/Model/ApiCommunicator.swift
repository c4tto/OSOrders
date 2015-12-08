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
import RealmSwift

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
    
    var contacts: [Contact] {
        // TODO: return contact list stored in Realm
        return []
    }
    
    func orders(contactId contactId: String) -> [Order] {
        // TODO: return orderlist list stored in Realm
        return []
    }
    
    func loadItems<T: Item>(path: String) -> Promise<[T]> {
        return self.requestOperationManager.GET(path, parameters: nil)
            .then { response -> Promise<[T]> in
                let items = JSON(response)["items"].arrayValue.map { T(json: $0) }
                // TODO: store item list to Realm
                return Promise(items)
            }
    }
    
    func loadContacts() -> Promise<[Contact]> {
        return self.loadItems(self.contactPath)
    }
    
    func loadOrders(contact contact: Contact) -> Promise<[Order]> {
        return self.loadItems(self.orderPath + contact.id)
    }
    
    func addContact(name name: String, phone: String) -> Promise<Contact> {
        return self.requestOperationManager.POST(self.contactPath, parameters: ["name": name, "phone": phone])
            .then { response -> Promise<Contact> in
                let contact = Contact(json: JSON(response))
                return Promise(contact)
            }
    }
}
