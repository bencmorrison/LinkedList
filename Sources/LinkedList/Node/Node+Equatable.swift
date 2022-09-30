//
//  ListNodeEquityExension.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 2/05/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension Node: Equatable {
    func isEqual(_ anObject: AnyObject?) -> Bool {
        guard let anObject = anObject as? Node else {
            return false
        }
        
        return self == anObject
    }
    
    public static func ==<T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return Unmanaged.passUnretained(lhs).toOpaque() == Unmanaged.passUnretained(rhs).toOpaque()
    }
    
    public static func !=<T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return Unmanaged.passUnretained(lhs).toOpaque() != Unmanaged.passUnretained(rhs).toOpaque()
    }
    
    public static func ==<T: Equatable>(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.object == rhs.object
    }
    
    public static func !=<T: Equatable>(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.object != rhs.object
    }
}
