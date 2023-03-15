//
//  LinkedListInsertingTests.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import XCTest

@testable import LinkedList

final class LinkedListNodeInsertingTests: XCTestCase {

    var sut: LinkedList<String>!
    var vts: [String]!
    
    override func setUpWithError() throws {
        sut = LinkedList<String>()
        vts = []
    }

    override func tearDownWithError() throws {
        sut.removeAll()
    }

    func testInsertBeforeOnEmptyList() throws {
        let itemForInsert = "This is a string"
        let nodeForInsert = Node(itemForInsert)
        vts.insert(itemForInsert, at: 0)
        sut.insert(nodeForInsert, beforeNode: sut.head)
        
        try XCTAssertList(sut, matches: vts)
        XCTAssertTrue(nodeForInsert.isNode(sut.head))
        XCTAssertTrue(nodeForInsert.isNode(sut.tail))
    }
    
    func testInsertAfterOnEmptyList() throws {
        let itemForInsert = "This is a string"
        let nodeForInsert = Node(itemForInsert)
        vts.insert(itemForInsert, at: 0)
        sut.insert(nodeForInsert, afterNode: sut.head)
        
        try XCTAssertList(sut, matches: vts)
        XCTAssertTrue(nodeForInsert.isNode(sut.head))
        XCTAssertTrue(nodeForInsert.isNode(sut.tail))
    }
    
    func testInsertBeforeHeadTests() throws {
        vts = ["This is a string", "This is another string", "Oh a third one!"]
        sut.insert(Node(vts[2]), beforeNode: sut.head)
        sut.insert(Node(vts[1]), beforeNode: sut.head)
        sut.insert(Node(vts[0]), beforeNode: sut.head)
        
        try XCTAssertList(sut, matches: vts)
    }
    
    func testInsertAfterHeadTests() throws {
        vts = ["This is a string", "This is another string", "Oh a third one!"]
        sut.insert(Node(vts[0]), afterNode: sut.head)
        sut.insert(Node(vts[2]), afterNode: sut.head)
        sut.insert(Node(vts[1]), afterNode: sut.head)
        
        try XCTAssertList(sut, matches: vts)
    }
    
    func testInsertBeforeTailTests() throws {
        vts = ["This is a string", "This is another string", "Oh a third one!"]
        sut.insert(Node(vts[2]), beforeNode: sut.tail)
        sut.insert(Node(vts[0]), beforeNode: sut.tail)
        sut.insert(Node(vts[1]), beforeNode: sut.tail)
        
        try XCTAssertList(sut, matches: vts)
    }
    
    func testInsertAfterTailTests() throws {
        vts = ["This is a string", "This is another string", "Oh a third one!"]
        sut.insert(Node(vts[0]), afterNode: sut.tail)
        sut.insert(Node(vts[1]), afterNode: sut.tail)
        sut.insert(Node(vts[2]), afterNode: sut.tail)
        
        try XCTAssertList(sut, matches: vts)
    }
    
    func testPushFront() throws {
        var insertItem = "This is a test string"
        vts.append(insertItem)
        sut.pushFront(Node(insertItem))
        try XCTAssertList(sut, matches: vts)
        
        insertItem = "Another String for the test"
        vts.insert(insertItem, at: 0)
        sut.pushFront(Node(insertItem))
        try XCTAssertList(sut, matches: vts)
        
        insertItem = "Finally... another string"
        vts.insert(insertItem, at: 0)
        sut.pushFront(Node(insertItem))
        try XCTAssertList(sut, matches: vts)
    }
    
    func testPushBack() throws {
        var insertItem = "This is a test string"
        vts.append(insertItem)
        sut.pushBack(Node(insertItem))
        try XCTAssertList(sut, matches: vts)
        
        insertItem = "Another String for the test"
        vts.append(insertItem)
        sut.pushBack(Node(insertItem))
        try XCTAssertList(sut, matches: vts)
        
        insertItem = "Finally... another string"
        vts.append(insertItem)
        sut.pushBack(Node(insertItem))
        try XCTAssertList(sut, matches: vts)
    }
    
    func testInsertNodeAtIndex() throws {
        // Plan
        // insert the a @ 1
        // insert the i @ 3
        // insert the o @ 5
        // insert the i @ 8
        // insert the a @ 9
        // vts = ["C", "a", "l", "i", "f", "o", "r", "n", "i", "a"]
        vts = ["C", "l", "f", "r", "n"]
        sut = LinkedList(from: vts)
        
        var letter = "a"
        var index: Int = 1
        vts.insert(letter, at: index)
        sut.insert(Node(letter), atIndex: index)
        try XCTAssertList(sut, matches: vts)
        
        letter = "i"
        index = 3
        vts.insert(letter, at: index)
        sut.insert(Node(letter), atIndex: index)
        try XCTAssertList(sut, matches: vts)
        
        letter = "o"
        index = 5
        vts.insert(letter, at: index)
        sut.insert(Node(letter), atIndex: index)
        try XCTAssertList(sut, matches: vts)
        
        letter = "i"
        index = 8
        vts.insert(letter, at: index)
        sut.insert(Node(letter), atIndex: index)
        try XCTAssertList(sut, matches: vts)
        
        letter = "a"
        index = 9
        vts.insert(letter, at: index)
        sut.insert(Node(letter), atIndex: index)
        try XCTAssertList(sut, matches: vts)
    }
}
