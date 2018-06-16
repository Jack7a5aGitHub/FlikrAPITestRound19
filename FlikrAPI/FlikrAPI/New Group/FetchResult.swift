//
//  FetchResult.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Foundation

enum FetchResult {
    
    case offline
    case success([Photo])
    case error(message: String)
}

protocol ReturnResult: class {
    
    func returnResult(returnCode: FetchResult)
}
