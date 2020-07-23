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
    func testFetchCharactersSuccessully() {
        stubService = CharacterListServiceStub()
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharactersWhenThereAreNoCharactersSuccessully() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsEmptyList = true
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharactersWithoutLoadingScreenSuccessully() {
        stubService = CharacterListServiceStub()
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssertFalse(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharactersWhenThereAreAlreadyARequestInProgressSuccessully() {
        stubService = CharacterListServiceStub()
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView

        sut.fetchCharacters(showScreenLoading: true)
        sut.fetchCharacters(showScreenLoading: false)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    // MARK: - Error
    func testFetchCharactersWithError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .unexpected
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssert(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharactersWithNoInternetError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .noInternet
        sut = CharacterListPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacters(showScreenLoading: true)

        XCTAssert(spyView.hasCalledShowLoadingOnScreen)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssert(spyView.hasCalledShowErrorOnScreen)
        XCTAssertFalse(spyView.hasCalledShowErrorOnTableView)
    }

    func testFetchCharactersWhenThereAreAlreadyARequestInProgressWithError() {
        stubService = CharacterListServiceStub()
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
        XCTAssertFalse(spyView.hasCalledShowEmptyList)
        XCTAssertFalse(spyView.hasCalledShowErrorOnScreen)
        XCTAssert(spyView.hasCalledShowErrorOnTableView)
    }
}
