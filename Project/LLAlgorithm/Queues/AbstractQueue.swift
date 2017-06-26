//
//  AbstractQueue.swift
//  LLAlgorithm
//
//  Created by Rock Young on 2017/6/26.
//  Copyright © 2017年 Rock Young. All rights reserved.
//

import Foundation

public protocol AbstractQueue {
    
    associatedtype Elements : Collection
    
    var elements: Elements { get }
    
    var isEmpty: Bool { get }
    
    var count: Elements.IndexDistance { get }
    
    @discardableResult
    mutating func enqueue(_ element: Elements.Element) -> Bool
    
    mutating func dequeue() -> Elements.Element?
    
    func peek() -> Elements.Element?
}

extension AbstractQueue {
    
    public var isEmpty: Bool { return elements.isEmpty }
    
    public var count: Elements.IndexDistance { return elements.count }
}
