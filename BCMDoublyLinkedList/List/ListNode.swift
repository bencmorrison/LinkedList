//
//  ListNode.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public final class ListNode<T> {
    var object: T
    internal(set) var next: ListNode<T>? = nil {
        willSet {
            next?.previous = self
        }
    }
    internal(set) var previous: ListNode<T>? = nil {
        willSet {
            previous?.next = self
        }
    }
    
    init(object anObject: T) {
        object = anObject
    }
    
    deinit {
        next = nil
        previous = nil
    }
}
