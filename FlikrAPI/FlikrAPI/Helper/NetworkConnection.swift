//
//  NetworkConnection.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Foundation
import Reachability

final class NetworkConnection {
    
    /// ネットワーク接続状況確認
    ///
    /// - Returns: true: オンライン, false: オフライン
    static func isConnectable() -> Bool {
        
        guard let reachability = Reachability() else {
            return false
        }
        
        let connection = reachability.connection
        if connection != .none {
            return true
        }
        return false
    }
}
