//
//  ContactListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 19.07.15.
//  Copyright (c) 2015 Ondrej Stocek. All rights reserved.
//

import UIKit
import PromiseKit
import SwiftyJSON

class ContactListViewController: UITableViewController {
    
    var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
        let communicator = ApiCommunicator()
        communicator.loadContacts()
            .then { [weak self] json -> Promise<[Contact]?> in
                print(json)
                self?.contacts = json["items"].arrayValue.map { Contact(json: $0) }
                self?.tableView.reloadData()
                return Promise(self?.contacts)
            }
            .error { error in
                print(error)
            }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
        cell.contact = self.contacts[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("OrderListViewController")
        self.navigationController?.pushViewController(controller!, animated: true)
    }

    // MARK: - Actions
    
    @IBAction func showAddContact(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("AddContactNavController");
        self.presentViewController(controller!, animated: true, completion: nil)
    }
    
    func refresh() {
        self.refreshControl?.endRefreshing()
    }
}
