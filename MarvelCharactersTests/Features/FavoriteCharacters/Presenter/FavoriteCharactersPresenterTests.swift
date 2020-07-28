//
//  FavoriteCharactersPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 28/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

final class FavoriteCharactersPresenterTests: XCTestCase {
    private var sut: FavoriteCharactersPresenter!
    private var spyView: FavoriteCharactersViewControllerSpy!

    override func setUp() {
        super.setUp()
        spyView = FavoriteCharactersViewControllerSpy()
    }

    private func setup(characters: [Character]) {
        sut = FavoriteCharactersPresenter(characters: characters)
        sut.view = spyView
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spyView = nil
    }

    // MARK: - Fetch
    func testFetchCharacters() {
        setup(characters: [.mockWithHttpsUrl()])
        sut.fetchCharacters()
        XCTAssert(spyView.hasCalledShowCharacters)
    }

    func testFetchCharactersWhenThereAreNoCharacters() {
        setup(characters: [Character]())
        sut.fetchCharacters()
        XCTAssert(spyView.hasCalledShowEmptyList)
    }

    // MARK: - Remove Favorite
    func testRemoveFavorite() {
        let index = IndexPath(row: 0, section: 0)
        let characters: [Character] = [.mockWithHttpsUrl(), .mockWithHttpsUrl()]
        setup(characters: characters)

        sut.removeFavorite(indexPath: index)

        XCTAssert(spyView.hasCalledShowCharacters)
    }

    func testRemoveFavoriteWhenItHasTheLastCharacter() {
        let index = IndexPath(row: 0, section: 0)
        let characters: [Character] = [.mockWithHttpsUrl()]
        setup(characters: characters)

        sut.removeFavorite(indexPath: index)

        XCTAssert(spyView.hasCalledShowEmptyList)
    }
}
