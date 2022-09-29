//
//  BCMDoublyLinkedList.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public final class BCMDoublyLinkedList<T>: CustomStringConvertible {
    private(set) var count: UInt = 0
    private(set) var head: ListNode<T>? = nil
    private(set) var tail: ListNode<T>? = nil
    
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
    
    public var description: String {
        var desc = "["
        for val in self {
            desc.append("\(val), ")
        }
        desc.append("]")
        
        return desc
    }
    
    // MARK: - Inserting
    public func pushFront(object: T) {
        let nodeToInsert: ListNode = ListNode(object: object)
        pushFront(node: nodeToInsert)
    }
    
    public func pushFront(node nodeToInsert: ListNode<T>) {
        if head == nil {
            head = nodeToInsert
        }
        
        if tail == nil {
            tail = head
        }
        
        nodeToInsert.next = head
        nodeToInsert.previous = head?.previous
        head?.previous = nodeToInsert
        head = nodeToInsert
        tail?.next = head
        
        count = count + 1
    }
    
    public func pushBack(object: T) {
        let nodeToInsert: ListNode = ListNode(object: object)
        pushBack(node: nodeToInsert)
    }
    
    public func pushBack(node nodeToInsert: ListNode<T>) {
        if tail == nil {
            tail = nodeToInsert
        }
        
        if head == nil {
            head = tail
        }
        
        
        nodeToInsert.previous = tail
        nodeToInsert.next = tail?.next
        tail?.next = nodeToInsert
        tail = nodeToInsert
        head?.previous = tail
    
        count = count + 1
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
        beforeNode.previous?.next = node
        node.previous = beforeNode.previous
        node.next = beforeNode
        beforeNode.previous = node
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
    subscript (index: UInt) -> T {
        get {
            return try! objectAt(index: index)
        }
        set {
            try! insert(object: newValue, atIndex: index)
        }
    }
    
    public func objectAt(index: UInt) throws -> T {
        let node = try nodeAt(index: index)
        return node.object
    }
    
    public func nodeAt(index: UInt) throws -> ListNode<T> {
        if index >= count {
            throw BCMDoublyLinkedListError.indexOutOfBounds(outIndex: index)
        }
        
        var node = head!
        var i: UInt = 0
        while i < index {
            node = node.next!
            i = i + 1
        }
        
        return node
    }
    
    
    public func subList(fromRange range: ClosedRange<UInt>) throws -> BCMDoublyLinkedList<T> {
        let subList = BCMDoublyLinkedList<T>()
        
        var index = range.lowerBound
        var node = try nodeAt(index: index)
        while(index <= range.upperBound && index < count) {
            subList.pushBack(object: node.object)
            node = node.next!
            index = index + 1
        }
        
        return subList
    }
}
