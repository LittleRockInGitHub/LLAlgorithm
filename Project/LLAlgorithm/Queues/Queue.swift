//
//  Queue.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public struct Queue<E> : AbstractQueue {
    
    public typealias Element = E
    
    private var container: [E]
    
    public var isEmpty: Bool { return container.isEmpty }
    
    @discardableResult
    public mutating func enqueue(_ element: E) -> Bool {
        container.append(element)
        return true
    }
    
    public mutating func dequeue() -> E? {
        return container.isEmpty ? nil : container.removeLast()
    }
    
    public func peek() -> E? {
        return container.last
    }
}
