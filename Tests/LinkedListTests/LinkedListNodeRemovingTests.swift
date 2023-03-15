//
//  LinkedListNodeRemovingTests.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import XCTest

@testable import LinkedList

final class LinkedListNodeRemovingTests: XCTestCase {

    var sut: LinkedList<String>!
    var vts: [String]!
    
    override func setUpWithError() throws {
        vts = ["This", "is", "the", "validation", "test", "source"]
        sut = LinkedList(from: vts)
    }

    override func tearDownWithError() throws {
        vts.removeAll()
        sut.removeAll()
    }

    func testRemoveAtIndex() throws {
        var index = 2
        vts.remove(at: index)
        sut.removeNode(at: index)
        try XCTAssertList(sut, matches: vts)
        
        index = 1
        vts.remove(at: index)
        sut.removeNode(at: index)
        try XCTAssertList(sut, matches: vts)
        
        index = vts.count - 1
        vts.remove(at: index)
        sut.removeNode(at: index)
        try XCTAssertList(sut, matches: vts)
    }
    
    func testDropLast() throws {
        vts.removeFirst()
        sut.removeFirstNode()
        try XCTAssertList(sut, matches: vts)
        
        vts.removeFirst()
        sut.removeFirstNode()
        try XCTAssertList(sut, matches: vts)
        
        vts.removeFirst()
        sut.removeFirstNode()
        try XCTAssertList(sut, matches: vts)
    }
    
    func testDropLastNode() throws {
        vts.removeLast()
        sut.removeLastNode()
        try XCTAssertList(sut, matches: vts)
        
        vts.removeLast()
        sut.removeLastNode()
        try XCTAssertList(sut, matches: vts)
        
        vts.removeLast()
        sut.removeLastNode()
        try XCTAssertList(sut, matches: vts)
    }
    
    func testRemoveAll() throws {
        vts.removeAll()
        sut.removeAll()
        try XCTAssertList(sut, matches: vts)
    }
}
