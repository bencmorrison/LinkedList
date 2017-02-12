//
//  ListNodeEquityExension.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 2/05/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension ListNode: Equatable {
    func isEqual(anObject: AnyObject) -> Bool {
        guard let anObject = anObject as? ListNode else {
            return false
        }
        
        return self == anObject
    }
}

public func ==<T>(lhs: ListNode<T>, rhs: ListNode<T>) -> Bool {
    return Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
}

public func !=<T>(lhs: ListNode<T>, rhs: ListNode<T>) -> Bool {
    return Unmanaged.passUnretained(lhs).toOpaque() != Unmanaged.passUnretained(rhs).toOpaque()
}
