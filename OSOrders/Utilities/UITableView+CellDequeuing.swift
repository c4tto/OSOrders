//
//  UITableView+CellDequeuing.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 08.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReuesableCellOfType<T: UITableViewCell>(type: T.Type, forIndexPath indexPath: NSIndexPath) -> T {
       return self.dequeueReusableCellWithIdentifier(T.typeName, forIndexPath: indexPath) as! T
    }
}
