//
//  ContactListViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 19.07.15.
//  Copyright (c) 2015 Ondrej Stocek. All rights reserved.
//

import UIKit
import AFNetworking

class ContactListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh", forControlEvents: .ValueChanged)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
        
        cell.nameLabel?.text = "Name"
        cell.phoneLabel?.text = "134 567 755"
        cell.photoImageView?.setImageWithURL(NSURL(string: "http://domaingang.com/wp-content/uploads/2012/02/example.png")!, placeholderImage: UIImage(named: "contact-default"))
        
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
