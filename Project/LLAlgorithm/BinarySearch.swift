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
        case notFound(expected: Index)
    }
}

public typealias ElementComparator<E> = (E, E) throws -> ComparisonResult

func reversed<E>(_ comparator: @escaping ElementComparator<E>) -> ElementComparator<E> {
    return { try comparator($1, $0) }
}

extension Comparable {
    
    static func comparator(ascending: Bool = true) -> ElementComparator<Self> {
        
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
    
    public func sorted(using comparator: ElementComparator<Self.Element>) rethrows -> [Self.Element] {
        return try withoutActuallyEscaping(comparator) { (escaped) -> [Self.Element] in
            return try self.sorted(by: { (lhs, rhs) -> Bool in
                return try escaped(lhs, rhs) == .orderedAscending
            })
        }
    }
}

extension RandomAccessCollection {
    
    public func binarySearch(_ element: Element, equalPosition: BinarySearching.EqualPosition = .any, usingComparator comparator: ElementComparator<Element>) rethrows -> BinarySearching.Result<Index> {
        
        var range = startIndex..<endIndex
        
        var found: Index?
        
        searching: while !range.isEmpty {
            let mid = index(range.lowerBound, offsetBy: self.distance(from: range.lowerBound, to: range.upperBound) / 2)
            
            switch try comparator(self[mid], element) {
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
            return .notFound(expected: range.lowerBound)
        }
    }
}

extension RandomAccessCollection where Element : Comparable {
    
    public func binarySearch(_ element: Element, equalPosition: BinarySearching.EqualPosition = .any, ascending: Bool = true) -> BinarySearching.Result<Index> {
        
        return try! binarySearch(element, equalPosition: equalPosition, usingComparator: Element.comparator(ascending: ascending))
    }
}

extension BinarySearching.Result {
    
    public var found: Index? {
        switch self {
        case .found(let idx):
            return idx
        default:
            return nil
        }
    }
    
    public var insertion: Index {
        switch self {
        case .found(let idx):
            return idx
        case .notFound(let expected):
            return expected
        }
    }
}


