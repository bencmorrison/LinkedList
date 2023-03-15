//
//  XCTTestCase+Helpers.swift
//  
//
//  Created by Benjamin Morrison on 15/3/2023.
//

import XCTest

@testable import LinkedList

extension XCTestCase {
    func XCTAssertList<T: Equatable>(
        _ list: LinkedList<T>,
        matches array: [T],
        message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line) throws {
            
            XCTAssertEqual(list.count, array.count)
            guard array.count > 0 else { return }
            
            var index: Array.Index = 0
            var currentNode = list.head
            
            repeat {
                let node = try XCTUnwrap(currentNode)
                let nodeItem = node.element
                
                let arrayItem = array[index]
                
                XCTAssertEqual(nodeItem, arrayItem)
                
                index += 1
                currentNode = node.next
                
            } while index < array.count
    }
}
