//
//  LinkedListCollectionTests.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import XCTest

@testable import LinkedList

final class LinkedListCollectionTests: XCTestCase {
    
    var sut: LinkedList<String>!

    override func setUpWithError() throws {
        sut = LinkedList(from: [
            "First Item",
            "Second Item",
            "Third Item",
            "Fourth Item",
            "Fifth Item"
        ])
    }

    override func tearDownWithError() throws {
        sut.removeAll()
    }
    
    func testSubscripting() throws {
        for index: UInt in 0..<sut.count {
            let indexAtItem = sut.nodeAt(index).item
            let subscriptItem = sut[index]
            
            XCTAssertEqual(subscriptItem, indexAtItem)
        }
    }
}
