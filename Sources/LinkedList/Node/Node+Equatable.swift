//
//  Node+Equitable.swift
//  
//
//  Created by Benjamin Morrison on 13/3/2023.
//

import Foundation

extension Node: Equatable where T: Equatable {
    /**
     If the elemenet conforms to `Equatable` this will compare the
     elements of the lhs and rhs node.
     - Parameters:
        - lhs: The left hand side of the operator
        - rhs: The right hand side of the operator
     - Returns: True of the elements are equal between the nodes.
     */
    public static func ==(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.element == rhs.element
    }
}
