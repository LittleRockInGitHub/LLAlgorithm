//
//  LinkedList.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/26.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public final class LinkedList<Element>: BidirectionalCollection, RangeReplaceableCollection, MutableCollection, CustomStringConvertible, NSCopying {
    
    public typealias Index = Node
    
    public class Node : Comparable {
        
        var element: Element!
        
        weak var previous: Node! {
            didSet {
                if previous.next !== self {
                    previous.next = self
                }
            }
        }
        
        public static func <(lhs: Node, rhs: Node) -> Bool {
            var lhs = lhs
            while let n = lhs.next, n != rhs {
                lhs = n
            }
            
            return lhs.next != nil
        }
        
        public static func ==(lhs: Node, rhs: Node) -> Bool {
            return lhs === rhs
        }
        
        var next: Node! {
            didSet {
                if next.previous !== self {
                    next.previous = self
                }
            }
        }
        
        init(_ element: Element) {
            self.element = element
        }
        
        init() {
            self.element = nil
        }
        
        static func makeNodes<S: Sequence>(_ seq: S) -> (Node, Node)? where S.Element == Element {
            var itr = seq.makeIterator()
            
            let start = Node()
            var end = start
            while let next = itr.next() {
                end.next = Node(next)
                end = end.next
            }
            
            if start === end {
                return nil
            } else {
                return (start.next, end)
            }
        }
        
        static func nodes<C: Collection>(_ c: C) -> (Node, Node) where C.Element == Element {
            
            precondition(!c.isEmpty)
            
            if let list = c as? LinkedList<Element>  {
                return (list.head.next, list.tail.previous)
            } else {
                return makeNodes(c)!
            }
        }
    }
    
    private var head: Node
    
    private var tail: Node
    
    public required init() {
        let head = Node()
        let tail = Node()
        
        head.next = tail
        
        self.head = head
        self.tail = tail
    }
    
    public convenience init<S: Sequence>(_ seq: S) where S.Element == Element {
        self.init()
        
        if let (start, end) = Node.makeNodes(seq) {
            head.next = start
            tail.previous = end
        }
    }
    
    public var startIndex: Node { return head.next }
    
    public var endIndex: Node { return tail }
    
    public subscript(index: Node) -> Element {
        get {
            return index.element
        }
        set {
            index.element = newValue
        }
    }
    
    public func index(before node: Node) -> Node {
        return node.previous
    }
    
    public func index(after node: Node) -> Node {
        return node.next
    }
    
    public func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, C.Element == Element, LinkedList.Index == R.Bound {
        
        let indexRange = subrange.relative(to: self)
        
        if newElements.isEmpty {
            indexRange.lowerBound.previous.next = indexRange.upperBound
        } else {
            let (first, last) = Node.nodes(newElements)
            indexRange.lowerBound.previous.next = first
            indexRange.upperBound.previous = last
        }
    }
    
    public var description: String {
        
        if Element.self is CustomStringConvertible.Type {
            return "[" + self.map({ ($0 as! CustomStringConvertible).description }).joined(separator: " -> ") + "]"
        } else {
            return "[\(Element.self) count: \(count)]"
        }
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        return LinkedList(self)
    }
}
