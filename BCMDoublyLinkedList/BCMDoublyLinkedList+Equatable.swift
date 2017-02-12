//
//  BCMDoublyLinkedListEquatableExtension.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 2/05/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension BCMDoublyLinkedList: Equatable {
    
}

public func ==<T>(lhs: BCMDoublyLinkedList<T>, rhs: BCMDoublyLinkedList<T>) -> Bool {
    if Unmanaged.passUnretained(lhs).toOpaque() != Unmanaged.passUnretained(rhs).toOpaque() {
        return false
    }
    
    if lhs.count != rhs.count {
        return false
    }
    
    var lNode = lhs.head
    var rNode = rhs.head
    
    repeat {
        if lNode != rNode {
            return false
        }
        
        lNode = lNode?.next
        rNode = rNode?.next
    
    } while (lNode != lhs.head && rNode != rhs.head)
    
    return true
}

public func !=<T>(lhs: BCMDoublyLinkedList<T>, rhs: BCMDoublyLinkedList<T>) -> Bool {
    return !(lhs == rhs)
}
