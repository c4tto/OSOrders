//
//  ContactListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 19.07.15.
//  Copyright (c) 2015 Ondrej Stocek. All rights reserved.
//

import UIKit
import PromiseKit

class ContactListViewController: UITableViewController, AddContactViewControllerDelegate {
    
    var contacts: [Contact] = [] {
        didSet {
            contacts = contacts.sort { $0.name?.lowercaseString < $1.name?.lowercaseString }
            self.tableView.reloadData()
        }
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
        self.contacts = self.apiCommunicator.contacts
        self.refresh()
    }
    
    // MARK: - Table View Data Source

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
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("OrderListViewController") as! OrderListViewController
        controller.contact = self.contacts[indexPath.row]
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction func showAddContact(sender: AnyObject) {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("AddContactViewController") as! AddContactViewController
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
    func refresh() {
        if !self.refreshControl!.refreshing && self.contacts.isEmpty {
            self.refreshControl!.beginRefreshing()
            self.tableView.setContentOffset(CGPointMake(0, -self.refreshControl!.frame.size.height), animated: true)
        }
        
        self.apiCommunicator.loadContacts()
            .then { [weak self] contacts in
                self?.contacts = contacts
            }
            .always { [weak self] in
                self?.refreshControl!.endRefreshing()
            }
            .error { [weak self] error in
                self?.showError(error)
            }
    }
    
    // MARK: - Add Contact View Controller Delegate
    
    func addContactViewController(controller: AddContactViewController, didFillInFormWithName name: String, phone: String) {
        self.apiCommunicator.addContact(name: name, phone: phone)
            .then { [weak self] contact in
                self?.contacts += [contact]
            }
            .error { [weak self] error in
                self?.showError(error)
            }
    }
    
    func addContactViewControllerDidFinish(controller: AddContactViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

