//
//  SortTests.swift
//  BCMDoublyLinkedListTests
//
//  Created by Benjamin Morrison on 27/5/19.
//  Copyright © 2019 Benjamin C Morrison. All rights reserved.
//

import XCTest
@testable import LinkedList

class ListSortTests: XCTestCase {
    let unsortedArray: [Int] = [4, 3244, 445, 958, 24783, 778, 1, 84]
    var sortedArray: [Int]!
    var unsortedList: LinkedList<Int>!

    override func setUp() {
        unsortedList = LinkedList(from: unsortedArray)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSortingAsc() {
        sortedArray = unsortedArray.sorted { $0 < $1 }
        let sortedList = unsortedList.sorted { $0 < $1 }
        
        var previous = 0
        for value in sortedList {
            XCTAssertLessThan(previous, value)
            previous = value
        }
    }
    
    func testSortingDes() {
        sortedArray = unsortedArray.sorted { $0 > $1 }
        let sortedList = unsortedList.sorted { $0 > $1 }
        
        var previous:Int = Int.max
        for value in sortedList {
            XCTAssertGreaterThan(previous, value)
            previous = value
        }
    }
}
