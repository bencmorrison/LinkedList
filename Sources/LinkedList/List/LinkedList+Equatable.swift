//
//  BCMDoublyLinkedListEquatableExtension.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 2/05/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension LinkedList: Equatable where Node<T>: Equatable {
    public static func ==(lhs: LinkedList<Element>, rhs: LinkedList<Element>) -> Bool {
        guard lhs.count == rhs.count else { return false }
        
        let count = lhs.count
        guard count > 0 else { return true }
        
        var lhsNode = lhs.head
        var rhsNode = rhs.head
        
        for _ in 0..<count {
            guard lhsNode == rhsNode else { return false }
            lhsNode = lhsNode?.next
            rhsNode = rhsNode?.next
        }
        
        return true
    }
}
