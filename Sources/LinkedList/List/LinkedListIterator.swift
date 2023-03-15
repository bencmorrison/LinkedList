//
//  File.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 29/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public struct LinkedListIterator<T>: IteratorProtocol {
    public typealias Element = T
    
    private let list: LinkedList<Element>
    private var currentNode: Node<Element>? = nil
    private var atStart: Bool = true
    
    public init(list: LinkedList<T>) {
        self.list = list
        self.currentNode = list.head
    }
    
    public mutating func next() -> Element? {
        guard let currentNode else { return nil }
        
        let object = currentNode.element
        self.currentNode = currentNode.next
        
        return object
    }
}

