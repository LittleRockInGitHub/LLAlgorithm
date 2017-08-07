//
//  Deque.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public typealias Deque<E> = DequeWrapper<LinkedList<E>>

public struct DequeWrapper<C : BidirectionalCollection & RangeReplaceableCollection> {
    
    private var elements: C
    
    public init(_ elements: C) {
        self.elements = elements
    }
    
    public init() {
        self.elements = C.init()
    }
    
    public struct Head: AbstractQueue {
        
        public typealias Element = C.Element
        
        private(set) fileprivate var elements: C
        
        init(_ elements: C) {
            self.elements = elements
        }
        
        @discardableResult
        public mutating func enqueue(_ element: Element) -> Bool {
            elements.insert(element, at: elements.startIndex)
            return true
        }
        
        public mutating func dequeue() -> Element? {
            return elements.isEmpty ? nil : elements.removeFirst()
        }
        
        public func peek() -> Element? {
            return elements.first
        }
    }
    
    public struct Tail: AbstractQueue {
        
        public typealias Element = C.Element
        
        private(set) fileprivate var elements: C
        
        init(_ elements: C) {
            self.elements = elements
        }
        
        @discardableResult
        public mutating func enqueue(_ element: Element) -> Bool {
            elements.append(element)
            return true
        }
        
        public mutating func dequeue() -> Element? {
            return elements.isEmpty ? nil : elements.removeLast()
        }
        
        public func peek() -> Element? {
            return elements.last
        }
    }
    
    public var head: DequeWrapper<C>.Head {
        get {
            return Head(elements)
        }
        set {
            elements = newValue.elements
        }
    }
    
    public var tail: DequeWrapper<C>.Tail {
        get {
            return Tail(elements)
        }
        set {
            elements = newValue.elements
        }
    }
}
