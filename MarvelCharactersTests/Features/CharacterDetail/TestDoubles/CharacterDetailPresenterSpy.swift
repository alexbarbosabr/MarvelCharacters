//
//  CharacterDetailPresenterSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 27/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

final class CharacterDetailPresenterSpy: CharacterDetailPresenterProtocol {
    private (set) var hasCalledSetFavorite = false

    func setFavorite(character: Character, isFavorite: Bool, imageData: Data?) {
        hasCalledSetFavorite = true
    }
}
