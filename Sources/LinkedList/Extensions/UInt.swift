//
//  UInt.swift
//  
//
//  Created by Benjamin Morrison on 7/3/2023.
//

import Foundation

extension UInt {
    @discardableResult
    static prefix func ++(_ value: inout Self) -> Self {
        value += 1
        return value
    }
    
    @discardableResult
    static postfix func ++(_ value: inout Self) -> Self {
        return ++value
    }
    
    @discardableResult
    static prefix func --(_ value: inout Self) -> Self {
        value -= 1
        return value
    }
    
    @discardableResult
    static postfix func --(_ value: inout Self) -> Self {
        return --value
    }
}
