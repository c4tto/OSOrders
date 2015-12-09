//
//  OrderListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit
import PromiseKit

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var phoneLabel: UILabel!
    
    var contact: Contact!
    var orders: [Order] = [] {
        didSet {
            orders = orders.sort { $0.name?.lowercaseString < $1.name?.lowercaseString }
            self.tableView.reloadData()
        }
    }
    
    private var refreshing: Bool = false {
        didSet {
            if refreshing {
                if !self.refreshControl.refreshing && self.orders.isEmpty {
                    self.refreshControl.beginRefreshing()
                    self.tableView.setContentOffset(CGPointMake(0, -self.refreshControl.frame.size.height), animated: true)
                }
            } else {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
        return refreshControl
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.addSubview(self.refreshControl)
        self.tableView.scrollsToTop = true
        
        self.navigationItem.title = self.contact?.name
        self.phoneLabel.text = self.contact?.phone
        
        self.refresh()
    }
    
    // MARK: - Table View Data Source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReuesableCellOfType(OrderCell.self, forIndexPath: indexPath)
        cell.order = self.orders[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    // MARK: - Actions
    
    func refresh() {
        if self.refreshing {
            return
        }
        
        self.refreshing = true
        self.apiCommunicator.loadOrders(contact: self.contact)
            .then { [weak self] orders in
                self?.orders = orders
            }
            .always { [weak self] in
                self?.refreshing = false
            }
            .error { [weak self] error in
                self?.showError(error)
            }
    }
}
