//
//  UIViewController+ApiCommunicator.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 07.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var apiCommunicator: ApiCommunicator {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.apiCommunicator
    }
}
