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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitFromAnArray() throws {
        let vts = [1, 2, 3, 4, 5, 6]
        let sut = LinkedList(from: vts)
        
        try XCTAssertList(sut, matches: vts)
    }
    
    func testyTest() throws {
        LinkedList<Int>().dropFirst()
        
    }
}
