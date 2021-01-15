//
//  FavoriteCharactersViewControllerSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 28/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

@testable import MarvelCharacters

final class FavoriteCharactersViewControllerSpy: FavoriteCharactersViewProtocol {
    private (set) var hasCalledShowEmptyList = false
    private (set) var hasCalledShowCharacters = false
    private (set) var hasCalledShowRemoveFavoriteError = false

    func showEmptyList() {
        hasCalledShowEmptyList = true
    }

    func showCharacters(_ characters: [Character]) {
        hasCalledShowCharacters = true
    }

    func showRemoveFavoriteError() {
        hasCalledShowRemoveFavoriteError = true
    }
}
