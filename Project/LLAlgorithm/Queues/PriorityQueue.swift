//
//  PriorityQueue.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public protocol PriorityQueue : AbstractQueue {
    
    func isHigherPriority(_ lhs: Element, than rhs: Element) -> Bool
    
}
