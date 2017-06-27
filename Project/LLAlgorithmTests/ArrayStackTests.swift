//
//  ArrayStackTests.swift
//  LLAlgorithmTests
//
//  Created by Rock Yang on 2017/6/27.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import XCTest
import LLAlgorithm

class ArrayStackTests: XCTestCase {
    
    var stack: AnyStack<Array<Int>>!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        stack = Stack<Int>()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStack() {
        
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
