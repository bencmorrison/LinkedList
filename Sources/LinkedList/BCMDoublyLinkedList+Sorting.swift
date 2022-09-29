//
//  BCMDoublyLinkedList+Sorting.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 15/1/17.
//  Copyright © 2017 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension BCMDoublyLinkedList {
    public typealias SortBlock = (_ left: T, _ right: T) -> Bool
    
    public func sort(by comparison: SortBlock) throws -> BCMDoublyLinkedList<T> {
        return _sort(list: self, by: comparison)
    }
    
    private func _sort(list: BCMDoublyLinkedList<T>, by comparison: SortBlock) -> BCMDoublyLinkedList<T> {
        guard list.count > 1 else { return list }
        
        let middle: UInt = list.count / 2
        
        let frontHalf = try! list.subList(fromRange: 0...middle - 1)
        let backHalf = try! list.subList(fromRange: middle...list.count - 1)
        let left = _sort(list: frontHalf, by: comparison)
        let right = _sort(list: backHalf, by: comparison)
        
        return merge(left: left, right: right, comparison: comparison)
    }
    
    private func merge(left: BCMDoublyLinkedList<T>, right: BCMDoublyLinkedList<T>, comparison: SortBlock) -> BCMDoublyLinkedList<T> {
        let merged: BCMDoublyLinkedList<T> = BCMDoublyLinkedList<T>()
    
        var leftNode = left.head!
        var rightNode = right.head!
        
        var i: UInt = 0
        var j: UInt = 0
        
        while (i + j) < (left.count + right.count) {
            if i == left.count {
                merged.pushBack(object: rightNode.object)
                rightNode = rightNode.next!
                j = j + 1
            }
            else if j == right.count {
                merged.pushBack(object: leftNode.object)
                leftNode = leftNode.next!
                i = i + 1
            }
            else if comparison(leftNode.object, rightNode.object) {
                merged.pushBack(object: leftNode.object)
                leftNode = leftNode.next!
                i = i + 1
            }
            else if !comparison(leftNode.object, rightNode.object) {
                merged.pushBack(object: rightNode.object)
                rightNode = rightNode.next!
                j = j + 1
            }
        }
        
        return merged
    }
}
