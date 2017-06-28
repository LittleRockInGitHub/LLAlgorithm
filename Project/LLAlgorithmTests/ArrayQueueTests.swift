//
//  ArrayQueueTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/28.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

extension XCTestCase {
    
    func _testQueue<Q>(_ queue: Q) where Q : AbstractQueue, Q.Elements.Element == Int {
        
        var queue = queue
        XCTAssertEqual(queue.enqueue(1), true)
        
        XCTAssertEqual(queue.count, 1)
        
        XCTAssertEqual(queue.dequeue(), 1)
        
        XCTAssertEqual(queue.count, 0)
        
        XCTAssertEqual(queue.enqueue([1, 2]), 2)
        XCTAssertEqual(queue.count, 2)
        
        XCTAssertEqual(queue.peek(), 1)
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertEqual(queue.dequeue(), 2)
        XCTAssertEqual(queue.dequeue(), nil)
    }
}

class ArrayQueueTests: XCTestCase {
    
    func testArrayQueue() {
        self._testQueue(Queue<Int>())
    }
    
    func testListQueue() {
        self._testQueue(ListQueue<Int>())
    }
}
