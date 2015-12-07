//
//  UIViewController+Error.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 07.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showError(error: ErrorType) {
        let message = (error as NSError).localizedDescription
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
