//
//  LinkedListTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/27.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

func _randomArray(_ number: Int = 5) -> [Int] {
    var reval: [Int] = []
    for _ in 0..<(Int(arc4random()) % number) {
        reval.append(Int(arc4random()) % 100)
    }
    return reval
}

class LinkedListTests: XCTestCase {
    
    var array: [Int] = []
    var list: LinkedList<Int> = LinkedList<Int>()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        array = []
        list = LinkedList<Int>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    func testAdd() {
//
//        list.append(0)
//        list._test(equalsTo: [0])
//
//        list.append(contentsOf: [1, 2])
//        list._test(equalsTo: [0, 1, 2])
//
//        list.insert(-1, at: 0)
//        list._test(equalsTo: [-1, 0, 1, 2])
//
//        list.insert(contentsOf: [3, 4], at: 4)
//        list._test(equalsTo: [-1, 0, 1, 2, 3, 4])
//
//        list.insert(contentsOf: [8], at: 1)
//        list._test(equalsTo: [-1, 8, 0, 1, 2, 3, 4])
//    }
//
//    func testRemove() {
//
//        list.removeAll()
//
//        list.append(contentsOf: [1, 2, 3, 4, 5])
//
//        list.removeFirst()
//        list._test(equalsTo: [2, 3, 4, 5])
//
//        list.removeLast()
//        list._test(equalsTo: [2, 3, 4])
//
//        list.remove(at: 1)
//        list._test(equalsTo: [2, 4])
//
//        list.remove(at: 1)
//        list._test(equalsTo: [2])
//
//        list.remove(at: 0)
//        list._test(equalsTo: [])
//
//        list.append(contentsOf: [1, 2, 3, 4, 5])
//
//        list.removeSubrange(0..<0)
//        list._test(equalsTo: [1, 2, 3, 4, 5])
//
//        list.removeSubrange(0..<1)
//        list._test(equalsTo: [2, 3, 4, 5])
//
//        list.removeSubrange(2...3)
//        list._test(equalsTo: [2, 3])
//    }
    
    func testReplace() {
        
        func _test<R, C>(_ subrange: R, with newElements: C) where R : RangeExpression, R.Bound == Int, C : Collection, C.Element == Int {
            
            array.replaceSubrange(subrange, with: newElements)
            list.replaceSubrange(list.range(fromOffsetRange: subrange), with: newElements)
            
            print(list)
            
            XCTAssertEqual(Array(list), array)
        }
        
        func _randomRange(in array: [Int]) -> Range<Int> {
            
            func random(_ underOrEqual: Int) -> Int {
                return Int(arc4random()) % (underOrEqual + 1)
            }
            
            let lower = random(array.count)
            let upper = lower + random(array.count - lower)
            
            return lower..<upper
        }
        
        _test(0..<0, with: [])  // []
        
        _test(0..<0, with: [1]) // [1]
        
        _test(0..<1, with: [2]) // [2]
            
        _test(1..<1, with: [2, 3, 4]) // [2, 2, 3, 4]
        
        _test(3..<3, with: [5]) // [2, 2, 3, 5, 4]
        
        _test(4..<4, with: [])  // [2, 3, 3, 5, 4]
        
        _test(1..<3, with: [6])  // [2, 6, 5, 4]
        
        _test(0..., with: []) // []
        
        for _ in 0..<100 {
            _test(_randomRange(in: array), with: _randomArray())
        }
        
        for _ in 0..<100 {
            _test(_randomRange(in: array), with: LinkedList<Int>(_randomArray()))
        }
    }
    
    func testSubscript() {
        
        list.append(1)
        
        XCTAssertEqual(list[offset: 0], 1)
        XCTAssertEqual(list[list.startIndex], 1)
        
        list.insert(0, at: list.startIndex)
        XCTAssertEqual(list[list.startIndex], 0)
        
        list[offset: 1] = 2
        XCTAssertEqual(list[list.startIndex], 0)
        XCTAssertEqual(list[list.index(after: list.startIndex)], 2)
    }
    
    func testCopy() {
        
        let sameList = list
        
        list.append(1)
        
        XCTAssertEqual(sameList.count, 1)
        
        let copiedList = list.copy() as! LinkedList<Int>
        
        list.append(2)
        
        XCTAssertEqual(copiedList.count, 1)
    }
}

extension Collection {
    
    subscript(offset offset: IndexDistance) -> Element {
        return self[offset: offset, from: self.startIndex]
    }
    
    subscript(offset offset: IndexDistance, from start: Index) -> Element {
        return self[index(start, offsetBy: offset)]
    }
    
    func range<R: RangeExpression>(fromOffsetRange r: R) -> Range<Index> where R.Bound == IndexDistance, IndexDistance.Stride : SignedInteger {
        let whole: CountableRange<IndexDistance> = 0..<count
        let offsetRange = r.relative(to: whole)
        
        return index(startIndex, offsetBy: offsetRange.lowerBound)..<index(startIndex, offsetBy: offsetRange.upperBound)
    }
    
}

extension MutableCollection {
    
    subscript(offset offset: IndexDistance) -> Element {
        get {
            return self[offset: offset, from: startIndex]
        }
        set {
            self[offset: offset, from: startIndex] = newValue
        }
    }
    
    subscript(offset offset: IndexDistance, from start: Index) -> Element {
        get {
            return self[index(start, offsetBy: offset)]
        }
        set {
            self[index(start, offsetBy: offset)] = newValue
        }
    }
}

