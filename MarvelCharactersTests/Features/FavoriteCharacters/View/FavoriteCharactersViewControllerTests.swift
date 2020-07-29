//
//  FavoriteCharactersViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 27/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

final class FavoriteCharactersViewControllerTests: XCTestCase {
    private var sut: FavoriteCharactersViewController!
    private var mockPresenter: FavoriteCharactersPresenterMock!
    private var navigation: MarvelNavigationController!
    private var navigatorListener: FavoriteCharactersNavigatorListenerSpy!
    private var window: UIWindow!

    private func setup(withEmptyList isEmpty: Bool? = false) {
        let characterList = isEmpty! ? [Character]() : [.mockWithHttpsUrl()]
        mockPresenter = FavoriteCharactersPresenterMock(characters: characterList)
        navigatorListener = FavoriteCharactersNavigatorListenerSpy()

        sut = FavoriteCharactersViewController(presenter: mockPresenter, navigatorListener: navigatorListener)
        navigation = MarvelNavigationController(rootViewController: sut)
        mockPresenter.view = sut

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockPresenter = nil
        navigatorListener = nil
        window = nil
    }

    func testFavoriteCharactersLayout() {
        setup()
        expect(self.navigation).to(haveValidSnapshot())
    }

    func testEmptyFavoriteCharactersLayout() {
        setup(withEmptyList: true)
        expect(self.navigation).to(haveValidSnapshot())
    }

    func testTapFavorite() {
        setup()
        let index = IndexPath(row: 0, section: 0)
        sut.tapFavoriteButton(index: index, isFavorite: false, imageData: nil)

        XCTAssert(mockPresenter.hasCalledRemoveFavorite)
    }
}
