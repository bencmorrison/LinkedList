//
//  Node+Equitable.swift
//  
//
//  Created by Benjamin Morrison on 13/3/2023.
//

import Foundation

extension Node: Equatable where T: Equatable {
    public static func ==(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.previous?.item == rhs.previous?.item &&
        lhs.item == rhs.item &&
        lhs.next?.item == rhs.next?.item
    }
}
