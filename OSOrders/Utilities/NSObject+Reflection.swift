//
//  NSObject+Reflection.swift
//  OSOrders
//
//  Created by Ondrej Stocek on 08/12/15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import Foundation

extension NSObject {
    
    class var className: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    var className: String {
        return self.dynamicType.className
    }
}