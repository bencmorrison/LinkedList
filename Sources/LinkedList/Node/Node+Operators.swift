//
//  ListNode+Operators.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 14/1/17.
//  Copyright © 2017 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension Node {
    /// Walk the the next node
    @discardableResult
    static prefix func ++(node: inout Node<T>) -> Node<T>? {
        if let next = node.next {
            node = next
            return node
        }
        
        return nil
    }
    
    /// Walk the the next node
    @discardableResult
    static postfix func ++(node: inout Node<T>) -> Node<T>? {
        return ++node
    }
    
    /// Walk to the node x ahead
    static func +(lhs: Node<T>, rhs: UInt) -> Node<T>? {
        var walkCount: UInt = 0
        var returnNode = lhs
        
        while (walkCount < rhs) {
            ++returnNode
            walkCount = walkCount + 1
        }
        
        return returnNode
    }
    
    /// Walk the the x node
    static func +(lhs: UInt, rhs:Node<T>) -> Node<T>? {
        return rhs + lhs
    }

    /// Walk to the previous node
    @discardableResult
    static prefix func --(node: inout Node<T>) -> Node<T>? {
        if let previous = node.previous {
            node = previous
            return node
        }
        
        return nil
    }
    
    /// Walk to the previous node
    @discardableResult
    static postfix func --(node: inout Node<T>) -> Node<T>? {
        return --node
    }
    
    /// Walk back x nodes
    static func -(lhs: Node<T>, rhs: UInt) -> Node<T>? {
        var walkCount = rhs
        var returnNode = lhs
        
        while (walkCount > 0) {
            --returnNode
            walkCount = walkCount - 1
        }
        
        return returnNode
    }
    
    /// Walk back x nodes
    static func -(lhs: UInt, rhs:Node<T>) -> Node<T>? {
        return rhs - lhs
    }
}
