//
//  NSError+Alamofire.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 08.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import Foundation
import AFNetworking
import SwiftyJSON

extension ErrorType {
    
    var serverApiError: ErrorType? {
        if let jsonData = ((self as Any) as! NSError).userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] as? NSData {
            let json = JSON(data: jsonData)
			
            if let code = json["error"]["code"].int, message = json["error"]["message"].string {
                return NSError(domain: "OrdersServerErrorDomain", code: code, userInfo: [
                    NSLocalizedDescriptionKey: message
                ])
            }
        }
        return nil
    }
}