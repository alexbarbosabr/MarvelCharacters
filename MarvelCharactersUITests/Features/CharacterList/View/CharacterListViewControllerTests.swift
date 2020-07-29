//
//  CharacterListViewControllerTests.swift
//  MarvelCharactersUITests
//
//  Created by Alex Barbosa on 28/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterListViewControllerTests: KIFTestCase {
    override func setUp() {
        super.setUp()
        SceneDelegate.navigator?.startRootController()
    }

    func testCharacterListViewController() {
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityIdentifier: "CharacterListTableView")
        tester().waitForView(withAccessibilityIdentifier: "FavoriteBarButton")
    }

    func testSetFavoriteCharacter() {
        tester().waitForView(withAccessibilityIdentifier: "Cell1")
        tester().tapView(withAccessibilityIdentifier: "FavoriteButton1")
    }

    func testScrollTableViewUntilShowLoading() {
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityIdentifier: "CharacterListTableView")
        tester().scrollView(withAccessibilityIdentifier: "CharacterListTableView",
                            byFractionOfSizeHorizontal: 0,
                            vertical: 1000)
        tester().waitForView(withAccessibilityIdentifier: "LoadingCell")
    }
}
