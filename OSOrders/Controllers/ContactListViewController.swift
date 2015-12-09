//
//  ContactListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 19.07.15.
//  Copyright (c) 2015 Ondrej Stocek. All rights reserved.
//

import UIKit
import PromiseKit

class ContactListViewController: UITableViewController {
    
    var contacts: [Contact] = [] {
        didSet {
            contacts = contacts.sort { $0.name?.lowercaseString < $1.name?.lowercaseString }
            self.tableView.reloadData()
        }
    }
    
    private var refreshing: Bool = false {
        didSet {
            if refreshing {
                if !self.refreshControl!.refreshing && self.contacts.isEmpty {
                    self.refreshControl!.beginRefreshing()
                    self.tableView.setContentOffset(CGPointMake(0, -self.refreshControl!.frame.size.height), animated: true)
                }
            } else {
                self.refreshControl!.endRefreshing()
            }
        }
    }

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "applicationDidBecomeActive:",
            name: UIApplicationDidBecomeActiveNotification,
            object: nil)
		
        self.refresh()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.contacts = self.apiCommunicator.contacts
    }
    
    func applicationDidBecomeActive(notification: NSNotification) {
        self.refreshing = false
        self.refresh()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Table View Data Source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReuesableCellOfType(ContactCell.self, forIndexPath: indexPath)
        cell.contact = self.contacts[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = self.storyboard!.instantiateViewControllerOfType(OrderListViewController.self)
        controller.contact = self.contacts[indexPath.row]
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    // MARK: - Actions
    
    func refresh() {
        if self.refreshing {
            return
        }
        
        self.refreshing = true
        self.apiCommunicator.loadContacts()
            .then { [weak self] contacts in
                self?.contacts = contacts
            }
            .always { [weak self] in
                self?.refreshing = false
            }
            .error { [weak self] error in
                self?.showError(error)
            }
    }
}

