//
//  CharacterDetailViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 27/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

final class CharacterDetailViewControllerTests: XCTestCase {
    private var sut: CharacterDetailViewController!
    private var spyPresenter: CharacterDetailPresenterSpy!
    private var window: UIWindow!
    private var navigation: MarvelNavigationController!

    override func setUp() {
        super.setUp()
        spyPresenter = CharacterDetailPresenterSpy()
        sut = CharacterDetailViewController(presenter: spyPresenter, character: .mockWithHttpsUrl())
        navigation = MarvelNavigationController(rootViewController: sut)

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        spyPresenter = nil
        window = nil
        navigation = nil
    }

    func testDetailViewController() {
        expect(self.navigation).to(haveValidSnapshot())
    }

    func testSetFavorite() {
        sut.setFavorite(character: .mockWithHttpUrl(), isFavorite: true, imageData: nil)
        XCTAssert(spyPresenter.hasCalledSetFavorite)
    }
}
