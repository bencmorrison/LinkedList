//
//  ListNode+Operators.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 14/1/17.
//  Copyright © 2017 Benjamin C Morrison. All rights reserved.
//

import Foundation

prefix operator ++
postfix operator ++
prefix operator --
postfix operator --
infix operator +
infix operator -

extension ListNode {
    @discardableResult static prefix func ++(node: inout ListNode<T>) -> ListNode<T>? {
        if let next = node.next {
            node = next
            
            return node
        }
        
        return nil
    }
    
    @discardableResult static postfix func ++(node: inout ListNode<T>) -> ListNode<T>? {
        return ++node
    }
    
    @discardableResult static prefix func --(node: inout ListNode<T>) -> ListNode<T>? {
        if let previous = node.previous {
            node = previous
            return node
        }
        
        return nil
    }
    
    @discardableResult static postfix func --(node: inout ListNode<T>) -> ListNode<T>? {
        return --node
    }
    
    static func +(lhs: ListNode<T>, rhs: UInt) -> ListNode<T>? {
        var walkCount: UInt = 0
        var returnNode = lhs
        
        while (walkCount < rhs) {
            ++returnNode
            walkCount = walkCount + 1
        }
        
        return returnNode
    }
    
    static func +(lhs: UInt, rhs:ListNode<T>) -> ListNode<T>? {
        return rhs + lhs
    }
    
    static func -(lhs: ListNode<T>, rhs: UInt) -> ListNode<T>? {
        var walkCount = rhs
        var returnNode = lhs
        
        while (walkCount > 0) {
            --returnNode
            walkCount = walkCount - 1
        }
        
        return returnNode
    }
    
    static func -(lhs: UInt, rhs:ListNode<T>) -> ListNode<T>? {
        return rhs - lhs
    }
}

public func +=<T>(lhs: ListNode<T>, rhs: UInt) -> ListNode<T>? {
    return lhs + rhs
}

public func +=<T>(lhs: UInt, rhs: ListNode<T>) -> ListNode<T>? {
    return lhs + rhs
}

public func -=<T>(lhs: ListNode<T>, rhs: UInt) -> ListNode<T>? {
    return lhs - rhs
}

public func -=<T>(lhs: UInt, rhs: ListNode<T>) -> ListNode<T>? {
    return lhs - rhs
}

