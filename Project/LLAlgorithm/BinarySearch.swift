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

public typealias Comparator<E> = (E, E) -> ComparisonResult

extension Comparable {
    
    public static var comparator: Comparator<Self> {
        return { (lhs: Self, rhs: Self) -> ComparisonResult in
            if lhs < rhs {
                return .orderedAscending
            } else if lhs > rhs {
                return .orderedDescending
            } else {
                return .orderedSame
            }
        }
    }
}

extension Collection {
    
    public func isSorted(usingComparator: Comparator<Element>) -> Bool {
        return false
    }
}

extension Collection where Element : Comparable {
    
    public func isSorted() -> Bool {
        return isSorted(usingComparator: Element.comparator)
    }
}

extension RandomAccessCollection where SubSequence : RandomAccessCollection {
    
    public func binarySearch(_ element: Element, equalPosition: BinarySearching.EqualPosition = .any, usingComparator comparator: Comparator<Element>) -> BinarySearching.Result<Index> {
        
        guard !isEmpty else { return .notFound(insertion: startIndex) }
        
        let midIdx = index(startIndex, offsetBy: count / 2)
        let mid = self[midIdx]
        
        switch comparator(mid, element) {
        case .orderedSame:
            let result = BinarySearching.Result<Index>.found(midIdx)
            switch equalPosition {
            case .any:
                return result
            case .first:
                if case let .found(idx) = self[..<midIdx].binarySearch(element, equalPosition: equalPosition, usingComparator: comparator) {
                    return .found(idx)
                } else {
                    return result
                }
            case .last:
                if case let .found(idx) = self[index(after: midIdx)...].binarySearch(element, equalPosition: equalPosition, usingComparator: comparator) {
                    return .found(idx)
                } else {
                    return result
                }
            }
        case .orderedAscending:
            return self[index(after: midIdx)...].binarySearch(element, equalPosition: equalPosition, usingComparator: comparator)
        case .orderedDescending:
            return self[..<midIdx].binarySearch(element, equalPosition: equalPosition, usingComparator: comparator)
        }
    }
}

extension RandomAccessCollection where Element : Comparable, SubSequence : RandomAccessCollection {
    
    public func binarySearch(_ element: Element, equalPosition: BinarySearching.EqualPosition = .any) -> BinarySearching.Result<Index> {
        
        return binarySearch(element, equalPosition: equalPosition, usingComparator: Element.comparator)
    }
}

