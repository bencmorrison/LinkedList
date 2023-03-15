//
//  BCMDoublyLinkedList.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

open class LinkedList<T>: Collection {
    public typealias Element = T
    public typealias ListNode = Node<Element>
    public typealias Index = Int
    public typealias Iterator = LinkedListIterator<Element>
    
    public var startIndex: Index { 0 }
    public var endIndex: Index { count }
    
    private(set) public var count: Index = 0
    private(set) var head: ListNode? = nil
    private(set) weak var tail: ListNode? = nil
    
    public convenience init(from collection: any Collection<Element>) {
        self.init()
        addObjectsFrom(collection: collection)
    }

    deinit {
        removeAll()
    }
    
    // MARK: - Inserting
    
    public func pushFront(node: ListNode) {
        insert(node: node, beforeNode: head)
    }
    
    public func pushBack(node: ListNode) {
        insert(node: node, afterNode: tail)
    }
    
    public func insert(node: ListNode, atIndex index: Index) {
        assertValidIndex(index, for: .insert)
        
        if index == count {
            insert(node: node, afterNode: tail)
        } else {
            let beforeNode = nodeAt(index)
            insert(node: node, beforeNode: beforeNode)
        }
    }
    
    internal func insert(node newNode: ListNode, beforeNode: ListNode?) {
        if let beforeNode {
            newNode.previous = beforeNode.previous
            newNode.next = beforeNode
            beforeNode.previous?.next = newNode
            beforeNode.previous = newNode
            if beforeNode.isNode(head) { head = newNode }
            
        } else {
            guard head == nil else { return }
            head = newNode
            if tail == nil { tail = newNode }
        }
        
        count += 1
    }
    
    internal func insert(node newNode: ListNode, afterNode: ListNode?) {
        if let afterNode {
            newNode.next = afterNode.next
            newNode.previous = afterNode
            afterNode.next?.previous = newNode
            afterNode.next = newNode
            if afterNode.isNode(tail) { tail = newNode }
            
        } else {
            guard tail == nil else { return }
            tail = newNode
            if head == nil { head = newNode }
        }
        
        count += 1
    }
    
    // MARK: - Removing
    
    @discardableResult
    public func remove(at index: Index) -> ListNode {
        assertListIsNotEmpty()
        assertValidIndex(index, for: .remove)
        
        var node = nodeAt(index)
        remove(node: &node)
        
        return node
    }
    
    @discardableResult
    public func dropFirst() -> ListNode? {
        assertListIsNotEmpty()
        var head = head!
        remove(node: &head)
        return head
    }
    
    @discardableResult
    public func dropLast() -> ListNode? {
        assertListIsNotEmpty()
        var tail = tail!
        remove(node: &tail)
        return tail
    }
    
    private func remove(node toRemove: inout ListNode) {
        let before = toRemove.previous
        let after = toRemove.next
        
        before?.next = after
        after?.previous = before
        
        if toRemove.isNode(head) { head = head?.next }
        if toRemove.isNode(tail) { tail = tail?.previous }
        
        toRemove.next = nil
        toRemove.previous = nil
        count -= 1
    }
    
    public func removeAll() {
        var node = head
        while node != nil {
            let nextNode = node?.next
            node?.next = nil
            node?.previous = nil
            node = nextNode
        }
        
        head = nil
        tail = nil
        count = 0
    }
    
    // MARK: - Querying
        
    public func nodeAt(_ index: Index) -> ListNode {
        assertValidIndex(index)
        
        if index == 0 { return head! }
        if index == (count - 1) { return tail! }
        
        var node = head!
        for _ in 0..<index {
            node = node.next!
        }
        
        return node
    }
    
    open func contains(_ searchNode: ListNode) -> Bool {
        let searchPointer = Unmanaged.passUnretained(searchNode).toOpaque()
        var node = head
        while node != nil {
            let nodePointer = Unmanaged.passUnretained(node!).toOpaque()
            if searchPointer == nodePointer { return true }
            node = node?.next
        }
        
        return false
    }
    
    // MARK: Iteration
    public typealias ForEachNodeClosure = (_ node: ListNode) -> ()
    public func forEachNode(_ closure: ForEachNodeClosure) {
        var node = head
        while node != nil {
            closure(node!)
            node = node?.next
        }
    }
    
    // MARK: - Collection
    public func makeIterator() -> Iterator {
        return LinkedListIterator<T>(list: self)
    }
    
    public subscript(position: Index) -> Element {
        get { return itemAt(index: position) }
        set { insert(item: newValue, atIndex: position) }
    }
    
    public func index(after i: Index) -> Index {
        let nextIndex = i + 1
        return nextIndex
    }
}
