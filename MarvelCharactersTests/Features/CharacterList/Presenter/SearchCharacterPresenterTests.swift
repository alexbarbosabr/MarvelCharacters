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
    var sut: SearchCharacterPresenter!
    var stubService: CharacterListServiceStub!
    var spyView: SearchCharacterViewControllerSpy!

    override func setUp() {
        super.setUp()
        stubService = CharacterListServiceStub()
        spyView = SearchCharacterViewControllerSpy()
    }

    // MARK: - Success
    func testFetchCharacterSuccessully() {
        stubService = CharacterListServiceStub()
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: "Thanos")

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssert(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowError)
    }

    func testFetchCharacterWhenReturnEmptyListSuccessully() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsEmptyList = true
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: "Thannos")

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssert(spyView.hasCalledShowEmptyCharacters)
        XCTAssertFalse(spyView.hasCalledShowError)
    }

    // MARK: - Error
    func testFetchCharacterWithError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .unexpected
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: "Thanos")

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyCharacters)
        XCTAssert(spyView.hasCalledShowError)
    }

    func testFetchCharacterWithNoInternetError() {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = .noInternet
        sut = SearchCharacterPresenter(service: stubService)
        sut.view = spyView
        sut.fetchCharacter(name: "Thanos")

        XCTAssert(spyView.hasCalledShowLoading)
        XCTAssert(spyView.hasCalledShowHideLoading)
        XCTAssertFalse(spyView.hasCalledShowCharacters)
        XCTAssertFalse(spyView.hasCalledShowEmptyCharacters)
        XCTAssert(spyView.hasCalledShowError)
    }

}
