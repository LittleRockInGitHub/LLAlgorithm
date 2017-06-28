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
    
    func _testStack<Q>(_ stack: Q) where Q : AbstractQueue, Q.Elements.Element == Int {
        
        var stack = stack
        XCTAssertEqual(stack.enqueue(1), true)
        
        XCTAssertEqual(stack.count, 1)
        
        XCTAssertEqual(stack.dequeue(), 1)
        
        XCTAssertEqual(stack.count, 0)
        
        XCTAssertEqual(stack.enqueue([1, 2]), 2)
        XCTAssertEqual(stack.count, 2)
        
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
