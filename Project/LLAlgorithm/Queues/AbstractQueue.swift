//
//  AbstractQueue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public protocol AbstractQueue : IteratorProtocol, Sequence {
    
    associatedtype Elements : Collection
    
    var elements: Elements { get }
    
    @discardableResult
    mutating func enqueue(_ element: Elements.Element) -> Bool
    
    mutating func dequeue() -> Elements.Element?
    
    func peek() -> Elements.Element?
}

extension AbstractQueue {
    
    public var isEmpty: Bool { return elements.isEmpty }
    
    public var count: Elements.IndexDistance { return elements.count }
}

extension AbstractQueue {
    
    public mutating func next() -> Elements.Element? {
        return dequeue()
    }
}

extension AbstractQueue {
    
    @discardableResult
    public mutating func enqueue<C : Collection>(_ newElements: C) -> Int where C.Element == Elements.Element {
        var count = 0
        for e in newElements {
            if enqueue(e) {
                count += 1
            }
        }
        return count
    }
    
    public mutating func dequeue(_ maxLength: Int) -> [Elements.Element] {
        var reval: [Elements.Element] = []
        for _ in 0..<maxLength {
            if let e = dequeue() {
                reval.append(e)
            }
        }
        return reval
    }
}
