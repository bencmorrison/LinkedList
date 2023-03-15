//
//  BCMDoublyLinkedList+Sorting.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 15/1/17.
//  Copyright © 2017 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension LinkedList {
    public typealias SortBlock = (_ left: Element, _ right: Element) -> Bool
    
    public func subList(fromRange range: ClosedRange<Index>) throws -> LinkedList<Element> {
        let subList = LinkedList<Element>()
        
        var index = range.lowerBound
        var node = nodeAt(index)
        while(index <= range.upperBound && index < count) {
            subList.pushBack(node.element)
            index += 1
            if index < count { node = node.next! }
        }
        
        return subList
    }
    
    public func sorted(by comparison: SortBlock) throws -> LinkedList<Element> {
        return _sort(list: self, by: comparison)
    }
    
    private func _sort(list: LinkedList<Element>, by comparison: SortBlock) -> LinkedList<Element> {
        guard list.count > 1 else { return list }
        
        let middle = list.count / 2
        
        let frontHalf = try! list.subList(fromRange: 0...middle - 1)
        let backHalf = try! list.subList(fromRange: middle...list.count - 1)
        let left = _sort(list: frontHalf, by: comparison)
        let right = _sort(list: backHalf, by: comparison)
        
        return merge(left: left, right: right, comparison: comparison)
    }
    
    private func merge(left: LinkedList<Element>, right: LinkedList<Element>, comparison: SortBlock) -> LinkedList<Element> {
        let merged: LinkedList<Element> = LinkedList<Element>()
    
        var leftNode = left.head
        var rightNode = right.head
        
        var i: UInt = 0
        var j: UInt = 0
        
        func comparisonWrapper(_ lhs: Element?, _ rhs: Element?) -> Bool {
            if lhs != nil && rhs == nil { return true }
            if lhs == nil && rhs != nil { return false }
            
            guard let lhs, let rhs else { return false }
            return comparison(lhs, rhs)
        }
        
        while (i + j) < (left.count + right.count) {
            if let right = rightNode, i == left.count {
                merged.pushBack(right.element)
                rightNode = right.next
                j = j + 1
            }
            else if let left = leftNode, j == right.count {
                merged.pushBack(left.element)
                leftNode = left.next
                i = i + 1
            }
            else if let left = leftNode, comparisonWrapper(leftNode?.element, rightNode?.element) {
                merged.pushBack(left.element)
                leftNode = left.next
                i = i + 1
            }
            else if let right = rightNode, !comparisonWrapper(leftNode?.element, rightNode?.element) {
                merged.pushBack(right.element)
                rightNode = right.next
                j = j + 1
            }
        }
        
        return merged
    }
}
