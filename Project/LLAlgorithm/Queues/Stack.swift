//
//  Stack.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public typealias Stack<E> = StackWrapper<LinkedList<E>>

public struct StackWrapper<C : BidirectionalCollection & RangeReplaceableCollection> : AbstractQueue {
    
    public typealias Element = C.Element
    
    private var deque: DequeWrapper<C>
    
    public init(_ elements: C) {
        self.deque = DequeWrapper(elements)
    }
    
    public init() {
        self.deque = DequeWrapper<C>()
    }
    
    @discardableResult
    public mutating func enqueue(_ element: Element) -> Bool {
        return deque.tail.enqueue(element)
    }
    
    public mutating func dequeue() -> Element? {
        return deque.tail.dequeue()
    }
    
    public func peek() -> Element? {
        return deque.tail.peek()
    }
}

