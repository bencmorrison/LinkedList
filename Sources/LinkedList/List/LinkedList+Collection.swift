//
//  File.swift
//  
//
//  Created by Benjamin Morrison on 12/3/2023.
//

import Foundation

extension LinkedList: Collection {
    public typealias Element = T
    public typealias Index = UInt
    public typealias Iterator = LinkedListIterator<Element>
    
    public var startIndex: Index { 0 }
    public var endIndex: Index { count }
    
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
    
    public func subList(fromRange range: ClosedRange<Index>) throws -> LinkedList<Element> {
        let subList = LinkedList<Element>()
        
        var index = range.lowerBound
        var node = nodeAt(index)
        while(index <= range.upperBound && index < count) {
            subList.pushBack(item: node.item)
            index++
            if index < count { node = node.next! }
        }
        
        return subList
    }
}
