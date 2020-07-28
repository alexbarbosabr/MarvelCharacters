//
//  FavoriteCharactersPresenterMock.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 28/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

final class FavoriteCharactersPresenterMock: FavoriteCharactersPresenterProtocol {
    private (set) var hasCalledFetchCharacters = false
    private (set) var hasCalledRemoveFavorite = false

    weak var view: FavoriteCharactersViewProtocol?
    private var characters: [Character]

    init(characters: [Character] = [Character]()) {
        self.characters = characters
    }

    func fetchCharacters() {
        if characters.count > 0 {
            view?.showCharacters(characters)
        } else {
            view?.showEmptyList()
        }

        hasCalledFetchCharacters = true
    }

    func removeFavorite(indexPath: IndexPath) {
        hasCalledRemoveFavorite = true
    }
}
