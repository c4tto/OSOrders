//
//  OrderListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

import PromiseKit
import SwiftyJSON

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var phoneLabel: UILabel!
    
    var contact: Contact?
    var orders: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.contact?.name
        self.phoneLabel.text = self.contact?.phone
        
        if let contactId = contact?.id {
            let communicator = ApiCommunicator()
            communicator.loadOrders(contactId: contactId)
                .then { [weak self] json -> Promise<[Order]?> in
                    print(json)
                    self?.orders = json["items"].arrayValue.map { Order(json: $0) }
                    self?.tableView.reloadData()
                    return Promise(self?.orders)
                }
                .error { error in
                    print(error)
            }
        }
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
        cell.order = self.orders[indexPath.row]
        return cell;
    }
}
