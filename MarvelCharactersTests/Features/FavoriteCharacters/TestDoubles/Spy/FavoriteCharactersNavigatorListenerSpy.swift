//
//  FavoriteCharactersNavigatorListenerSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 27/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

final class FavoriteCharactersNavigatorListenerSpy: FavoriteCharactersNavigatorListener {
    private (set) var hasCalledGoToDetail = false

    func goToDetail(character: Character) {
        hasCalledGoToDetail = true
    }
}
