//
//  UIStoryboard+ViewControllerInstantiation.swift
//  OSOrders
//
//  Created by Ondrej Stocek on 08/12/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiateViewControllerOfType<T: UIViewController>(type: T.Type) -> T {
        return self.instantiateViewControllerWithIdentifier(T.typeName) as! T
    }
}
