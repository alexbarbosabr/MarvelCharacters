//
//  CharacterDetailViewControllerTests.swift
//  MarvelCharactersUITests
//
//  Created by Alex Barbosa on 29/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterDetailViewControllerTests: KIFTestCase {
    override func setUp() {
        super.setUp()
        SceneDelegate.navigator?.startRootController()
    }

    func testGoToDetail() {
        tester().waitForView(withAccessibilityIdentifier: "LoadingView")
        tester().waitForView(withAccessibilityIdentifier: "CharacterListTableView")
        tester().tapView(withAccessibilityIdentifier: "Cell1")
        tester().waitForView(withAccessibilityIdentifier: "CharacterDetailViewController")
    }
}
