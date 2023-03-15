//
//  LinkedList+Extras.swift
//  
//
//  Created by Benjamin Morrison on 12/3/2023.
//

import Foundation

// MARK: - Element Extension
extension LinkedList {
    // MARK: Inserting
    
    /**
     Inserts the element at the front (head) of the list.
     - Parameter element: The element to push to the front
     */
    public func pushFront(_ element: Element) {
        let nodeToInsert: Node = ListNode(element)
        pushFront(nodeToInsert)
    }
    
    /**
     Inserts the element at the end (tail) of the list.
     - Parameter element: The element to push to the end
     */
    public func pushBack(_ element: Element) {
        let nodeToInsert: Node = ListNode(element)
        pushBack(nodeToInsert)
    }
    
    /**
     Identical to `pushBack(_)`
     - Parameter elemenet: The element to pushBack
     */
    @inlinable
    public func append(_ element: Element) {
        pushBack(element)
    }
    
    /**
     Allows adding objects
     */
    public func append(collection: any Collection<T>) {
        collection.forEach { pushBack($0) }
    }
    
    /**
     Inserts a new element in the list at the specified index.
     This means that if you choose index 0, this will insert at the head.
     - Warning: If the index is out of bounds an `assertFailure` will occure
     - Parameters:
        - element: The element to be inserted
        - index: The index of the insertion
    */
    public func insert(_ element: Element, atIndex: Index) {
        let nodeToInsert = ListNode(element)
        insert(nodeToInsert, atIndex: atIndex)
    }
    
    // MARK: Removing
    
    /**
     Removes the element at the specific index.
     - Warning: If the list is **empty** or the index is out of bounds
                when called an `assertFailure` will occure
     - Parameter index: The index of the element to be removed
     - Returns: The removed node
     */
    @inlinable
    @discardableResult
    public func remove(at index: Index) -> Element {
        removeNode(at: index).element
    }
    
    /**
     Removes the first (head) element in the list.
     - Warning: If the list is **empty** when called an
                `assertFailure` will occure
     - Returns: The removed element
     */
    @inlinable
    @discardableResult
    public func removeFirst() -> Element {
        removeFirstNode().element
    }
    
    
    /**
     Removes the last (tail) element in the list.
     - Warning: If the list is **empty** when called an `assertFailure` will occure
     - Returns: The removed element
     */
    @inlinable
    @discardableResult
    public func removeLast() -> Element {
        removeLastNode().element
    }
    
    /**
     The closure definition for `remove(where:)` function
     - Parameter element: The element to check
     - Returns: True if the element meets the requirments.
     */
    public typealias RemoveWhereClosure = (_ element: T) throws -> Bool
    
    /**
     Removes all elements in the list that satisfy the given predicate
     - Parameter shouldBeRemoved: The closure that takes an element as a parameter
        and returns a Bool value indicating if the element should be removed from
        the list
     */
    public func remove(where shouldBeRemoved: RemoveWhereClosure) rethrows {
        var nodesToRemove: [ListNode] = []
        try forEachNode {
            if try shouldBeRemoved($0.element) {
                nodesToRemove.append($0)
            }
        }
        
        nodesToRemove.forEach { node in
            var node = node
            removeNode(&node)
        }
    }
    
    // MARK: Querying
    
    /**
     Gets the element at the specified index from the list.
     - Warning: If the list is **empty** or the index is out of bounds
                when called an `assertFailure` will occure
     - Parameter index: The index of the element to return
     - Returns: The element at the specified index
     */
    @inlinable
    public func itemAt(index: Index) -> Element {
        nodeAt(index).element
    }
}


// MARK: - Equitable
extension LinkedList where Element: Equatable {
    // MARK: Querying
    
    /**
     Allows searching the list for a specific element in the list.
     This only is available when the `Element` conforms to `Equatable`
     - Parameter element: The element to check if it is in the list
     - Returns: True when the list contains the element, else it returns false.
     */
    public func contains(_ element: Element) -> Bool {
        for storedItem in self {
            if storedItem == element { return true }
        }
        return false
    }
}
