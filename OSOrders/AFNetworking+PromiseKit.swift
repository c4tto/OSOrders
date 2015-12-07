//
//  AFNetworking+PromiseKit.swift
//  OSOrders
//
//  Created by Ondřej Štoček on 02.12.15.
//  Copyright © 2015 Ondrej Stocek. All rights reserved.
//

import AFNetworking
import PromiseKit

extension AFHTTPRequestOperationManager {
    
    func GET(urlString: String, parameters: AnyObject?) -> Promise<AnyObject> {
        return Promise { fullfill, reject in
            self.GET(urlString, parameters: parameters,
                success: { operation, response in
                    fullfill(response)
                },
                failure: { operation, error in
                    reject(error)
                })
        }
    }
    
    func POST(urlString: String, parameters: AnyObject?) -> Promise<AnyObject> {
        return Promise { fullfill, reject in
            self.POST(urlString, parameters: parameters,
                success: { operation, response in
                    fullfill(response)
                },
                failure: { operation, error in
                    reject(error)
                })
        }
    }
}
