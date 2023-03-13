//
//  BCMDoublyLinkedList+Error.swift
//  BCMDoublyLinkedList
//
//  Created by Ben Morrison on 14/1/17.
//  Copyright © 2017 Benjamin C Morrison. All rights reserved.
//

import Foundation

public enum LinkedListError: Error {
    case indexOutOfBounds(outIndex: UInt)
}
