//
//  AddContactViewController.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 01.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

protocol AddContactViewControllerDelegate: class {
    func addContactViewController(controller: AddContactViewController,
        didFillInFormWithName name: String, phone: String)
    func addContactViewControllerDidFinish(controller: AddContactViewController)
}

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: AddContactViewControllerDelegate?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameTextField.becomeFirstResponder()
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        phoneTextField.becomeFirstResponder()
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func addContact() {
        if let name = self.nameTextField.text, phone = self.phoneTextField.text where !name.isEmpty && !phone.isEmpty {
            self.delegate?.addContactViewController(self, didFillInFormWithName: name, phone: phone)
            self.dismiss()
        } else {
            let error = NSError(domain: "OSOrdersErrorDomain", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "All fields must be filled in!"
            ]);
            self.showError(error)
        }
    }
    
    @IBAction func dismiss() {
        self.delegate?.addContactViewControllerDidFinish(self)
    }
}
