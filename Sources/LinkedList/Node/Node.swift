//
//  ListNode.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

open class Node<T> {
    public var element: T
    public internal(set) var next: Node<T>?
    public internal(set) weak var previous: Node<T>?
    
    init(_ element: T, next: Node<T>? = nil, previous: Node<T>? = nil) {
        self.element = element
        self.next = next
        self.previous = previous
    }
    
    func isNode(_ other: Node<T>?) -> Bool {
        guard let other else { return false }
        return Unmanaged.passUnretained(self).toOpaque() == Unmanaged.passUnretained(other).toOpaque()
    }
}
