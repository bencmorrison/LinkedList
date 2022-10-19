//
//  ListNodeEquityExension.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 2/05/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import Foundation

extension Node where T: Equatable {
    /**
     This will check if it is similar by comparting the objects of the current
     nodes and the next and previous.
     */
    func isSimilarTo(_ otherNode: Node<T>?) -> Bool {
        guard let otherNode else { return false }
        return object == otherNode.object &&
            next?.object == otherNode.next?.object &&
            previous?.object == otherNode.previous?.object
    }
}
