//
//  AbstractQueue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public protocol AbstractQueue : IteratorProtocol, Sequence {
    
    var isEmpty: Bool { get }
    
    mutating func clear()
    
    @discardableResult
    mutating func enqueue(_ element: Element) -> Bool
    
    mutating func dequeue() -> Element?
    
    func peek() -> Element?
    
}

extension AbstractQueue {
    
    public var isEmpty: Bool { return peek() == nil }
    
    public mutating func clear() {
        _ = dequeue(maxLength: Int.max)
    }
}

extension AbstractQueue {
    
    public mutating func next() -> Element? {
        return dequeue()
    }
}

extension AbstractQueue {
    
    @discardableResult
    public mutating func enqueue<C : Collection>(_ newElements: C) -> Int where C.Element == Element {
        var count = 0
        for e in newElements {
            if enqueue(e) {
                count += 1
            }
        }
        return count
    }
    
    public mutating func dequeue(maxLength: Int) -> [Element] {
        var reval: [Element] = []
        for _ in 0..<maxLength {
            guard let e = dequeue() else { break }
            reval.append(e)
        }
        return reval
    }
}
