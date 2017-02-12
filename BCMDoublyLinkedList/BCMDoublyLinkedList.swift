//
//  BCMDoublyLinkedList.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public final class BCMDoublyLinkedList<T> {
    fileprivate(set) var count: UInt = 0 {
        didSet {
            lastRequestedNode = head
            lastRequestedIndex = 0
        }
    }
    
    fileprivate(set) var head: ListNode<T>? {
        willSet {
            newValue?.next = head
        }
    }
    
    fileprivate(set) var tail: ListNode<T>? {
        get {
            return head?.previous
        }
        set {
            head?.previous = newValue
        }
    }
    
    private var lastRequestedIndex: UInt = 0
    private weak var lastRequestedNode: ListNode<T>?
    
    public convenience init(fromList: BCMDoublyLinkedList<T>){
        self.init()
        addObjectsFrom(list: fromList)
    }
    
    public convenience init(fromArray: [T]) {        
        self.init()
        addObjectsFrom(array: fromArray)
    }
    
    deinit {
        emptyList()
    }
    
    // MARK: - Inserting
    public func pushFront(object: T) {
        let nodeToInsert: ListNode = ListNode(object: object)
        pushFront(node: nodeToInsert)
    }
    
    public func pushFront(node nodeToInsert: ListNode<T>) {
        head = nodeToInsert
        count = count + 1
        
        if tail == nil {
            tail = head
        }
    }
    
    public func pushBack(object: T) {
        let nodeToInsert: ListNode = ListNode(object: object)
        pushBack(node: nodeToInsert)
    }
    
    public func pushBack(node nodeToInsert: ListNode<T>) {
        tail = nodeToInsert
        count = count + 1
        
        if head == nil {
            head = tail
        }
    }
    
    public func addObjectsFrom(list: BCMDoublyLinkedList<T>) {
        for item in list {
            pushBack(object: item)
        }
    }
    
    public func addObjectsFrom(array: [T]) {
        for item in array {
            pushBack(object: item)
        }
    }
    
    public func add(object: T) {
        pushBack(object: object)
    }
    
    public func add(node: ListNode<T>) {
        pushBack(node: node)
    }
    
    public func insert(object: T, atIndex: UInt) throws {
        let nodeToInsert = ListNode(object: object)
        try insert(node: nodeToInsert, atIndex: atIndex)
    }
    
    public func insert(node: ListNode<T>, atIndex: UInt) throws {
        if atIndex == 0 {
            pushFront(node: node)
        }
        else if atIndex == count {
            pushBack(node: node)
        }
        else {
            let beforeNode = try nodeAt(index: atIndex)
            insert(node: node, beforeNode: beforeNode)
        }
    }
    
    fileprivate func insert(object: T, beforeNode: ListNode<T>) {
        let nodeToInsert = ListNode(object: object)
        insert(node: nodeToInsert,
               beforeNode: beforeNode)
    }
    
    fileprivate func insert(node: ListNode<T>, beforeNode: ListNode<T>) {
        node.next = beforeNode
        count = count + 1
    }
    
    // MARK: - Removing
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
    subscript (index: UInt) -> T? {
        get {
            do {
                return try objectAt(index: index)
            }
            catch BCMDoublyLinkedListError.indexOutOfBounds(let askedIndex) {
                print("Index: \(askedIndex) is out of bounds. Current Count: \(count)")
                return nil
            }
            catch {
                return nil
            }
        }
        set {
            guard let newValue = newValue else {
                return
            }
            
            do {
                try insert(object: newValue, atIndex: index)
            }
            catch BCMDoublyLinkedListError.indexOutOfBounds(let askedIndex) {
                print("Index: \(askedIndex) is out of bounds. Current Count: \(count)")
            }
            catch {
                return
            }
        }
    }
    
    public func objectAt(index: UInt) throws -> T? {
        let node = try nodeAt(index: index)
        return node.object
    }
    
    public func nodeAt(index: UInt) throws -> ListNode<T> {
        if index >= count {
            throw BCMDoublyLinkedListError.indexOutOfBounds(outIndex: index)
        }
        
        if let head = head, index == 0 {
            return head
        }
        else if let tail = tail, index == (count - 1) {
            return tail
        }
        else if let lastRequestedNode = lastRequestedNode, index == lastRequestedIndex {
            return lastRequestedNode
            
        } else if let lastRequestedNode = lastRequestedNode?.previous, index == (lastRequestedIndex - 1) {
            self.lastRequestedNode = lastRequestedNode
            return lastRequestedNode
        }
        else if let lastRequestedNode = lastRequestedNode?.next, index == (lastRequestedIndex + 1) {
            self.lastRequestedNode = lastRequestedNode
            return lastRequestedNode
        }
        
        let add = index > lastRequestedIndex
        var nodeToReturn: ListNode<T>?
        if add {
            let traverse = index - lastRequestedIndex
            nodeToReturn = lastRequestedNode! + traverse
        }
        else {
            let traverse = lastRequestedIndex  - index
            nodeToReturn = lastRequestedNode! - traverse
        }
        
        lastRequestedIndex = index
        lastRequestedNode = nodeToReturn
        
        return nodeToReturn!
    }
    
    public func subList(fromRange range: CountableClosedRange<UInt>) -> BCMDoublyLinkedList<T> {
        
    }
}
