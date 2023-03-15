//
//  LinkedList.swift
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2023 Benjamin C Morrison. All rights reserved.
//

import Foundation

/**
 `LinkedList` is a double linked list that conforms to the `Collection` protocol.
 The goal of this class is to be an easy to use Swift linked list.
 
 The list supports operations that allow access to the `Node` or the `Element` itself.
 Most operations are expected to want the stored `Element` over the `Node` so functions
 that are similar or identical to other Collections will return the `Element` over the `Node`.
 
 If you'd like the `Node` there are some equiviant functions with the word node in them.
 Ex: `removeFirst()` vs `removeFirstNode()`
 */
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
    
    /**
     Allows the list to be inialised by `any Collection` by copying the items into the collection.
     - Parameter collection: The collection to use to init the list
     */
    public convenience init(from collection: any Collection<Element>) {
        self.init()
        append(collection: collection)
    }

    deinit {
        removeAll()
    }
    
    // MARK: - Inserting
    
    /**
     Places the node at the head of the list.
     - Parameter node: The node to be inserted at the head of the list.
     */
    public func pushFront(_ node: ListNode) {
        insert(node, beforeNode: head)
    }
    
    /**
     Places the node at the tail of the list.
     - Parameter node: The node to be inserted at the tail of the list.
     */
    public func pushBack(_ node: ListNode) {
        insert(node, afterNode: tail)
    }
    
    /**
     Identical to `pushBack(_)`.
     - Parameter node: The node to be inserted at the tail of the list.
     */
    @inlinable
    public func append(_ node: ListNode) {
        pushBack(node)
    }
    
    /**
     Inserts a new node in the list at the specified index.
     This means that if you choose index 0, this will insert at the head.
     - Warning: If the index is out of bounds an `assertFailure` will occure
     - Parameters:
        - node: The node to be inserted
        - index: The index of the insertion
    */
    public func insert(_ node: ListNode, atIndex index: Index) {
        assertValidIndex(index, for: .insert)
        
        if index == count {
            insert(node, afterNode: tail)
        } else {
            let beforeNode = nodeAt(index)
            insert(node, beforeNode: beforeNode)
        }
    }
    
    /**
     Inserts a node before another node that is currently in the list.
     - Warning: When the `beforeNode` is `nil` this function **assumes**  that
                we are inserting inserting into an empty list as this is the
                only time that we should have a `nil` `beforeNode`.
     - Parameters:
        - newNode: The node to be inserted
        - beforeNode: The node we are inserting before
    */
    internal func insert(_ newNode: ListNode, beforeNode: ListNode?) {
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
    
    /**
     Inserts a node after another node that is currently in the list.
     - Warning: When the `afterNode` is `nil` this function **assumes**  that
                we are inserting inserting into an empty list as this is the
                only time that we should have a `nil` `afterNode`.
     - Parameters:
        - newNode: The node to be inserted
        - afterNode: The node we are inserting after
    */
    internal func insert(_ newNode: ListNode, afterNode: ListNode?) {
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
    
    // MARK: Removing
    
    /**
     Removes the node at the specific index.
     - Warning: If the list is **empty** or the index is out of bounds
                when called an `assertFailure` will occure
     - Parameter index: The index of the node to be removed
     - Returns: The removed node
     */
    @discardableResult
    public func removeNode(at index: Index) -> ListNode {
        assertListIsNotEmpty()
        assertValidIndex(index, for: .remove)
        var node = nodeAt(index)
        removeNode(&node)
        return node
    }
    
    /**
     Removes the first (head) node in the list.
     - Warning: If the list is **empty** when called an `assertFailure` will occure
     - Returns: The removed node
     */
    @discardableResult
    public func removeFirstNode() -> ListNode {
        assertListIsNotEmpty()
        var head = head!
        removeNode(&head)
        return head
    }
    
    /**
     Removes the last (tail) node in the list.
     - Warning: If the list is **empty** when called an `assertFailure` will occure
     - Returns: The removed node
     */
    @discardableResult
    public func removeLastNode() -> ListNode {
        assertListIsNotEmpty()
        var tail = tail!
        removeNode(&tail)
        return tail
    }
    
    /**
     Removes the node from the list and set's the removed node's `next` and `previous`
     - Warning: This will modify the `next` and `previous` variables of the node.
     - Parameter toRemove: The node to remove from the list.
     */
    internal func removeNode(_ toRemove: inout ListNode) {
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
    
    /**
     Removes all items from the list.
     */
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
    
    /**
     Gets the node at the specified index from the list.
     - Warning: If the list is **empty** or the index is out of bounds
                when called an `assertFailure` will occure
     - Parameter index: The index of the node to return
     - Returns: The node at the specified index
     */
    public func nodeAt(_ index: Index) -> ListNode {
        assertListIsNotEmpty()
        assertValidIndex(index)
        
        if index == (count - 1) { return tail! }
        
        var node = head!
        for _ in 0..<index {
            node = node.next!
        }
        
        return node
    }
    
    /**
     Allows searching the list for a specific node in the list.
     - Parameter searchNode: The node to check if it is in the list
     - Returns: True when the list contains the node, else it returns false.
     */
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
    
    /**
     Defines the closure for the `forEachNode(_)` function
     - Parameter node: The node for the current iteration of the for each
     */
    public typealias ForEachNodeClosure = (_ node: ListNode) throws -> ()
    
    /**
     Allows iteration over the list with the same notation as the `forEach(_)` but
     passes in the node instead of the element to the closure.
     - Parameters closure: The closure to be used at each iteration of the for each
     */
    public func forEachNode(_ closure: ForEachNodeClosure) rethrows {
        var node = head
        while node != nil {
            try closure(node!)
            node = node?.next
        }
    }
    
    // MARK: - Collection
    public func makeIterator() -> Iterator {
        return LinkedListIterator<T>(list: self)
    }
    
    public subscript(position: Index) -> Element {
        get { return itemAt(index: position) }
        set { insert(newValue, atIndex: position) }
    }
    
    public func index(after i: Index) -> Index {
        let nextIndex = i + 1
        return nextIndex
    }
}
