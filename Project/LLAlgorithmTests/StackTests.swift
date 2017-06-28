//
//  StackTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/28.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

extension XCTestCase {
    
    func _testStack<Q>(_ stack: Q) where Q : AbstractQueue, Q.Element == Int {
        
        var stack = stack
        XCTAssertEqual(stack.enqueue(1), true)
        
        XCTAssertEqual(stack.isEmpty, false)
        
        XCTAssertEqual(stack.dequeue(), 1)
        
        XCTAssertEqual(stack.isEmpty, true)
        
        XCTAssertEqual(stack.enqueue([1, 2]), 2)
        XCTAssertEqual(stack.isEmpty, false)
        
        XCTAssertEqual(stack.peek(), 2)
        XCTAssertEqual(stack.dequeue(), 2)
        XCTAssertEqual(stack.dequeue(), 1)
        XCTAssertEqual(stack.dequeue(), nil)
    }
}

class StackTests: XCTestCase {
    
    func testArrayStack() {
        
        self._testStack(Stack<Int>())
    }
    
    func testListStack() {
        
        self._testStack(ListStack<Int>())
    }
}
