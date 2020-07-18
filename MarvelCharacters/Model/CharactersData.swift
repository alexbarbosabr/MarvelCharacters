//
//  CharactersData.swift
//  MarvelCharacters
//
//  Created by Alex Barbosa on 18/07/20.
//  Copyright © 2020 Alex Barbosa. All rights reserved.
//

struct CharactersData: Codable {
    let data: CharacterData

    public struct CharacterData: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Character]
    }
}
