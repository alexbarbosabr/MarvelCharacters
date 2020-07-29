//
//  FavoriteCharactersViewControllerTests.swift
//  MarvelCharactersUITests
//
//  Created by Alex Barbosa on 29/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class FavoriteCharactersViewControllerTests: KIFTestCase {
    override func setUp() {
        super.setUp()
        SceneDelegate.navigator?.startRootController()
    }

    func testGoToFavorites() {
        tester().tapView(withAccessibilityIdentifier: "FavoriteBarButton")
        tester().waitForView(withAccessibilityIdentifier: "FavoriteCharactersEmptyView")
    }
}
