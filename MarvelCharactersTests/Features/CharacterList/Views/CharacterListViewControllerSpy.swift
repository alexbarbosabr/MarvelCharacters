//
//  CharacterListViewControllerSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 22/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

@testable import MarvelCharacters

class CharacterListViewControllerSpy: CharacterListViewProtocol {
    private (set) var hasCalledShowCharacters = false
    private (set) var hasCalledShowEmptyList = false
    private (set) var hasCalledShowErrorOnScreen = false
    private (set) var hasCalledShowLoadingOnScreen = false
    private (set) var hasCalledShowErrorOnTableView = false

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
}
