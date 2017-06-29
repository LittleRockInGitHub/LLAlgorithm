//
//  BinarySearchingTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/29.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

func _testBinarySearching<C : RandomAccessCollection>(in collection: C, with element: Int, position: BinarySearching.EqualPosition) where C.SubSequence : RandomAccessCollection, C.Element == Int {
    
    let result = collection.binarySearch(element, equalPosition: position)
    
    switch result {
    case .found(let idx):
        XCTAssertEqual(collection[idx], element)
    case .notFound(insertion: let insertion):
        if insertion > collection.startIndex {
            XCTAssertLessThan(collection[collection.index(before: insertion)], element)
        }
        if insertion < collection.endIndex {
            XCTAssertLessThan(element, collection[insertion])
        }
    }
}

class BinarySearchingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSearching() {
        
        var array = [Int]()
        
        var result = array.binarySearch(0)  // []
        
        XCTAssertEqual(result.insertion, 0)
        
        
        array.append(0)
        result = array.binarySearch(0)  // [0]
        XCTAssertEqual(result.found, 0)
        
        array.append(contentsOf: [1, 1, 1, 1, 1, 3, 4, 5])
        result = array.binarySearch(5)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.found, 8)
        
        result = array.binarySearch(1)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.found, 4)
        
        result = array.binarySearch(1, equalPosition: .first)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.found, 1)
        
        result = array.binarySearch(1, equalPosition: .last)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.found, 5)
        
        result = array.binarySearch(-1)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.insertion, 0)
        
        result = array.binarySearch(2)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.insertion, 6)
        
        result = array.binarySearch(6)  // [0, 1, 1, 1, 1, 1, 3, 4, 5]
        XCTAssertEqual(result.insertion, 9)
    }
    
}

extension BinarySearching.Result {
    
    var found: Index? {
        switch self {
        case .found(let idx):
            return idx
        default:
            return nil
        }
    }
    
    var insertion: Index? {
        switch self {
        case .notFound(insertion: let idx):
            return idx
        default:
            return nil
        }
    }
}
