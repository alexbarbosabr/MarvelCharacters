//
//  SearchCharacterViewControllerTests.swift
//  MarvelCharactersUITests
//
//  Created by Alex Barbosa on 29/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class SearchCharacterViewControllerTests: KIFTestCase {
    override func setUp() {
        super.setUp()
        SceneDelegate.navigator?.startRootController()
    }

    func testSearhCharacter() {
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityIdentifier: "CharacterListTableView")
        tester().waitForView(withAccessibilityIdentifier: "SearchCharacterTextField")
        tester().tapView(withAccessibilityIdentifier: "SearchCharacterTextField")
        tester().enterText("Captain America", intoViewWithAccessibilityIdentifier: "SearchCharacterTextField")
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityLabel: "Captain America Cell")
        tester().tapView(withAccessibilityLabel: "Captain America FavoriteButton")
    }

    func testSearhCharacterAndGoToDetail() {
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityIdentifier: "CharacterListTableView")
        tester().waitForView(withAccessibilityIdentifier: "SearchCharacterTextField")
        tester().tapView(withAccessibilityIdentifier: "SearchCharacterTextField")
        tester().enterText("Black Cat", intoViewWithAccessibilityIdentifier: "SearchCharacterTextField")
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityLabel: "Black Cat Cell")
        tester().tapView(withAccessibilityLabel: "Black Cat Cell")
    }

    func testCancelSearch() {
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityIdentifier: "CharacterListTableView")
        tester().waitForView(withAccessibilityIdentifier: "SearchCharacterTextField")
        tester().tapView(withAccessibilityIdentifier: "SearchCharacterTextField")
        tester().tapView(withAccessibilityLabel: "Cancel")
    }
}
