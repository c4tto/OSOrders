//
//  OrderListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.refreshControl = UIRefreshControl()
        //self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell", forIndexPath: indexPath) as! OrderCell
        
        cell.nameLabel.text = "MacBook Air"
        cell.countLabel.text = "1x"
        
        return cell;
    }
    
    // MARK: - Actions
    
    func refresh() {
        //self.refreshControl?.endRefreshing()
    }
}
