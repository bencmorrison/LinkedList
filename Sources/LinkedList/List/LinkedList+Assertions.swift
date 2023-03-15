//
//  LinkedList+Assertions.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import Foundation


extension LinkedList {
    // MARK: Validation
    
    internal enum Operation: String {
        case query
        case insert
        case remove
    }
    
    // fatalError(_ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line)
    
    internal func assertValidIndex(
        _ index: Index, for operation: Operation = .query,
        file: StaticString = #file, line: UInt = #line
    ) {
        
        var okay: Bool
        switch operation {
        case .query, .remove:
            okay = index < count && count > 0
        case .insert:
            okay = 0 <= index && index <= count
        }
        
        guard !okay else { return }
        fatalError("Index out of bounds for operation: \(operation.rawValue)", file: file, line: line)
    }
    
    internal func assertListIsNotEmpty(
        ile: StaticString = #file, line: UInt = #line
    ) {
        guard count == 0 else { return }
        fatalError("Unable to perform action on an empty list.")
    }
}
