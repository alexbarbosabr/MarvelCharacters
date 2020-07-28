//
//  SearchCharacterPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class SearchCharacterPresenterTests: XCTestCase {
    private var sut: SearchCharacterPresenter!
    private var stubService: CharacterListServiceStub!
    private var spyView: SearchCharacterViewControllerSpy!
    private let characterName = "Thanos"

    override func setUp() {
        super.setUp()
        stubService = CharacterListServiceStub()
        spyView = SearchCharacterViewControllerSpy()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        stubService = nil
        spyView = nil
    }

    // MARK: - Success
    func testFetchCharacterSuccessully() {
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowError)
    }

    func testFetchCharacterWhenReturnEmptyListSuccessully() {
        stubService.shouldReturnsEmptyList = true
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssert(spyView.hasCalledShowEmptyCharacters)
        XCTAssertFalse(spyView.hasCalledShowError)
    }

    // MARK: - Favorites
    func testUpdateCharactersWhenSetFavoriteInOtherContext() {
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        sut.updateCharactersWhenSetFavoriteInOtherContext()

        XCTAssert(spyView.hasCalledShowCharacters)
    }

    func testSetFavoriteWhenIsTrueValue() {
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        let index = IndexPath(row: 0, section: 0)
        sut.setFavorite(indexPath: index, isFavorite: true, imageData: nil)

        XCTAssert(spyView.hasCalledUpdateCell)
    }

    func testSetFavoriteWhenIsFalseValue() {
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        let index = IndexPath(row: 0, section: 0)
        sut.setFavorite(indexPath: index, isFavorite: false, imageData: nil)

        XCTAssert(spyView.hasCalledUpdateCell)
    }

    // MARK: - Error
    func testFetchCharacterWithError() {
        stubService.shouldReturnsError = .unexpected
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyCharacters)
        XCTAssert(spyView.hasCalledShowError)
    }

    func testFetchCharacterWithNoInternetError() {
        stubService.shouldReturnsError = .noInternetConnection
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: characterName)

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyCharacters)
        XCTAssert(spyView.hasCalledShowError)
    }

}
