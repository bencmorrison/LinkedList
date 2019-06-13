//
//  ListNode.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public final class ListNode<T>: CustomStringConvertible {
    public var object: T
    var next: ListNode<T>? = nil
    var previous: ListNode<T>? = nil
    
    init(object anObject: T) {
        object = anObject
    }
    
    deinit {
        next = nil
        previous = nil
    }
    
    public var description: String {
        return "\(previous?.object) <-- \(object) --> \(next?.object)"
    }
}
