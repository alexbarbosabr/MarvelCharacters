//
//  CharactersDataViewModel.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 21/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

struct CharactersDataViewModel {
    let offset: Int
    let total: Int
    let count: Int
    var characters: [Character]
}

extension CharactersDataViewModel {
    static var empty: CharactersDataViewModel {
        CharactersDataViewModel(offset: 0,
                                total: 0,
                                count: 0,
                                characters: [Character]())
    }
}
