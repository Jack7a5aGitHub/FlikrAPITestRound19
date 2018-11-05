//
//  NSObject+ClassName.swift
//  FlikrAPI
//
//  Created by Jack Wong on 2018/11/06.
//  Copyright © 2018 Jack Wong. All rights reserved.
//

import Foundation

public extension NSObject {
    
    /// クラス名を取得する
    static var className: String {
        return String(describing: self)
    }
}
