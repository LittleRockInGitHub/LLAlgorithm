//
//  Stack.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public typealias Stack<E> = AnyStack<Array<E>>
public typealias ListStack<E> = AnyStack<LinkedList<E>>

public struct AnyStack<C : BidirectionalCollection & RangeReplaceableCollection> : AbstractQueue {
    
    public typealias Elements = C
    public typealias E = C.Element
    
    private var deque: AnyDeque<C>
    
    public var elements: C { return deque.elements }
    
    public init(_ elements: C) {
        self.deque = AnyDeque(elements)
    }
    
    public init() {
        self.deque = AnyDeque<C>()
    }
    
    @discardableResult
    public mutating func enqueue(_ element: E) -> Bool {
        return deque.tail.enqueue(element)
    }
    
    public mutating func dequeue() -> E? {
        return deque.tail.dequeue()
    }
    
    public func peek() -> E? {
        return deque.tail.peek()
    }
}

