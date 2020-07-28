//
//  ErrorCellTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

class ErrorCellTests: XCTestCase {
    private var sut: ErrorCell!

    override func setUp() {
        super.setUp()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 114)

        sut = ErrorCell()
        sut.frame = frame
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testErrorCellLayout() {
        expect(self.sut).to(haveValidSnapshot())
    }
}
