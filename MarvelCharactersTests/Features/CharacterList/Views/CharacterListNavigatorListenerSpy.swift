//
//  CharacterListNavigatorListenerSpy.swift
//  MarvelCharactersTests
//
//  Created by Alex Barbosa on 24/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

import Foundation
@testable import MarvelCharacters

class CharacterListNavigatorListenerMock: CharacterListNavigatorListener {
    private (set) var hasCalledGoToDetail = false
    func goToDetail(character: Character) {
        hasCalledGoToDetail = true
    }
}
