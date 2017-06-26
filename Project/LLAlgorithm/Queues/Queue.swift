//
//  Queue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public struct Queue<E> : AbstractQueue {
    
    public typealias Elements = [E]
    
    private(set) public var elements: [E]
    
    public init(elements: Elements) {
        self.elements = elements
    }
    
    @discardableResult
    public mutating func enqueue(_ element: E) -> Bool {
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> E? {
        return elements.isEmpty ? nil : elements.removeFirst()
    }
    
    public func peek() -> E? {
        return elements.first
    }
}

