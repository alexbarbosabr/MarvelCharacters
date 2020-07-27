//
//  CharacterListPresenterTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterListPresenterTests: XCTestCase {
    var sut: CharacterListPresenter!
    var stubService: CharacterListServiceStub!
    var spyView: CharacterListViewControllerSpy!

    override func setUp() {
        super.setUp()
        stubService = CharacterListServiceStub()
        spyView = CharacterListViewControllerSpy()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        stubService = nil
        spyView = nil
    }

    // MARK: - Success
    func testFetchCharactersSuccessully() {
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    func testFetchCharactersWhenThereAreNoCharactersSuccessully() {
        stubService.shouldReturnsEmptyList = true
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    func testFetchCharactersWithoutLoadingScreenSuccessully() {
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    func testFetchCharactersWhenThereAreAlreadyARequestInProgressSuccessully() {
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: true)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    // MARK: - Favorite
    func testUpdateCharactersWhenSetFavoriteInOtherContext() {
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.updateCharactersWhenSetFavoriteInOtherContext()

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssert(spyView.hasCalledRefreshTable)
    }

    func testSetFavoriteWhenIsTrueValue() {
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        let index = IndexPath(row: 0, section: 0)
        sut.fetchCharacters(showScreenLoading: true)
        sut.setFavorite(indexPath: index, isFavorite: true, imageData: nil)

        XCTAssert(spyView.hasCalledUpdateCell)
    }

    func testSetFavoriteWhenIsFalseValue() {
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        let index = IndexPath(row: 0, section: 0)
        sut.fetchCharacters(showScreenLoading: true)
        sut.setFavorite(indexPath: index, isFavorite: false, imageData: nil)

        XCTAssert(spyView.hasCalledUpdateCell)
    }

    // MARK: - Error
    func testFetchCharactersWithError() {
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssert(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    func testFetchCharactersWithNoInternetError() {
        stubService.shouldReturnsError = .noInternet
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssert(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    func testFetchCharactersWhenThereAreAlreadyARequestInProgressWithError() {
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: false)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssert(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }

    func testPresenterWhenThereAreAlreadyARequestInProgressWithError() {
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: false)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssert(spyView.hasCalledShowErrorOnTableView)
        XCTAssertFalse(spyView.hasCalledRefreshTable)
    }
}
