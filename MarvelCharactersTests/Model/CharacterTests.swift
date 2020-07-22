//
//  CharacterTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterTests: XCTestCase {
    func testGetImageUrlWhenTheUrlIsNotHttps() {
        let character = Character.mockWithHttpUrl()
        let expectedValue = URL(string: "https://xxxx.jpg")

        XCTAssertEqual(character.thumbnail.getImageUrl(), expectedValue!)
    }

    func testGetImageUrlWhenTheUrlIsAlreadyHttps() {
        let character = Character.mockWithHttpsUrl()
        let expectedValue = URL(string: "https://xxxx.jpg")

        XCTAssertEqual(character.thumbnail.getImageUrl(), expectedValue!)
    }

    func testGetImageUrlWhenTheUrlIsNil() {
        let character = Character.mockWithNilUrl()
        XCTAssertEqual(character.thumbnail.getImageUrl(), nil)
    }

    func testSetFavoriteWithFalseValue() {
        var character = Character.mockWithHttpUrl()
        character.setFavorite(false)

        XCTAssertEqual(character.favorite, false)
    }

    func testSetFavoriteWithTrueValue() {
        var character = Character.mockWithHttpUrl()
        character.setFavorite(true)

        XCTAssertEqual(character.favorite, true)
    }

}
