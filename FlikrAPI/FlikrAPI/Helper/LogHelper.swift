//
//  LogHelper.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/06/16.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Foundation

final class LogHelper {
    static func log(_ body: String = "", function: String = #function, line: Int = #line) {
        print("[\(function): \(line)] \(body)")
    }
}
