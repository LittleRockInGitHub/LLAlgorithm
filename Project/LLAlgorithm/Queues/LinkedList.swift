//
//  LinkedList.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public final class LinkedList<E>: BidirectionalCollection, RangeReplaceableCollection, MutableCollection, CustomStringConvertible, NSCopying {
    
    public typealias Index = Int
    
    class Node {
        var element: E!
        
        var previous: Node! {
            didSet {
                if previous.next !== self {
                    previous.next = self
                }
            }
        }
        
        weak var next: Node! {
            didSet {
                if next.previous !== self {
                    next.previous = self
                }
            }
        }
        
        init(_ element: E) {
            self.element = element
        }
        
        init() {
            self.element = nil
        }
        
        func node(offset: Int) -> Node {
            if offset > 0 {
                var node = self
                for _ in 0..<offset {
                    node = node.next
                }
                return node
            } else if offset < 0 {
                var node = self
                for _ in 0..<(-offset) {
                    node = node.previous
                }
                return node
            } else {
                return self
            }
        }
        
        static func nodes<C: Collection>(_ c: C) -> (Node, Node, Int) where C.Element == E {
            
            precondition(!c.isEmpty)
            
            if let list = c as? LinkedList<E>  {
                return (list.head.next, list.tail.previous, list.count)
            } else {
            
                var count = 1
                let start = Node()
                start.element = c.first!
                
                var end = start
                for e in c.dropFirst() {
                    let node = Node(e)
                    end.next = node
                    end = end.next
                    count += 1
                }
                
                return (start, end, count)
            }
        }
    }
    
    var head: Node
    
    var tail: Node
    
    private(set) public var count: Int = 0
    
    public required init() {
        let head = Node()
        let tail = Node()
        
        head.next = tail
        
        self.head = head
        self.tail = tail
    }
    
    public convenience init<C : Collection>(_ elements: C) where C.Element == E {
        self.init()
        
        self.replaceSubrange(0..<0, with: elements)
    }
    
    public var startIndex: Int { return 0 }
    
    public var endIndex: Int { return count }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public subscript(index: Int) -> E {
        get {
            precondition((startIndex..<endIndex).contains(index))
            return node(at: index).element
        }
        set {
            precondition((startIndex..<endIndex).contains(index))
            node(at: index).element = newValue
        }
    }
    
    private func node(at index: Int) -> Node {
        
        if index < count / 2 {
            return head.node(offset: index + 1)
        } else {
            return tail.node(offset: index - count)
        }
    }
    
    private func nodes(at range: Range<Int>) -> (head: Node, tail: Node) {
        
        return (head: node(at: range.lowerBound), tail: node(at: range.upperBound))
    }
    
    public func index(before i: Int) -> Int {
        return i - 1
    }
    
    public func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, E == C.Element, LinkedList.Index == R.Bound {
        
        let range = subrange.relative(to: self)
        
        let gap = nodes(at: range)
        
        count -= range.count
        
        if newElements.isEmpty {
            gap.head.previous.next = gap.tail
        } else {
            let (head, tail, added) = Node.nodes(newElements)
            gap.head.previous.next = head
            gap.tail.previous = tail
            
            count += added
        }
    }
    
    public var description: String {
        
        if E.self is CustomStringConvertible.Type {
            return "[" + self.map({ ($0 as! CustomStringConvertible).description }).joined(separator: " -> ") + "]"
        } else {
            return "[count: \(count)]"
        }
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        var reval = LinkedList<E>()
        
        for v in self {
            reval.append(v)
        }
        
        return reval
    }
}
