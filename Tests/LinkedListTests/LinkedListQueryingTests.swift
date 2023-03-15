//
//  LinkedListQueryingTests.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import XCTest

@testable import LinkedList

final class LinkedListQueryingTests: XCTestCase {

    var sut: LinkedList<Int>!
    var vts: [Int]!
    
    override func setUpWithError() throws {
        vts = [1, 23, 235324, 2903, 55, 9292]
        sut = LinkedList(from: vts)
        try XCTAssertList(sut, matches: vts)
    }

    override func tearDownWithError() throws {
        sut.removeAll()
    }

    func testIndexAt() throws {
        for index in 0..<vts.count {
            let vtsItem = vts[index]
            let sutItem = sut.nodeAt(index).element
            
            XCTAssertEqual(sutItem, vtsItem)
        }
    }
    
    func testContains() throws {
        for item in vts {
            let found = sut.contains(where: { $0 == item })
            XCTAssertTrue(found)
        }
        
        let shouldNotBeFound = sut.contains(where: { $0 == 0 })
        XCTAssertFalse(shouldNotBeFound)
    }
}
