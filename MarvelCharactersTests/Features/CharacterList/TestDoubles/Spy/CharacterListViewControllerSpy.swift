//
//  CharacterListViewControllerSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

class CharacterListViewControllerSpy: CharacterListViewProtocol {
    private (set) var hasCalledShowCharacters = false
    private (set) var hasCalledShowEmptyList = false
    private (set) var hasCalledShowErrorOnScreen = false
    private (set) var hasCalledShowLoadingOnScreen = false
    private (set) var hasCalledShowErrorOnTableView = false
    private (set) var hasCalledShowSaveFavoriteError = false
    private (set) var hasCalledShowRemoveFavoriteError = false
    private (set) var hasCalledUpdateCell = false
    private (set) var hasCalledRefreshTable = false
    private (set) var hasCalledUpdateBadgeFavoriteButton = false

    func showCharacters(_ data: CharactersDataViewModel) {
        hasCalledShowCharacters = true
    }

    func showEmptyList(withIcon icon: Icon, message: String) {
        hasCalledShowEmptyList = true
    }

    func showErrorOnScreen(withIcon icon: Icon, message: String) {
        hasCalledShowErrorOnScreen = true
    }

    func showLoadingOnScreen() {
        hasCalledShowLoadingOnScreen = true
    }

    func showErrorOnTableView() {
        hasCalledShowErrorOnTableView = true
    }

    func showSaveFavoriteError() {
        hasCalledShowSaveFavoriteError = true
    }

    func showRemoveFavoriteError() {
        hasCalledShowRemoveFavoriteError = true
    }

    func updateCell(index: IndexPath) {
        hasCalledUpdateCell = true
    }

    func refreshTable(_ data: CharactersDataViewModel) {
        hasCalledRefreshTable = true
    }

    func updateBadgeFavoriteButton(amount: Int) {
        hasCalledUpdateBadgeFavoriteButton = true
    }
}
