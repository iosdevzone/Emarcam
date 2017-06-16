//
//  Emarcam.swift
//  Emarcam
//
//  Created by idz on 6/14/17.
//  Copyright © 2017 iOS Developer Zone. All rights reserved.
//

import Foundation



extension String {
    #if swift(>=4)
    public typealias SubstringType = Substring
    public typealias IndexType = String.Index
    #else
    public typealias SubstringType = String
    public typealias IndexType = String.CharacterView.Index
    #endif
    
    public func index(_ i: Int) -> IndexType {
        return self.index(self.startIndex, offsetBy: i)
    }
}

// Xcode 8/Swift 3 could not use :FixedWidthInteger
extension CountableRange where Bound == Int {
    func relative(to s: String) -> Range<String.IndexType> {
        return s.index(self.lowerBound)..<s.index(self.upperBound)
    }
}

// Xcode 8/ Swift 3 could not use :FixedWidthInteger
extension CountableClosedRange where Bound == Int {
    func relative(to s: String) -> ClosedRange<String.IndexType> {
        return s.index(self.lowerBound)...s.index(self.upperBound)
    }
}



extension String {

//    public func index<I:FixedWidthInteger>(_ i: I) -> IndexType {
//        return self.index(self.startIndex, offsetBy: Int(i))
//    }


    // MARK: - Inserting Characters
    
    /// Inserts a new element at a given index in this string.
    /// - Parameters:
    ///     - newElement: the character to be added
    ///     - i: an index into the string 0 <= i <= self.count
    ///
    public mutating func insert(_ newElement: Character, at i: Int) {
        self.insert(newElement, at: self.index(i))
    }
    
    /// Inserts the contents of sequence at a given index in this string.
    /// - Parameters:
    ///     - newElement: the character to be added
    ///     - i: an index into the string 0 <= i <= self.count
    ///
    #if swift(>=4)
    public mutating func insert<S>(contentsOf: S, at i: Int) where S:Collection, S.Element == Character {
        self.insert(contentsOf: contentsOf, at: self.index(i))
    }
    #else
    public mutating func insert<S>(contentsOf: S, at i: Int) where S:Collection, S.Iterator.Element == Character {
        self.insert(contentsOf: contentsOf, at: self.index(i))
    }
    #endif
    // MARK: - Replacing Substrings
    /// Replaces a range of characters in this string with a given sequence.
    /// - Parameters:
    ///     - subrange: the range of characters to be replaced
    ///     - newElements: the replacement sequence
    ///
    #if swift(>=4)
    public mutating func replaceSubrange<C>(
        _ subrange: CountableRange<Int>, with newElements:C)
    where C : Collection, Character == C.Element {
        replaceSubrange(subrange.relative(to: self), with: newElements)
    }
    #else
    public mutating func replaceSubrange<C>(_ subrange: CountableRange<Int>, with newElements:C)
        where C : Collection, Character == C.Iterator.Element {
        replaceSubrange(subrange.relative(to: self), with: newElements)
    }
    #endif
    /// Replaces a closed range of characters in this string with a given sequence.
    /// - Parameters:
    ///     - subrange: the range of characters to be replaced
    ///     - newElements: the replacement sequence
    ///
    #if swift(>=4)
    public mutating func replaceSubrange<C>(_ subrange: CountableClosedRange<Int>, with newElements:C)
        where C : Collection, Character == C.Element {
        return replaceSubrange(subrange.relative(to: self), with: newElements)
    }
    #else
    public mutating func replaceSubrange<C>(_ subrange: CountableClosedRange<Int>, with newElements:C)
        where C : Collection, Character == C.Iterator.Element {
        return replaceSubrange(subrange.relative(to: self), with: newElements)
    }
    #endif
    
    // MARK: - Removing Substrings
    /// Removes a character at a given index and returns the character
    /// - Parameters:
    /// - at: the index of the character to be removed
    /// - returns: the removed character
    @discardableResult public mutating func remove(at: Int) -> Character {
        return remove(at: self.index(at))
    }
    
    #if !swift(>=4)

    
    @discardableResult public mutating func removeFirst() -> Character {
        return self.remove(at: self.startIndex)
    }
    
    /// Removes a number of characters from this string.
    /// - Parameters:
    ///     - n: the number of characters to remove
    public mutating func removeFirst(_ n: Int) {
        let r = 0..<n
        self.removeSubrange(r.relative(to: self))
    }
    
    /// Removes the last character from this string.
    /// - Returns: the removed character
    @discardableResult public mutating func removeLast() -> Character {
        let lastIndex = self.index(before:self.endIndex)
        let last = self[lastIndex]
        self.remove(at: lastIndex)
        return last
    }
    
    public func characterCount() -> Int {
        return self.characters.count
    }
    
    public func dropFirst() -> SubstringType {
        return self[1..<self.characterCount()]
    }
    
    public func dropFirst(_ n: Int) -> SubstringType {
        return self[n..<self.characterCount()]
    }
    
    public func dropLast() -> SubstringType {
        return self[0..<(self.characterCount()-1)]
    }
    
    public func dropLast(_ n: Int) -> SubstringType {
        return self[0..<(self.characterCount()-n)]
    }
    #endif

    // MARK: - Subcripting
    public subscript(index: Int) -> Character {
        return self[self.index(index)]
    }
    
    public subscript(bounds: CountableClosedRange<Int>) -> SubstringType {
        return self[bounds.relative(to: self)]
    }
    
    public subscript(bounds: CountableRange<Int>) -> SubstringType {
        return self[bounds.relative(to: self)]
    }
    
    // MARK: - Swift 4 partial ranges
    #if swift(>=4)
    public subscript(bounds: PartialRangeUpTo<Int>) -> Substring {
        return self[..<self.index(bounds.upperBound)]
    }
    
    public subscript(bounds: PartialRangeThrough<Int>) -> Substring {
        return self[...self.index(bounds.upperBound)]
    }
    
    public subscript(bounds: PartialRangeFrom<Int>) -> Substring {
        return self[self.index(bounds.lowerBound)...]
    }
    #endif
}
