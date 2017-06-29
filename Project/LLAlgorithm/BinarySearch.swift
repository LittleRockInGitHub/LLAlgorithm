//
//  BinarySearch.swift
//  LLAlgorithm
//
//  Created by Rock Yang on 2017/6/29.
//  Copyright © 2017年 Rock Yang. All rights reserved.
//

import Foundation

public struct BinarySearching {
    
    public enum EqualPosition: Int {
        case any = 0
        case first = -1
        case last = 1
    }
    
    public enum Result<Index> {
        case found(Index)
        case notFound(insertion: Index)
    }
}

public typealias ElementComparator<E> = (E, E) -> ComparisonResult

public func reversed<E>(_ comparator: @escaping ElementComparator<E>) -> ElementComparator<E> {
    return { comparator($1, $0) }
}

extension Comparable {
    
    public static func comparator(ascending: Bool = true) -> ElementComparator<Self> {
        
        let forAscending = { (lhs: Self, rhs: Self) -> ComparisonResult in
            if lhs < rhs {
                return .orderedAscending
            } else if lhs > rhs {
                return .orderedDescending
            } else {
                return .orderedSame
            }
        }
        
        return ascending ? forAscending : reversed(forAscending)
    }
}

extension Collection {
    
    public func isSorted(usingComparator comparator: ElementComparator<Element>) -> Bool {
        guard !isEmpty else { return true }
        
        var element = first!
        for e in dropFirst() {
            guard comparator(element, e) != .orderedDescending else { return false }
            element = e
        }
        return true
    }
}

extension Collection where Element : Comparable {
    
    public func isSorted(ascending: Bool = true) -> Bool {
        return self.isSorted(usingComparator: Element.comparator(ascending: ascending))
    }
}

extension RandomAccessCollection {
    
    public func binarySearch(_ element: Element, equalPosition: BinarySearching.EqualPosition = .any, usingComparator comparator: ElementComparator<Element>) -> BinarySearching.Result<Index> {
        
        var range = startIndex..<endIndex
        
        var found: Index?
        
        searching: while !range.isEmpty {
            let mid = index(range.lowerBound, offsetBy: self.distance(from: range.lowerBound, to: range.upperBound) / 2)
            
            switch comparator(self[mid], element) {
            case .orderedSame:
                found = mid
                switch equalPosition {
                case .any:
                    break searching
                case .first:
                    range = range.lowerBound..<mid
                case .last:
                    range = index(after: mid)..<range.upperBound
                }
            case .orderedAscending:
                range = index(after: mid)..<range.upperBound
            case .orderedDescending:
                range = range.lowerBound..<mid
            }
        }
        
        if let found = found {
            return .found(found)
        } else {
            return .notFound(insertion: range.lowerBound)
        }
    }
}

extension RandomAccessCollection where Element : Comparable {
    
    public func binarySearch(_ element: Element, equalPosition: BinarySearching.EqualPosition = .any, ascending: Bool = true) -> BinarySearching.Result<Index> {
        
        return binarySearch(element, equalPosition: equalPosition, usingComparator: Element.comparator(ascending: ascending))
    }
}

