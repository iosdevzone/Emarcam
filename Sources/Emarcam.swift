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
    /// Converts a plain ol' integer index into a `String.IndexType`.
    ///
    /// - parameters:
    ///   - i: a zero-based character index into this string.
    ///   - returns: a String.IndexType for the same character position.
    public func index(_ i: Int) -> IndexType {
        return self.index(self.startIndex, offsetBy: i)
    }
}

//// Xcode 8/Swift 3 could not use :FixedWidthInteger
//extension CountableRange where Bound == Int {
//    func relative(to s: String) -> Range<String.IndexType> {
//        return s.index(self.lowerBound)..<s.index(self.upperBound)
//    }
//}
//
//// Xcode 8/ Swift 3 could not use :FixedWidthInteger
//extension CountableClosedRange where Bound == Int {
//    func relative(to s: String) -> ClosedRange<String.IndexType> {
//        return s.index(self.lowerBound)...s.index(self.upperBound)
//    }
//}

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
    
    
    #if swift(>=4)
    /// Inserts the contents of sequence at a given index in this string.
    /// - Parameters:
    ///     - newElement: the character to be added
    ///     - i: an index into the string 0 <= i <= self.count
    ///
    public mutating func insert<S>(contentsOf: S, at i: Int) where S:Collection, S.Element == Character {
        self.insert(contentsOf: contentsOf, at: self.index(i))
    }
    #else
    /// Inserts the contents of sequence at a given index in this string.
    /// - Parameters:
    ///     - newElement: the character to be added
    ///     - i: an index into the string 0 <= i <= self.count
    ///
    public mutating func insert<S>(contentsOf: S, at i: Int) where S:Collection, S.Iterator.Element == Character {
        self.insert(contentsOf: contentsOf, at: self.index(i))
    }
    #endif
    
    #if swift(>=4)
    // MARK: - Replacing Substrings
    /// Replaces a range of characters in this string with a given sequence.
    /// - Parameters:
    ///     - subrange: the range of characters to be replaced
    ///     - newElements: the replacement sequence
    ///
    public mutating func replaceSubrange<C>(
        _ subrange: CountableRange<Int>, with newElements:C)
    where C : Collection, Character == C.Element {
        replaceSubrange(self.index(subrange.lowerBound)..<self.index(subrange.upperBound), with: newElements)
    }
    #else
    // MARK: - Replacing Substrings
    /// Replaces a range of characters in this string with a given sequence.
    /// - Parameters:
    ///     - subrange: the range of characters to be replaced
    ///     - newElements: the replacement sequence
    ///
    public mutating func replaceSubrange<C>(_ subrange: CountableRange<Int>, with newElements:C)
        where C : Collection, Character == C.Iterator.Element {
        replaceSubrange(self.index(subrange.lowerBound)..<self.index(subrange.upperBound), with: newElements)
    }
    #endif
    
    #if swift(>=4)
    /// Replaces a closed range of characters in this string with a given sequence.
    /// - Parameters:
    ///     - subrange: the range of characters to be replaced
    ///     - newElements: the replacement sequence
    ///
    public mutating func replaceSubrange<C>(_ subrange: CountableClosedRange<Int>, with newElements:C)
        where C : Collection, Character == C.Element {
        return replaceSubrange(self.index(subrange.lowerBound)...self.index(subrange.upperBound), with: newElements)
    }
    #else
    /// Replaces a closed range of characters in this string with a given sequence.
    /// - Parameters:
    ///     - subrange: the range of characters to be replaced
    ///     - newElements: the replacement sequence
    ///
    public mutating func replaceSubrange<C>(_ subrange: CountableClosedRange<Int>, with newElements:C)
        where C : Collection, Character == C.Iterator.Element {
        return replaceSubrange(self.index(subrange.lowerBound)...self.index(subrange.upperBound), with: newElements)
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
    /// Removes a closed range of characters from this string
    /// - Parameters:
    /// - subrange: the index of the character to be removed
    public mutating func removeSubrange(_ subrange: CountableClosedRange<Int>) {
            return removeSubrange(self.index(subrange.lowerBound)...self.index(subrange.upperBound))
    }
    /// Removes a range of characters from this string
    /// - Parameters:
    /// - subrange: the index of the character to be removed
    public mutating func removeSubrange(_ subrange: CountableRange<Int>) {
            return removeSubrange(self.index(subrange.lowerBound)..<self.index(subrange.upperBound))
    }
    


    // MARK: - Subcripting
    public subscript(index: Int) -> Character {
        return self[self.index(index)]
    }
    
    public subscript(bounds: CountableClosedRange<Int>) -> SubstringType {
        return self[self.index(bounds.lowerBound)...self.index(bounds.upperBound)]
    }
    
    public subscript(bounds: CountableRange<Int>) -> SubstringType {
        return self[self.index(bounds.lowerBound)..<self.index(bounds.upperBound)]
    }
    
    
    #if swift(>=4)
    // MARK: - Swift 4 partial ranges
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
    
    
    #if !swift(>=4)
    // MARK: - Utility (Backported)
    /// The number of characters in this string.
    public var count: Int {
        return self.characters.count
    }
    
    // MARK: - Mutating Removal (Backported)
    /// Removes and returns the first character of this string.
    /// - returns: the removed character.
    @discardableResult public mutating func removeFirst() -> Character {
        return self.remove(at: self.startIndex)
    }
    
    /// Removes a number of characters from the beginning of this string.
    /// - Parameters:
    ///     - n: the number of characters to remove
    public mutating func removeFirst(_ n: Int) {
        let r = 0..<n
        self.removeSubrange(self.index(r.lowerBound)..<self.index(r.upperBound))
    }
    
    /// Removes a number of characters from the end of this string.
    /// - Parameters:
    ///     - n: the number of characters to remove
    public mutating func removeLast(_ n: Int) {
        let r = (self.count - n)..<self.count
        self.removeSubrange(self.index(r.lowerBound)..<self.index(r.upperBound))
    }
    
    /// Removes the last character from this string.
    /// - Returns: the removed character
    @discardableResult public mutating func removeLast() -> Character {
        let lastIndex = self.index(before:self.endIndex)
        let last = self[lastIndex]
        self.remove(at: lastIndex)
        return last
    }
    
    // MARK: - Non-mutating Removal (Backported)
    /// Returns the string obtained by removing the first character of this string
    /// - Returns: the substring of characters after the first character.
    public func dropFirst() -> SubstringType {
        return self[1..<self.count]
    }
    /// Returns the string obtained by removing the first `n` characters of this string.
    /// - Parameters:
    ///   - n: the number of characters to remove.
    ///   - - Returns: the substring of characters after the first `n` character.
    public func dropFirst(_ n: Int) -> SubstringType {
        return self[n..<self.count]
    }
    /// Returns the string obtained by removing the last character of this string
    /// - Returns: the substring of characters containing all but the last.
    public func dropLast() -> SubstringType {
        return self[0..<(self.count-1)]
    }
    /// Returns the string obtained by removing the last `n` characters of this string.
    /// - Parameters:
    ///   - n: the number of characters to remove.
    ///   - - Returns: the substring of characters before the last `n` character.
    public func dropLast(_ n: Int) -> SubstringType {
        return self[0..<(self.count-n)]
    }
    #endif
}
