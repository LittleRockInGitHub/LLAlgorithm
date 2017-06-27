//
//  ArrayDequeTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/27.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

class ArrayDequeTest: XCTestCase {
    
    var deque: AnyDeque<Array<Int>>!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        deque = Deque<Int>()
    }
    
    func testHead() {
        
        XCTAssertEqual(deque.head.enqueue(1), true)
        
        XCTAssertEqual(deque.elements.count, 1)
        
        XCTAssertEqual(deque.head.dequeue(), 1)
        
        XCTAssertEqual(deque.elements.count, 0)
        
        XCTAssertEqual(deque.head.enqueue([1, 2]), 2)
        XCTAssertEqual(deque.elements.count, 2)
        
        XCTAssertEqual(deque.head.peek(), 2)
        XCTAssertEqual(deque.head.dequeue(), 2)
        XCTAssertEqual(deque.head.dequeue(), 1)
        XCTAssertEqual(deque.head.dequeue(), nil)
    }
    
    func testTail() {
        
        XCTAssertEqual(deque.tail.enqueue(1), true)
        
        XCTAssertEqual(deque.elements.count, 1)
        
        XCTAssertEqual(deque.tail.dequeue(), 1)
        
        XCTAssertEqual(deque.elements.count, 0)
        
        XCTAssertEqual(deque.head.enqueue([1, 2]), 2)
        XCTAssertEqual(deque.elements.count, 2)
        
        XCTAssertEqual(deque.head.peek(), 2)
        XCTAssertEqual(deque.head.dequeue(), 2)
        XCTAssertEqual(deque.head.dequeue(), 1)
        XCTAssertEqual(deque.head.dequeue(), nil)
    }
    
    func testDeque() {
        
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
