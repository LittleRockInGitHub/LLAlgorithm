//
//  Binaryelements.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public struct BinaryHeap<E> : PriorityQueue {
    
    public typealias Element = E
    
    private var elements: [E]
    
    public let comparator: (E, E) -> Bool
    
    init<S : Sequence>(elements: S, comparator: @escaping (E, E) -> Bool) where S.Element == E {
        self.elements = Array(elements)
        self.comparator = comparator
        
        self.heapify()
    }
    
    private mutating func heapify() {
        var idx = elements.count / 2 - 1
        while idx >= 0 {
            siftDown(idx)
            idx -= 1
        }
    }
    
    private mutating func siftDown(_ idx: Int) {
        
        var idx = idx
        
        while 2 * idx + 1 < elements.count {
            
            var j = 2 * idx + 1
            
            if j < (elements.count - 1) && comparator(elements[j], elements[j + 1]) { j += 1 }
            if !comparator(elements[idx], elements[j]) { break }
            
            elements.swapAt(idx, j)
            idx = j
        }
    }
    
    private mutating func siftUp(_ idx: Int) {
        
        var idx = idx
        
        while idx > 0 && comparator(elements[(idx - 1) / 2], elements[idx]) {
            elements.swapAt((idx - 1) / 2, idx)
            idx = (idx - 1) / 2
        }
    }
    
    @discardableResult
    public mutating func enqueue(_ element: E) -> Bool {
        elements.append(element)
        siftUp(elements.count - 1)
        return true
    }
    
    public mutating func dequeue() -> E? {
        
        guard elements.isEmpty else { return nil }
        
        elements.swapAt(0, elements.count - 1)
        
        let reval = elements.removeLast()
        
        siftDown(0)
        
        return reval
    }
    
    public func peek() -> E? {
        return elements.first
    }
}

extension BinaryHeap where E : Comparable {
    
    public init<S : Sequence>(elements: S, asMaxHeap: Bool = true) where S.Element == E {
        if asMaxHeap {
            self.init(elements: elements, comparator: >)
        } else {
            self.init(elements: elements, comparator: <)
        }
    }
}
