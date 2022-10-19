//
//  BCMDoublyLinkedList.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

public final class LinkedList<T>: CustomStringConvertible {
    private(set) var count: UInt = 0
    private(set) var head: Node<T>? = nil
    private(set) var tail: Node<T>? = nil
    
    // MARK: Initialisers
    
    public convenience init(fromList: LinkedList<T>){
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
        let nodeToInsert: Node = Node(object: object)
        pushFront(node: nodeToInsert)
    }
    
    public func pushFront(node nodeToInsert: Node<T>) {
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
        let nodeToInsert: Node = Node(object: object)
        pushBack(node: nodeToInsert)
    }
    
    public func pushBack(node nodeToInsert: Node<T>) {
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
    
    public func addObjectsFrom(list: LinkedList<T>) {
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
    
    public func add(node: Node<T>) {
        pushBack(node: node)
    }
    
    public func insert(object: T, atIndex: UInt) {
        let nodeToInsert = Node(object: object)
        insert(node: nodeToInsert, atIndex: atIndex)
    }
    
    public func insert(node: Node<T>, atIndex index: UInt) {
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
    
    fileprivate func insert(object: T, beforeNode: Node<T>) {
        let nodeToInsert = Node(object: object)
        insert(node: nodeToInsert,
               beforeNode: beforeNode)
    }
    
    fileprivate func insert(node: Node<T>, beforeNode: Node<T>) {
        beforeNode.previous?.next = node
        node.previous = beforeNode.previous
        node.next = beforeNode
        beforeNode.previous = node
        count = count + 1
    }
    
    // MARK: - Removing
    
    public func emptyList() {
        var currentNode: Node? = head
        var nextNode: Node? = head?.next
        
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
    
    public func objectAt(index: UInt) -> T {
        let node = nodeAt(index: index)
        return node.object
    }
    
    public func nodeAt(index: UInt) -> Node<T> {
        assert(indexIsValid(index))
        
        var node = head!
        var i: UInt = 0
        while i < index {
            node = node.next!
            i = i + 1
        }
        
        return node
    }
    
    public func subList(fromRange range: ClosedRange<UInt>) throws -> LinkedList<T> {
        let subList = LinkedList<T>()
        
        var index = range.lowerBound
        var node = nodeAt(index: index)
        while(index <= range.upperBound && index < count) {
            subList.pushBack(object: node.object)
            node = node.next!
            index = index + 1
        }
        
        return subList
    }
    
    // MARK: Validation
    
    enum Operation {
        case query
        case insert
        case remove
    }
    
    func indexIsValid(_ index: UInt, operation: Operation = .query) -> Bool {
        switch operation {
        case .query: return index < count
        case .insert: return index < count + 1
        case .remove: return index < count
        }
    }
}
