//
//  ListQueueTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/28.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

class ListQueueTests: XCTestCase {
    
    var queue: AnyQueue<LinkedList<Int>>!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        queue = ListQueue<Int>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQueue() {
        
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
