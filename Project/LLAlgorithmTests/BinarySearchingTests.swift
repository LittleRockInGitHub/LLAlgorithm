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
    case let .found(idx):
        XCTAssertEqual(collection[idx], element)
        
        switch position {
        case .any:
            break
        case .first:
            if idx > collection.startIndex {
                XCTAssertLessThan(collection[collection.index(before: idx)], element)
            }
        case .last:
            if collection.index(after: idx) < collection.endIndex {
                XCTAssertLessThan(element, collection[collection.index(after: idx)])
            }
        }
    case let .notFound(insertion):
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
    
    func testRandom() {
        for _ in 0..<1000 {
            var array = [Int]()
            array.append(contentsOf: _randomArray(1000))
            
            array.sort()
            
            _testBinarySearching(in: array, with: Int(arc4random()) % 110 - 5, position: .random())
        }
    }
    
    func testSorted() {
        
        var array = [1, 2, 3, 3, 4, 5]
        XCTAssertEqual(array.isSorted(), true)
        XCTAssertEqual(array.isSorted(ascending: false), false)
        
        array = [5, 4, 4, 2, 1]
        XCTAssertEqual(array.isSorted(), false)
        XCTAssertEqual(array.isSorted(ascending: false), true)
        
        array = []
        XCTAssertEqual(array.isSorted(), true)
        XCTAssertEqual(array.isSorted(ascending: false), true)
        
        array = [1]
        XCTAssertEqual(array.isSorted(), true)
        XCTAssertEqual(array.isSorted(ascending: false), true)
        
        array = [1, 2, 1, 3, 2]
        XCTAssertEqual(array.isSorted(), false)
        XCTAssertEqual(array.isSorted(ascending: false), false)
        
        var tupleArray: [(Int, String)] = [(0, "A"), (1, "B"), (0, "B")]
        let comparator: ElementComparator<(Int, String)> = { (l: (Int, String), r: (Int, String)) -> ComparisonResult in
            if l.1 < r.1 {
                return .orderedAscending
            } else if l.1 > r.1 {
                return .orderedDescending
            } else {
                return .orderedSame
            }
        }
        
        XCTAssertEqual(tupleArray.isSorted(usingComparator: comparator), true)
        XCTAssertEqual(tupleArray.isSorted(usingComparator: reversed(comparator)), false)
        
        tupleArray = [(0, "C"), (1, "B"), (0, "A")]
        XCTAssertEqual(tupleArray.isSorted(usingComparator: comparator), false)
        XCTAssertEqual(tupleArray.isSorted(usingComparator: reversed(comparator)), true)
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

extension BinarySearching.EqualPosition {
    
    static func random() -> BinarySearching.EqualPosition {
        return self.init(rawValue: Int(arc4random()) % 3 - 1)!
    }
}
