//
//  AddContactViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

class AddContactViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view delegate
    
    
    // MARK: - Acions
    
    @IBAction func addContact() {
        // TODO: add contact
        self.dismiss()
    }
    
    @IBAction func dismiss() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
