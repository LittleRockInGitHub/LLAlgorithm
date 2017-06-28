//
//  ArrayDequeTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/27.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

extension XCTestCase {
    
    func _testDeque<C>(_ deque: AnyDeque<C>) where C.Element == Int {
        
        var deque = deque
    
        self._testStack(Deque<Int>().head)
        
        self._testStack(Deque<Int>().tail)
        
        XCTAssertEqual(deque.head.enqueue(1), true)
        XCTAssertEqual(deque.tail.dequeue(), 1)
        
        XCTAssertEqual(deque.tail.enqueue(1), true)
        XCTAssertEqual(deque.head.dequeue(), 1)
        
        XCTAssertEqual(deque.head.enqueue([1, 2]), 2)
        XCTAssertEqual(deque.tail.peek(), 1)
        XCTAssertEqual(deque.tail.dequeue(), 1)
        XCTAssertEqual(deque.tail.dequeue(), 2)
        XCTAssertEqual(deque.tail.dequeue(), nil)
        XCTAssertEqual(deque.head.dequeue(), nil)
        
        XCTAssertEqual(deque.tail.enqueue([1, 2]), 2)
        XCTAssertEqual(deque.head.peek(), 1)
        XCTAssertEqual(deque.head.dequeue(), 1)
        XCTAssertEqual(deque.head.dequeue(), 2)
        XCTAssertEqual(deque.head.dequeue(), nil)
        XCTAssertEqual(deque.tail.dequeue(), nil)
    }
}

class ArrayDequeTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testHead() {
        self._testStack(Deque<Int>().head)
        self._testStack(ListDeque<Int>().head)
    }
    
    func testTail() {
        self._testStack(Deque<Int>().tail)
        self._testStack(ListDeque<Int>().tail)
    }
    
    func testDeque() {
        self._testDeque(Deque<Int>())
        self._testDeque(ListDeque<Int>())
    }
}
