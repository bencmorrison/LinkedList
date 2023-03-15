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
        vts.remove(at: 2)
        sut.remove(at: 2)
        try XCTAssertList(sut, matches: vts)
        
        vts.remove(at: 1)
        sut.remove(at: 1)
        try XCTAssertList(sut, matches: vts)
        
        vts.remove(at: vts.count - 1)
        sut.remove(at: sut.count - 1)
        try XCTAssertList(sut, matches: vts)
    }
    
    func testDropFirst() throws {
        vts.remove(at: 0)
        sut.dropFirst()
        try XCTAssertList(sut, matches: vts)
        
        vts.remove(at: 0)
        sut.dropFirst()
        try XCTAssertList(sut, matches: vts)
        
        vts.remove(at: 0)
        sut.dropFirst()
        try XCTAssertList(sut, matches: vts)
    }
    
    func testRemoveAll() throws {
        vts.removeAll()
        sut.removeAll()
        try XCTAssertList(sut, matches: vts)
    }
}
