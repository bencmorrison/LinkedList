//
//  BCMDoublyLinkedListEquatableExtension.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 2/05/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension LinkedList: Equatable where T: Equatable {
    public static func ==(lhs: LinkedList<T>, rhs: LinkedList<T>) -> Bool {
        guard lhs.count == rhs.count else { return false }
        // Bypass having no nodes in the list we can force unwrap now
        guard lhs.count > 0 else { return true }
        
        // There should be no nils beyond this point
        guard var lNode = lhs.head else { return false }
        guard var rNode = rhs.head else { return false }
        
        repeat {
            guard lNode.isSimilarTo(rNode) else { return false }
            guard let lNext = lNode.next, let rNext = rNode.next else { return false }
            lNode = lNext
            rNode = rNext
            
        } while (!lNode.isNode(lhs.head) && !rNode.isNode(rhs.head))
        
        guard lNode.isNode(lhs.head) && rNode.isNode(rhs.head) else { return false }
        
        return true
    }
}
