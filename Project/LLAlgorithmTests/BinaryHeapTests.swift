//
//  BinaryHeapTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/28.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

extension XCTestCase {
    
    func _testMaxPriorityQueue<Q : AbstractQueue>(_ heap: Q) where Q.Element == Int {
        
        var heap = heap
        
        heap.clear()
        XCTAssertEqual(heap.isEmpty, true)
        
        XCTAssertNil(heap.dequeue())
        
        XCTAssertEqual(heap.enqueue(1), true)
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.peek(), 1)
        
        XCTAssertEqual(heap.enqueue(1), true)
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.peek(), 1)
        
        XCTAssertEqual(heap.enqueue(0), true)
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.dequeue(), 1)
        XCTAssertEqual(heap.peek(), 1)
        
        XCTAssertEqual(heap.enqueue([1, 2, 4, -1, 3]), 5)
        XCTAssertEqual(heap.peek(), 4)
        XCTAssertEqual(heap.dequeue(maxLength: 10), [4, 3, 2, 1, 1, 0, -1])
        XCTAssertEqual(heap.isEmpty, true)
    }
    
    func _testMinPriorityQueue<Q : AbstractQueue>(_ heap: Q) where Q.Element == Int {
        
        var heap = heap
        
        heap.clear()
        XCTAssertEqual(heap.isEmpty, true)
        
        XCTAssertNil(heap.dequeue())
        
        XCTAssertEqual(heap.enqueue(1), true)
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.peek(), 1)
        
        XCTAssertEqual(heap.enqueue(1), true)
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.peek(), 1)
        
        XCTAssertEqual(heap.enqueue(0), true)
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.dequeue(), 0)
        XCTAssertEqual(heap.peek(), 1)
        
        XCTAssertEqual(heap.enqueue([1, 2, 4, -1, 3]), 5)
        XCTAssertEqual(heap.peek(), -1)
        XCTAssertEqual(heap.dequeue(maxLength: 10), [-1, 1, 1, 1, 2, 3, 4])
        XCTAssertEqual(heap.isEmpty, true)
    }
}

class BinaryHeapTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHeap() {
        
        self._testMaxPriorityQueue(BinaryHeap([12, 3]))
        self._testMinPriorityQueue(BinaryHeap([12, 3], asMaxHeap: false))
    }
    
    func testTuple() {
        
        var heap = BinaryHeap<(Int, String)> { (l, r) -> Bool in
            return l.1 < r.1
        }
        
        heap.enqueue((0, "A"))
        XCTAssertEqual(heap.peek()?.1, "A")
        
        heap.enqueue((-1, "B"))
        XCTAssertEqual(heap.dequeue()?.1, "A")
        
        heap.enqueue([(2, "A"), (3, "B")])
        XCTAssertEqual(heap.dequeue(maxLength: 10).map({ $0.1 }), ["A", "B", "B"])
    }
}
