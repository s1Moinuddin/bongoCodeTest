//
//  BongoCodeTestTests.swift
//  BongoCodeTestTests
//
//  Created by S.M.Moinuddin on 11/2/21.
//

import XCTest
@testable import BongoCodeTest

class BongoCodeTestTests: XCTestCase {
    
    var sut: ViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        sut = ViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try super.tearDownWithError()
    }

    func testEveryFifthCharacter() throws {
        // given
        let txt = "TheQuickBrownFoxJumpsOverTheLazyDog"
        // when
        let str = sut.getEveryNthCharacter(from: txt, n:5)
        // then
        XCTAssertEqual(str, "u r o p r a g", "Characters in the string is right")
        
    }
    
    func testWordFrequency() throws {
        // given
        let txt = "Johny is a good boy. Good Johny respect others. A lovely boy!"
        // when
        let freqMap = sut.getFreqMap(txt)
        // then
        let expectedMap = ["a" : 2,
                          "lovely" : 1,
                          "respect" : 1,
                          "is" : 1,
                          "others" : 1,
                          "johny" : 2,
                          "boy" : 2,
                          "good" : 2]
        
        XCTAssertEqual(freqMap, expectedMap, "Word occurrence count is right")
    }


}
