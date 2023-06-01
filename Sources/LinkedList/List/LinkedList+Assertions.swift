//
//  LinkedList+Assertions.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import Foundation


extension LinkedList {
    // MARK: Validation
    
    /**
     Used for `assertValidIndex(_:for:file:line:)` function.
     Operation is used to define the index checks.
     */
    public enum Operation: String {
        /// Used when the check is for querying the list
        case query
        /// Used when the check is for an insert to the list
        case insert
        /// Used when the check is for a removal of a node from the list
        /// and also ensures that count is not zero.
        case remove
    }
    
    /**
     Used to assert that the index passed into a function is valid.
     The operation type is required to determine if the index passed
     is a valid index for the operation type.
     
     Generally speaking, an insert index can be `count`, while query
     and removal must be `count - 1`
     - Parameters:
        - index: The index that needs to be checked for validity
        - operation: The operation type we are checking. Default: `query`
     - Warning: A `fatalError` will occure if the index is out of bounds.
     */
    public func assertValidIndex(
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
        
        let message: String
        if count == 0 {
            message = "Unable to peform operation (\(operation.rawValue)) on an empty list."
        } else {
            message = "Index out of bounds for operation: \(operation.rawValue)."
        }
        
        fatalError(message, file: file, line: line)
    }
}
