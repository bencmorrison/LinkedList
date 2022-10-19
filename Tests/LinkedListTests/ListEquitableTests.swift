//
//  File.swift
//  
//
//  Created by Benjamin Morrison on 19/10/2022.
//

import Foundation

import XCTest
@testable import LinkedList

class ListEquitableTests: XCTestCase {
    let array: [Int] = [4, 3244, 445, 958, 24783, 778, 1, 84]
    
    func testEquitableListsFromSameArray() {
        var firstList: LinkedList<Int>!
        var secondList: LinkedList<Int>!
        
        firstList = LinkedList<Int>(fromArray: array)
        secondList = LinkedList<Int>(fromArray: array)
        
        XCTAssertEqual(firstList, secondList)
    }
    
    func testEquitableListsFromList() {
        var firstList: LinkedList<Int>!
        var secondList: LinkedList<Int>!
        
        firstList = LinkedList<Int>(fromArray: array)
        secondList = LinkedList<Int>(fromList: firstList)
        
        XCTAssertEqual(firstList, secondList)
    }
}
