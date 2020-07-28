//
//  CharacterCellTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 28/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

class CharacterCellTests: XCTestCase {
    private var sut: CharacterCell!

    override func setUp() {
        super.setUp()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: CharacterCell.heightRow)
        sut = CharacterCell()
        sut.frame = frame
    }

    func testCharacterCellLayout() {
        sut.setup(character: .mockWithHttpsUrl(), indexPath: nil)
        expect(self.sut).to(haveValidSnapshot())
    }

    func testCharacterCellLayoutWhenItHasNoDescription() {
        sut.setup(character: .mockWithHttpUrl(), indexPath: nil)
        expect(self.sut).to(haveValidSnapshot())
    }
}
