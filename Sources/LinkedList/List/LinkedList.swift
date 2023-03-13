//
//  BCMDoublyLinkedList.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

open class LinkedList<T> {
    public typealias ListNode = Node<Element>
    
    private(set) var count: Index = 0
    private(set) var head: ListNode? = nil
    private(set) weak var tail: ListNode? = nil

    deinit {
        emptyList()
    }
    
    // MARK: - Inserting
    
    public func pushFront(node nodeToInsert: ListNode) {
        nodeToInsert.next = head
        nodeToInsert.previous = nil
        head?.previous = nodeToInsert
        head = nodeToInsert
        
        if count == 0 {
            tail = nodeToInsert
        }
        
        count++
    }
    
    public func pushBack(node nodeToInsert: ListNode) {
        guard count > 0 else {
            pushFront(node: nodeToInsert)
            return
        }
        
        nodeToInsert.previous = tail
        nodeToInsert.next = nil
        tail?.next = nodeToInsert
        tail = nodeToInsert
        count++
    }
    
    public func insert(node: ListNode, atIndex index: Index) {
        assert(indexIsValid(index, operation: .insert))
        
        if index == 0 {
            pushFront(node: node)
        }
        else if index == count {
            pushBack(node: node)
        }
        else {
            let beforeNode = nodeAt(index: index)
            insert(node: node, beforeNode: beforeNode)
        }
    }
    
    internal func insert(node newNode: ListNode, beforeNode pushedDown: ListNode) {
        let beforeNode = pushedDown.previous
        
        beforeNode?.next = newNode
        newNode.previous = beforeNode
        newNode.next = pushedDown
        pushedDown.previous = newNode
        
        count++
    }
    
    // MARK: - Removing
    
    @discardableResult
    public func remove(at index: Index) -> ListNode {
        var node: ListNode? = nodeAt(index: index)
        remove(node: &node)
        
        return node!
    }
    
    @discardableResult
    public func dropFirst() -> ListNode? {
        var toRemove = head
        head = toRemove?.next
        remove(node: &toRemove)
        
        return toRemove
    }
    
    @discardableResult
    public func dropLast() -> ListNode? {
        var toRemove = tail
        tail = toRemove?.previous
        remove(node: &toRemove)
        
        return toRemove
    }
    
    private func remove(node toRemove: inout ListNode?) {
        let before = toRemove?.previous
        let after = toRemove?.next
        
        before?.next = after
        after?.previous = before
        
        toRemove?.next = nil
        toRemove?.previous = nil
    }
    
    public func emptyList() {
        var currentNode: ListNode? = head
        var nextNode: ListNode? = head?.next
        
        repeat {
            currentNode?.next = nil
            currentNode?.previous = nil
            
            currentNode = nextNode
            nextNode = currentNode?.next
        } while (currentNode != nil)
        
        head = nil
        tail = nil
        count = 0
    }
    
    // MARK: - Querying
        
    public func nodeAt(index: Index) -> ListNode {
        assert(indexIsValid(index))
        
        if index == 0 { return head! }
        if index == (count - 1) { return tail! }
        
        var node = head!
        for _ in 0..<index {
            node = node.next!
        }
        
        return node
    }
    
    // MARK: Validation
    
    internal enum Operation {
        case query
        case insert
        case remove
    }
    
    internal func indexIsValid(_ index: Index, operation: Operation = .query) -> Bool {
        switch operation {
        case .query: return index < count
        case .insert: return index < count + 1
        case .remove: return index < count
        }
    }
}
