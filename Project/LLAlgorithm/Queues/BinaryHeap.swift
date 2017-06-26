//
//  Binaryelements.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public struct BinaryHeap<E> : PriorityQueue {
    
    public typealias Elements = [E]
    
    private(set) public var elements: [E]
    
    public let comparator: (E, E) -> Bool
    
    init<S : Sequence>(elements: S, capacity: Int = 0, comparator: @escaping (E, E) -> Bool) where S.Element == E {
        var elements = Array(elements)
        let capacity = max(capacity, elements.count)
        if capacity > 0 {
            elements.reserveCapacity(capacity)
        }
        self.elements = elements
        self.comparator = comparator
        
        self.construct()
    }
    
    private mutating func construct() {
        var idx = elements.count / 2 - 1
        while idx >= 0 {
            sink(idx)
            idx -= 1
        }
    }
    
    private mutating func sink(_ idx: Int) {
        
        var idx = idx
        
        while 2 * idx + 1 < elements.count {
            
            var j = 2 * idx + 1
            
            if j < (elements.count - 1) && comparator(elements[j], elements[j + 1]) { j += 1 }
            if !comparator(elements[idx], elements[j]) { break }
            
            elements.swapAt(idx, j)
            idx = j
        }
    }
    
    private mutating func swim(_ idx: Int) {
        
        var idx = idx
        
        while idx > 0 && comparator(elements[(idx - 1) / 2], elements[idx]) {
            elements.swapAt((idx - 1) / 2, idx)
            idx = (idx - 1) / 2
        }
    }
    
    @discardableResult
    public mutating func enqueue(_ element: E) -> Bool {
        elements.append(element)
        swim(elements.count - 1)
        return true
    }
    
    public mutating func dequeue() -> E? {
        
        guard elements.isEmpty else { return nil }
        
        elements.swapAt(0, elements.count - 1)
        
        let reval = elements.removeLast()
        
        sink(0)
        
        return reval
    }
    
    public func peek() -> E? {
        return elements.first
    }
}

extension BinaryHeap where E : Comparable {
    
    public init<S : Sequence>(elements: S, capacity: Int = 0, asMaxHeap: Bool = true) where S.Element == E {
        if asMaxHeap {
            self.init(elements: elements, capacity: capacity, comparator: >)
        } else {
            self.init(elements: elements, capacity: capacity, comparator: <)
        }
    }
}
