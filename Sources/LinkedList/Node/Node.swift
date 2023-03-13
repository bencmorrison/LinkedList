//
//  ListNode.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

open class Node<T> {
    var item: T
    var next: Node<T>?
    weak var previous: Node<T>?
    
    init(item: T, next: Node<T>? = nil, previous: Node<T>? = nil) {
        self.item = item
        self.next = next
        self.previous = previous
    }
}
