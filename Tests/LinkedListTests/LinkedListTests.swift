//
//  BCMDoublyLinkedListTests.swift
//  BCMDoublyLinkedListTests
//
//  Created by Ben Morrison on 22/04/2016.
//  Copyright © 2016 Benjamin C Morrison. All rights reserved.
//

import XCTest
@testable import LinkedList

class LinkedListTests: XCTestCase {
    
    var vts: [Int]!
    var sut: LinkedList<Int>!
    
    override func setUpWithError() throws {
        super.setUp()
        vts = [1, 2, 3, 4, 5, 6]
        sut = LinkedList(from: vts)
        try XCTAssertList(sut, matches: vts)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut.removeAll()
    }
    
    func testForEachNode() throws {
        var index = 0
        sut.forEachNode {
            XCTAssertEqual(vts[index], $0.element)
            index += 1
        }
    }
}
