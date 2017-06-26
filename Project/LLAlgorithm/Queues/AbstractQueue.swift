//
//  AbstractQueue.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public protocol AbstractQueue {
    
    associatedtype Element
    
    var isEmpty: Bool { get }
    
    @discardableResult
    mutating func enqueue(_ element: Element) -> Bool
    
    mutating func dequeue() -> Element?
    
    func peek() -> Element?
}
