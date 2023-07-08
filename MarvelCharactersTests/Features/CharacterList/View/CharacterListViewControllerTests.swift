//
//  CharacterListViewControllerTests.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import XCTest
import Nimble
import Nimble_Snapshots
@testable import MarvelCharacters

final class CharacterListViewControllerTests: XCTestCase {
    private var sut: CharacterListViewController!
    private var presenterCharacterList: CharacterListPresenter!
    private var presenterSearchCharacter: SearchCharacterPresenter!
    private var stubCharacterListService: CharacterListServiceStub!
    private var controllerSearchCharacter: SearchCharacterViewController!
    private var window: UIWindow!
    private var navigation: MarvelNavigationController!
    private var navigatorListener: CharacterListNavigatorListenerMock!
    private var snapshot: Predicate<Snapshotable>!

    override func tearDown() {
        super.tearDown()
        sut = nil
        presenterCharacterList = nil
        presenterSearchCharacter = nil
        stubCharacterListService = nil
        controllerSearchCharacter = nil
        window = nil
        navigation = nil
        navigatorListener = nil
    }

    func setupView(withError error: ServiceError? = nil, isEmpytList: Bool = false) {
        stubCharacterListService = CharacterListServiceStub()
        stubCharacterListService.shouldReturnsError = error
        stubCharacterListService.shouldReturnsEmptyList = isEmpytList
        presenterSearchCharacter = SearchCharacterPresenter(service: stubCharacterListService)
        presenterCharacterList = CharacterListPresenter(service: stubCharacterListService)
        controllerSearchCharacter = SearchCharacterViewController(presenter: presenterSearchCharacter)
        navigatorListener = CharacterListNavigatorListenerMock()

        sut = CharacterListViewController(presenter: presenterCharacterList,
                                          searchViewController: controllerSearchCharacter,
                                          navigatorListener: navigatorListener)
        presenterCharacterList.view = sut
        navigation = MarvelNavigationController(rootViewController: sut)
        snapshot = haveValidSnapshot()

        window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

    func testCharacterListViewControllerLayout() {
        setupView(withError: nil)
        expect(self.navigation).to(snapshot)
    }

    func testCharacterListViewControllerEmptyListLayout() {
        setupView(isEmpytList: true)
        expect(self.navigation).to(snapshot)
    }

    func testCharacterListViewControllerNoConnectionLayout() {
        setupView(withError: .noInternetConnection)
        expect(self.navigation).to(snapshot)
    }

    func testCharacterListViewControllerGenericErrorLayout() {
        setupView(withError: .unexpected)
        expect(self.navigation).to(snapshot)
    }
}
