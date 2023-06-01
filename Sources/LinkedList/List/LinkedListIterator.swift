// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

/// Provides the ability to iterate over a `LinkedList`
public struct LinkedListIterator<T>: IteratorProtocol {
    /// The type of element being traversed in the `LinkedList`
    public typealias Element = T
    
    private let list: LinkedList<Element>
    private var currentNode: Node<Element>? = nil
    private var atStart: Bool = true
    
    /// Initalises the `LinkedListIterator` for use on the supplied list.
    /// - Parameters list: the list that will be iterated over.
    public init(list: LinkedList<T>) {
        self.list = list
        self.currentNode = list.head
    }
    
    /// Advances to the next element in the list.
    /// - Returns: next element in the list, else `nil`
    public mutating func next() -> Element? {
        guard let currentNode else { return nil }
        
        let object = currentNode.element
        self.currentNode = currentNode.next
        
        return object
    }
}

