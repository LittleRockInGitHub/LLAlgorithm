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
    
    private let comparator: (E, E) -> Bool
    
    public func isHigherPriority(_ lhs: E, than rhs: E) -> Bool {
        return comparator(lhs, rhs)
    }
    
    public init(isHigherPriorityThan comparator: @escaping (E, E) -> Bool) {
        self.init([], isHigherPriorityThan: comparator)
    }
    
    public init<S : Sequence>(_ elements: S, isHigherPriorityThan comparator: @escaping (E, E) -> Bool) where S.Element == E {
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
    
    private func higherChild(at idx: Int) -> Int? {
        
        let left = idx * 2 + 1
        
        guard left < elements.count else { return nil }
        
        let right = idx * 2 + 2
        
        if right < elements.count && isHigherPriority(elements[right], than: elements[left]) {
            return right
        } else {
            return left
        }
    }
    
    private mutating func siftDown(_ idx: Int) {
        
        var sifting = idx
        while let child = higherChild(at: sifting), isHigherPriority(elements[child], than: elements[sifting]) {
            elements.swapAt(sifting, child)
            sifting = child
        }
    }
    
    private func parent(at idx: Int) -> Int? {
        return idx > 0 ? (idx - 1) / 2 : nil
    }
    
    private mutating func siftUp(_ idx: Int) {
        
        var sifting = idx
        while let parent = parent(at: sifting), isHigherPriority(elements[sifting], than: elements[parent]) {
            elements.swapAt(parent, sifting)
            sifting = parent
        }
    }
    
    @discardableResult
    public mutating func enqueue(_ element: E) -> Bool {
        elements.append(element)
        siftUp(elements.count - 1)
        return true
    }
    
    public mutating func dequeue() -> E? {
        guard !elements.isEmpty else { return nil }
        
        elements.swapAt(0, elements.count - 1)
        
        defer {
            siftDown(0)
        }
        return elements.removeLast()
    }
    
    public func peek() -> E? {
        return elements.first
    }
}

extension BinaryHeap where E : Comparable {
    
    public init<S : Sequence>(_ elements: S, asMaxHeap: Bool = true) where S.Element == E {
        if asMaxHeap {
            self.init(elements, isHigherPriorityThan: >)
        } else {
            self.init(elements, isHigherPriorityThan: <)
        }
    }
    
    public init(asMaxHeap: Bool = true) {
        self.init([], asMaxHeap: asMaxHeap)
    }
}
