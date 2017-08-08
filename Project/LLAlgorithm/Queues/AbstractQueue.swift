//
//  AbstractQueue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public protocol AbstractQueue : Sequence {
    
    var isEmpty: Bool { get }
    
    mutating func clear()
    
    @discardableResult
    mutating func enqueue(_ element: Element) -> Bool
    
    mutating func dequeue() -> Element?
    
    func peek() -> Element?
    
    @discardableResult
    mutating func enqueue<C : Collection>(_ newElements: C) -> Int where C.Element == Element
    
    mutating func dequeue(maxLength: Int) -> [Element]
    
}

extension AbstractQueue {
    
    public var isEmpty: Bool { return peek() == nil }
    
    public mutating func clear() {
        _ = dequeue(maxLength: Int.max)
    }
}

public struct AbstractQueueIterator<Queue: AbstractQueue> : IteratorProtocol {
    
    private var queue: Queue
    
    init(_ queue: Queue) {
        self.queue = queue
    }
    
    public mutating func next() -> Queue.Element? {
        return queue.dequeue()
    }
}

extension AbstractQueue {
    
    public func makeIterator() -> AbstractQueueIterator<Self> {
        return AbstractQueueIterator(self)
    }
}

extension AbstractQueue {
    
    @discardableResult
    public mutating func enqueue<C : Collection>(_ newElements: C) -> Int where C.Element == Element {
        var count = 0
        for e in newElements {
            if enqueue(e) {
                count += 1
            } else {
                break
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
