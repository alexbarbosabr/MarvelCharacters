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

    // MARK: - Success
    func testFetchCharacterSuccessully() {
        stubService = CharacterListServiceStub()
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharacterWithoutLoadingScreenSuccessully() {
        stubService = CharacterListServiceStub()
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharacterWhenThereAreAlreadyARequestInProgressSuccessully() {
        stubService = CharacterListServiceStub()
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: true)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    // MARK: - Error
    func testFetchCharacterWithError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssert(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharacterWithNoInternetError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .noInternet
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssert(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharacterWhenThereAreAlreadyARequestInProgressWithError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: false)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssert(spyView.hasCalledShowErrorOnTableView)
    }

    func testPresenterWhenThereAreAlreadyARequestInProgressWithError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: false)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssert(spyView.hasCalledShowErrorOnTableView)
    }
}
