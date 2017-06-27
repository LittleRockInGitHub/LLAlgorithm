//
//  Deque.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public typealias Deque<E> = AnyDeque<Array<E>>
public typealias ListDeque<E> = AnyDeque<LinkedList<E>>

public struct AnyDeque<C : BidirectionalCollection & RangeReplaceableCollection> {
    
    public typealias E = C.Element
    
    private(set) public var elements: C
    
    public init(_ elements: C) {
        self.elements = elements
    }
    
    public init() {
        self.elements = C.init()
    }
    
    public struct Head: AbstractQueue {
        
        public typealias Elements = C
        
        private(set) public var elements: C
        
        @discardableResult
        public mutating func enqueue(_ element: E) -> Bool {
            elements.insert(element, at: elements.startIndex)
            return true
        }
        
        public mutating func dequeue() -> E? {
            return elements.isEmpty ? nil : elements.removeFirst()
        }
        
        public func peek() -> E? {
            return elements.first
        }
    }
    
    public struct Tail: AbstractQueue {
        
        public typealias Elements = C
        
        private(set) public var elements: C
        
        @discardableResult
        public mutating func enqueue(_ element: E) -> Bool {
            elements.append(element)
            return true
        }
        
        public mutating func dequeue() -> E? {
            return elements.isEmpty ? nil : elements.removeLast()
        }
        
        public func peek() -> E? {
            return elements.last
        }
    }
    
    public var head: AnyDeque<C>.Head {
        get {
            return Head(elements: elements)
        }
        set {
            elements = newValue.elements
        }
    }
    
    public var tail: AnyDeque<C>.Tail {
        get {
            return Tail(elements: elements)
        }
        set {
            elements = newValue.elements
        }
    }
}
