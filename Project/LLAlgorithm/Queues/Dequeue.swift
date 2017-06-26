//
//  Dequeue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public struct Dequeue<E> {
    
    private(set) public var elements: [E]
    
    public struct Head: AbstractQueue {
        
        public typealias Elements = [E]
        
        private(set) public var elements: [E]
        
        @discardableResult
        public mutating func enqueue(_ element: E) -> Bool {
            elements.insert(element, at: 0)
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
        
        public typealias Elements = [E]
        
        private(set) public var elements: [E]
        
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
    
    public var head: Dequeue.Head {
        get {
            return Head(elements: elements)
        }
        set {
            elements = newValue.elements
        }
    }
    
    public var tail: Dequeue<E>.Tail {
        get {
            return Tail(elements: elements)
        }
        set {
            elements = newValue.elements
        }
    }
}
