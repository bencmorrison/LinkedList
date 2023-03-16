//
//  ListNode.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

/**
 `Node` is used by the `LinkedList`.
 */
open class Node<T> {
    /// The element
    public var element: T
    /// The next node in the list, or nil if it is the end of the list
    public internal(set) var next: Node<T>?
    /// The previous node in the list, or nil if it is the start of the list
    public internal(set) weak var previous: Node<T>?
    
    /**
     Initalises the node for the list with the element.
     - Parameters:
        - element: The element to store
        - next: The next node to point too
        - previousL: The previous node to point to
     */
    init(_ element: T, next: Node<T>? = nil, previous: Node<T>? = nil) {
        self.element = element
        self.next = next
        self.previous = previous
    }
    
    /**
     This does a straight up address check if the node is the passed in node.
     - Parameter other: The node we are checking if it is this node.
     - Returns: True if the addresses match, false if they do not.
     */
    func isNode(_ other: Node<T>?) -> Bool {
        guard let other else { return false }
        return Unmanaged.passUnretained(self).toOpaque() == Unmanaged.passUnretained(other).toOpaque()
    }
}
