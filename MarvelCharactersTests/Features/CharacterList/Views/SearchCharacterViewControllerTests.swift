//
//  SearchCharacterViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

class SearchCharacterViewControllerTests: XCTestCase {
    private var sut: SearchCharacterViewController!
    private var presenter: SearchCharacterPresenter!
    private var stubService: CharacterListServiceStub!
    private var window: UIWindow!

    private func setup(withError error: ServiceError?) {
        stubService = CharacterListServiceStub()
        stubService.shouldReturnsError = error
        presenter = SearchCharacterPresenter(service: stubService)

        sut = SearchCharacterViewController(presenter: presenter)
        presenter.view = sut

        let search = UISearchController(searchResultsController: sut)
        search.searchResultsUpdater = sut

        if error == nil {
            search.searchBar.searchTextField.text = "A"
        }

        sut.updateSearchResults(for: search)

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = sut
        window.makeKeyAndVisible()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        presenter = nil
        stubService = nil
        window = nil
    }

    func testSearchChracterViewControllerLayout() {
        setup(withError: nil)
        expect(self.sut).to(haveValidSnapshot())
    }

    func testSearchChracterViewControllerNoConnectionLayout() {
        setup(withError: .noInternetConnection)
        expect(self.sut).to(haveValidSnapshot())
    }

    func testSearchChracterViewControllerGenericErrorLayout() {
        setup(withError: .unexpected)
        expect(self.sut).to(haveValidSnapshot())
    }

    func testSearchChracterViewControllerLoadingLayout() {
        setup(withError: .cancelRequest)
        expect(self.sut).to(haveValidSnapshot())
    }
}
