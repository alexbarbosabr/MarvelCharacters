//
//  LoadingViewTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

final class LoadingViewTests: XCTestCase {
    private var sut: LoadingView!

    override func setUp() {
        super.setUp()
        sut = LoadingView(frame: UIScreen.main.bounds)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testLoadingViewStartLayout() {
        expect(self.sut).to(haveValidSnapshot())
    }

    func testLoadingViewLayoutStop() {
        sut.stop()
        expect(self.sut).to(haveValidSnapshot())
    }

}
