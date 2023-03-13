//
//  LinkedList+Extras.swift
//  
//
//  Created by Benjamin Morrison on 12/3/2023.
//

import Foundation

extension LinkedList {
    // MARK: - Inserting
    
    private func insert(item: Element, beforeNode: ListNode) {
        let nodeToInsert = ListNode(item: item)
        insert(node: nodeToInsert, beforeNode: beforeNode)
    }
    
    public func addObjectsFrom(collection: any Collection<T>) {
        collection.forEach {
            pushBack(item: $0)
        }
    }
    
    public func pushFront(item: Element) {
        let nodeToInsert: Node = ListNode(item: item)
        pushFront(node: nodeToInsert)
    }
    
    public func pushBack(item: Element) {
        let nodeToInsert: Node = ListNode(item: item)
        pushBack(node: nodeToInsert)
    }
    
    public func add(item: T) {
        pushBack(item: item)
    }
    
    public func add(node: Node<T>) {
        pushBack(node: node)
    }
    
    public func insert(item: Element, atIndex: Index) {
        let nodeToInsert = ListNode(item: item)
        insert(node: nodeToInsert, atIndex: atIndex)
    }
    
    // MARK: - Removing
    
    @discardableResult
    public func dropFirstItem() -> Element? {
        dropFirst()?.item
    }
    
    @discardableResult
    public func dropLastItem() -> Element? {
        dropLast()?.item
    }
    
    // MARK: - Querying
    
    public func itemAt(index: Index) -> T {
        let node = nodeAt(index: index)
        return node.item
    }
}
