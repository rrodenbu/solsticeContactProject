//
//  Reachability.swift
//  ApplePayWhere
//
//  Created by Riley Rodenburg on 9/6/15.
//  Copyright © 2015 Riley Rodenburg. All rights reserved.
//

//Code source: http://www.brianjcoleman.com/tutorial-check-for-internet-connection-in-swift/
//CODE SOURCE: http://stackoverflow.com/questions/30743408/check-for-internet-conncetion-in-swift-2-ios-9
import Foundation
import SystemConfiguration

/*Checking for internet connection*/
public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let needsConnection = flags.contains(.ConnectionRequired)
        return (isReachable && !needsConnection)
    }
}