//
//  SearchCharacterViewControllerSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 23/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

class SearchCharacterViewControllerSpy: SearchCharacterViewControllerProtocol {
    private (set) var hasCalledShowCharacters = false
    private (set) var hasCalledShowEmptyCharacters = false
    private (set) var hasCalledShowError = false
    private (set) var hasCalledShowLoading = false
    private (set) var hasCalledShowHideLoading = false
    private (set) var hasCalledShowSaveFavoriteError = false
    private (set) var hasCalledShowRemoveFavoriteError = false
    private (set) var hasCalledUpdateCell = false

    func showCharacters(_ data: CharactersDataViewModel) {
        hasCalledShowCharacters = true
    }

    func showEmptyCharacters() {
        hasCalledShowEmptyCharacters = true
    }

    func showError(withIcon icon: Icon, message: String) {
        hasCalledShowError = true
    }

    func showLoading() {
        hasCalledShowLoading = true
    }

    func hideLoading() {
        hasCalledShowHideLoading = true
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
}
