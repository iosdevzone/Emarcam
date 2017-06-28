//
//  EmarcamTests.swift
//  EmarcamTests
//
//  Created by idz on 6/14/17.
//  Copyright © 2017 iOS Developer Zone. All rights reserved.
//

import XCTest
@testable import Emarcam

class EmarcamTests: XCTestCase {
    
    static var allTests = { 
	    return [
	    ("testCharacterInsertion",testCharacterInsertion),
	    ("testSequenceInsertion",testSequenceInsertion),
	    ("testCountableRangeReplacement",testCountableRangeReplacement),
	    ("testRemoveAt",testRemoveAt),
	    ("testRemoveFirstN",testRemoveFirstN),
	    ("testRemoveLastN",testRemoveLastN),
	    ("testDropFirstN",testDropFirstN),
	    ("testDropLastN",testDropLastN),
	    ("testIndex",testIndex),
	    ("testCountableClosedRange",testCountableClosedRange),
	    ("testCountableRange",testCountableRange),
//	    ("testPartialRangeUpTo",testPartialRangeUpTo),
//	    ("testPartialRangeUpThrough",testPartialRangeUpThrough),
//	    ("testPartialRangeFrom",testPartialRangeFrom)
	    ]

	}()
    let testStrings = [
        "The quick brown fox jumped over the lazy dog.",
        "おやすみなさい",
        "🇮🇪🇯🇵",
        "私のホバークラフトはうなぎで満たされています。"]
    let insertion: Character = "🇺🇸"
    
    #if swift(>=4)
    let sequence: [Character] = "내 호버크라프트는 뱀장어로 가득하다.".map { $0 }
    #else
    let sequence: [Character] = "내 호버크라프트는 뱀장어로 가득하다.".characters.map { $0 }
    #endif
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // MARK: - Insertion
    func testCharacterInsertion() {
        for s in testStrings {
            for i in 0..<s.count {
                var ms1 = s
                var ms2 = s
                ms1.insert(insertion, at:i)
                ms2.insert(insertion, at:s.index(s.startIndex, offsetBy: i))
                XCTAssertEqual(ms1, ms2)
            }
        }
    }
    
    func testSequenceInsertion() {
        for s in testStrings {
            for i in 0..<s.count {
                var ms1 = s
                var ms2 = s
                ms1.insert(contentsOf: sequence, at:i)
                ms2.insert(contentsOf: sequence, at:s.index(s.startIndex, offsetBy: i))
                XCTAssertEqual(ms1, ms2)
            }
        }
    }
    
    func rangeWrapper(assertion: (String, Int, Int) -> Void) {
        for s in testStrings {
            for i in 0..<s.count {
                for j in i..<s.count {
                    assertion(s, i, j)
                }
            }
        }
    }
    
    // MARK: - Replacing Substrings
    func testCountableRangeReplacement() {
        rangeWrapper { (s, i, j) in
            var ms1 = s
            var ms2 = s
            ms1.replaceSubrange(i..<j, with: sequence)
            ms2.replaceSubrange(s.index(s.startIndex, offsetBy: i)..<s.index(s.startIndex, offsetBy: j), with: sequence)
            XCTAssertEqual(ms1, ms2)
        }
    }
    
    func testCountableClosedRangeReplacement() {
        rangeWrapper { (s, i, j) in
            var ms1 = s
            var ms2 = s
            ms1.replaceSubrange(i...j, with: sequence)
            ms2.replaceSubrange(s.index(s.startIndex, offsetBy: i)...s.index(s.startIndex, offsetBy: j), with: sequence)
            XCTAssertEqual(ms1, ms2)
        }
    }
    
    // MARK: - Removing Characters
    func testRemoveAt() {
        for s in testStrings {
            for i in 0..<s.count {
                var ms1 = s
                var ms2 = s
                let c1 = ms1.remove(at: i)
                let c2 = ms2.remove(at: s.index(s.startIndex, offsetBy: i))
                XCTAssertEqual(ms1, ms2)
                XCTAssertEqual(c1, c2)
            }
        }
    }
    
    func testCountableRangeRemoval() {
        rangeWrapper { (s, i, j) in
            var ms1 = s
            var ms2 = s
            ms1.removeSubrange(i..<j)
            ms2.removeSubrange(s.index(s.startIndex, offsetBy: i)..<s.index(s.startIndex, offsetBy: j))
            XCTAssertEqual(ms1, ms2)
        }
    }
    
    func testCountableClosedRangeRemoval() {
        rangeWrapper { (s, i, j) in
            var ms1 = s
            var ms2 = s
            ms1.removeSubrange(i...j)
            ms2.removeSubrange(s.index(s.startIndex, offsetBy: i)...s.index(s.startIndex, offsetBy: j))
            XCTAssertEqual(ms1, ms2)
        }
    }
    
    func testRemoveFirst() {
        var s = "123456"
        let c = s.removeFirst()
        XCTAssertEqual(c, Character("1"))
        XCTAssertEqual(s, "23456")
    }
    
    func testRemoveFirstN() {
        var s = "123456"
        s.removeFirst(3)
        XCTAssertEqual(s, "456")
    }
    
    func testRemoveLastN() {
        var s = "123456"
        s.removeLast(3)
        XCTAssertEqual(s, "123")
    }
    
    func testRemoveLast() {
        var s = "123456"
        let c = s.removeLast()
        XCTAssertEqual(c, Character("6"))
        XCTAssertEqual(s, "12345")
    }
    
    func testDropFirst() {
        let s = "123456"
        let r = s.dropFirst()
        XCTAssertEqual(r, "23456")
    }
    
    func testDropFirstN() {
        let s = "123456"
        let t = s.dropFirst(3)
        XCTAssertEqual(s, "123456")
        XCTAssertEqual(t, "456")
    }
    
    func testDropLastN() {
        let s = "123456"
        let t = s.dropLast(3)
        XCTAssertEqual(s, "123456")
        XCTAssertEqual(t, "123")
    }
    
    func testDropLast() {
        let s = "123456"
        let r = s.dropLast()
        XCTAssertEqual(r, "12345")
    }
    
    // MARK: - Subscripting
    func testIndex() {
        for s in testStrings {
            for i in 0..<s.count {
                XCTAssertEqual(s[i], s[s.index(s.startIndex, offsetBy: i)])
            }
        }
    }
    
    func testCountableClosedRange() {
        rangeWrapper { (s, i, j) in
            XCTAssertEqual(s[i...j], s[s.index(s.startIndex, offsetBy: i)...s.index(s.startIndex, offsetBy: j)])
        }
    }
    
    func testCountableRange() {
        rangeWrapper { (s, i, j) in
            XCTAssertEqual(s[i..<j], s[s.index(s.startIndex, offsetBy: i)..<s.index(s.startIndex, offsetBy: j)])
        }
    }
    
    #if swift(>=4)
    func testPartialRangeUpTo() {
        for s in testStrings {
            for i in 0...s.count {
                XCTAssertEqual(s[..<i], s[..<s.index(s.startIndex, offsetBy: i)])
            }
        }
    }

    func testPartialRangeUpThrough() {
        for s in testStrings {
            for i in 0..<s.count {
                XCTAssertEqual(s[...i], s[...s.index(s.startIndex, offsetBy: i)])
            }
        }
    }
    
    func testPartialRangeFrom() {
        for s in testStrings {
            for i in 0..<s.count {
                XCTAssertEqual(s[i...], s[s.index(s.startIndex, offsetBy: i)...])
            }
        }
    }
    #endif
}
