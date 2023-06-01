// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

extension LinkedList: Equatable where Node<T>: Equatable {
    public static func ==(lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
        guard lhs.count == rhs.count else { return false }
        
        var lhsNode = lhs.head
        var rhsNode = rhs.head
        
        while lhsNode != nil && rhsNode != nil {
            guard
                let lhsItem = lhsNode?.element,
                let rhsItem = rhsNode?.element,
                    lhsItem == rhsItem
            else { return false }
            
            lhsNode = lhsNode?.next
            rhsNode = rhsNode?.next
        }
        
        return true
    }
}
