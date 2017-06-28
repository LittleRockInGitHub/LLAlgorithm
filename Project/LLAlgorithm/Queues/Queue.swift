//
//  Queue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public typealias Queue<E> = QueueWrapper<Array<E>>
public typealias ListQueue<E> = QueueWrapper<LinkedList<E>>

public struct QueueWrapper<C : BidirectionalCollection & RangeReplaceableCollection> : AbstractQueue {
    
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
        return deque.head.enqueue(element)
    }
    
    public mutating func dequeue() -> Element? {
        return deque.tail.dequeue()
    }
    
    public func peek() -> Element? {
        return deque.tail.peek()
    }
}

