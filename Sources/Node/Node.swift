//
//  ListNode.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public class Node<T>: CustomStringConvertible {
    public var object: T
    var next: Node<T>? = nil
    var previous: Node<T>? = nil
    
    init(object anObject: T) {
        object = anObject
    }
    
    deinit {
        next = nil
    }
    
    public var description: String {
        return "\(String(describing: previous?.object)) <-- \(object) --> \(String(describing: next?.object))"
    }
}
