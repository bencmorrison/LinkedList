//
//  File.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 29/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension LinkedList: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var node: Node<T>? = head
        var visitedHead = false
        
        return AnyIterator({ () -> T? in
            let obj = node?.object
            
            if node == self.head && visitedHead {
                return nil;
            }
            
            node = node?.next
            visitedHead = true
            
            return obj
        })
    }
    
}
