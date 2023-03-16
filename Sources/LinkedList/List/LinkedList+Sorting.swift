//
//  BCMDoublyLinkedList+Sorting.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 15/1/17.
//  Copyright © 2017 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension LinkedList {
    /**
     Returns a new linked list that contains only the elements in the range defined.
     - Parameter range: The range to use for the sublist elements
     - Returns: A new sublist of the elements in the subrange
     */
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
    
    /**
     Used by the `sort(by:)` function to determine sort order of the list.
     - Parameters:
        - lhs: The element to be used on the left side of the comparison operation
        - rhs: The element to be used on the right side of the comparison operation
     - Returns: True means correct order, flase means wrong order.
     */
    public typealias SortByClosure = (_ lhs: Element, _ rhs: Element) throws -> Bool
    
    /**
     Sorts the list by the the given predicate. This uses a merge sort.
     - Parameter comparison: (`SortByClosure`) The closure that determines the
        sort order of the list. Returning true means the order is correct of
        two elements. Returning false means the order of the elements is incorrect.
     - Returns: A sorted `LinkedList`
     */
    public func sorted(by comparison: SortByClosure) rethrows -> LinkedList<Element> {
        return try _sort(list: self, by: comparison)
    }
    
    private func _sort(list: LinkedList<Element>, by comparison: SortByClosure) rethrows -> LinkedList<Element> {
        guard list.count > 1 else { return list }
        
        let middle = list.count / 2
        
        let frontHalf = try! list.subList(fromRange: 0...middle - 1)
        let backHalf = try! list.subList(fromRange: middle...list.count - 1)
        let left = try _sort(list: frontHalf, by: comparison)
        let right = try _sort(list: backHalf, by: comparison)
        
        return try merge(left: left, right: right, comparison: comparison)
    }
    
    private func merge(left: LinkedList<Element>, right: LinkedList<Element>, comparison: SortByClosure) rethrows -> LinkedList<Element> {
        let merged: LinkedList<Element> = LinkedList<Element>()
    
        var leftNode = left.head
        var rightNode = right.head
        
        var i: UInt = 0
        var j: UInt = 0
        
        func comparisonWrapper(_ lhs: Element?, _ rhs: Element?) throws -> Bool {
            if lhs != nil && rhs == nil { return true }
            if lhs == nil && rhs != nil { return false }
            
            guard let lhs, let rhs else { return false }
            return try comparison(lhs, rhs)
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
            else if let left = leftNode, try comparisonWrapper(leftNode?.element, rightNode?.element) {
                merged.pushBack(left.element)
                leftNode = left.next
                i = i + 1
            }
            else if let right = rightNode, try !comparisonWrapper(leftNode?.element, rightNode?.element) {
                merged.pushBack(right.element)
                rightNode = right.next
                j = j + 1
            }
        }
        
        return merged
    }
}
