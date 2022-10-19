//
//  File.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 29/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension LinkedList: Collection {
    public typealias Element = T
    public typealias Iterator = LinkedListIterator<Element>
    public typealias Index = UInt
    
    public func makeIterator() -> Iterator {
        return LinkedListIterator<T>(list: self)
    }
    
    public var startIndex: Index { 0 }
    public var endIndex: Index { count - 1 }
    
    public subscript(position: UInt) -> T {
        get { return objectAt(index: position) }
        set { insert(object: newValue, atIndex: position) }
    }
    
    public func index(after i: UInt) -> UInt {
        let nextIndex = i + 1
        assert(indexIsValid(nextIndex))
        return nextIndex
    }
}

public struct LinkedListIterator<T>: IteratorProtocol {
    public typealias Element = T
    
    private let list: LinkedList<T>
    private var currentNode: Node<T>? = nil
    private var atStart: Bool = true
    
    public init(list: LinkedList<T>) {
        self.list = list
    }
    
    public mutating func next() -> Element? {
        if atStart { currentNode = list.head }
        guard let currentNode else { return nil }
        
        let object = currentNode.object
        
        self.currentNode = currentNode.next
        
        if !atStart && currentNode.isNode(list.head) { return nil }
        atStart = false
        
        return object
    }
}

