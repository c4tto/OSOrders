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
        didAddContact contact: Contact)
    func addContactViewControllerDidFinish(controller: AddContactViewController)
}

class AddContactViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var addContactButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: AddContactViewControllerDelegate?
    
    var sending: Bool = false {
        didSet {
            self.addContactButton.enabled = !sending
            self.nameTextField.enabled = !sending
            self.phoneTextField.enabled = !sending
            sending ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }

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
        self.phoneTextField.becomeFirstResponder()
        return true
    }
    
    // MARK: - Actions
    
    @IBAction func submit() {
        if let name = self.nameTextField.text, phone = self.phoneTextField.text
            where name.characters.count >= 5 && phone.characters.count >= 5 {
                
            self.addContact(name: name, phone: phone)
        } else {
            let error = NSError(domain: "OrdersLocalErrorDomain", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "All fields must be filled in!\n(at least 5 characters)"
            ])
            self.showError(error)
        }
    }
    
    @IBAction func dismiss() {
        self.delegate?.addContactViewControllerDidFinish(self)
    }
    
    func addContact(name name: String, phone: String) {
        if self.sending {
            return
        }
        
        self.sending = true
        self.apiCommunicator.addContact(name: name, phone: phone)
            .then { [weak self] contact -> Void in
                self?.delegate?.addContactViewController(self!, didAddContact: contact)
                self?.dismiss()
            }
            .always { [weak self] in
                self?.sending = false
            }
            .error { [weak self] error in
                self?.showError(error)
            }
    }
}
